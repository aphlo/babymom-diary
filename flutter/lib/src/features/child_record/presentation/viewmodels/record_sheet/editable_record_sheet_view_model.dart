import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../child_record.dart';
import '../../models/record_draft.dart';
import '../record_view_model.dart';

class EditableRecordSheetViewModelArgs {
  const EditableRecordSheetViewModelArgs({
    required this.initialDraft,
    required this.isNew,
  });

  final RecordDraft initialDraft;
  final bool isNew;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EditableRecordSheetViewModelArgs &&
        other.initialDraft == initialDraft &&
        other.isNew == isNew;
  }

  @override
  int get hashCode => Object.hash(initialDraft, isNew);
}

@immutable
class EditableRecordSheetState {
  EditableRecordSheetState({
    required this.draft,
    required this.timeOfDay,
    required this.minutesInput,
    required this.amountInput,
    required this.noteInput,
    required Set<String> selectedTags,
    this.selectedVolume,
    this.durationError,
    this.volumeError,
  }) : selectedTags = Set.unmodifiable(selectedTags);

  final RecordDraft draft;
  final TimeOfDay timeOfDay;
  final String minutesInput;
  final String amountInput;
  final String noteInput;
  final Set<String> selectedTags;
  final ExcretionVolume? selectedVolume;
  final String? durationError;
  final String? volumeError;

  static const Object _sentinel = Object();

  RecordType get type => draft.type;

  EditableRecordSheetState copyWith({
    RecordDraft? draft,
    TimeOfDay? timeOfDay,
    String? minutesInput,
    String? amountInput,
    String? noteInput,
    Set<String>? selectedTags,
    Object? selectedVolume = _sentinel,
    Object? durationError = _sentinel,
    Object? volumeError = _sentinel,
  }) {
    return EditableRecordSheetState(
      draft: draft ?? this.draft,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      minutesInput: minutesInput ?? this.minutesInput,
      amountInput: amountInput ?? this.amountInput,
      noteInput: noteInput ?? this.noteInput,
      selectedTags: selectedTags != null
          ? Set.unmodifiable(selectedTags)
          : this.selectedTags,
      selectedVolume: selectedVolume == _sentinel
          ? this.selectedVolume
          : selectedVolume as ExcretionVolume?,
      durationError: durationError == _sentinel
          ? this.durationError
          : durationError as String?,
      volumeError:
          volumeError == _sentinel ? this.volumeError : volumeError as String?,
    );
  }
}

final editableRecordSheetViewModelProvider =
    AutoDisposeStateNotifierProviderFamily<
        EditableRecordSheetViewModel,
        EditableRecordSheetState,
        EditableRecordSheetViewModelArgs>((ref, args) {
  return EditableRecordSheetViewModel(
    ref,
    initialDraft: args.initialDraft,
    isNew: args.isNew,
  );
});

class EditableRecordSheetViewModel
    extends StateNotifier<EditableRecordSheetState> {
  EditableRecordSheetViewModel(
    this._ref, {
    required RecordDraft initialDraft,
    required bool isNew,
  }) : super(_buildInitialState(initialDraft: initialDraft, isNew: isNew));

  final Ref _ref;

  static EditableRecordSheetState _buildInitialState({
    required RecordDraft initialDraft,
    required bool isNew,
  }) {
    final initial = initialDraft.at.toLocal();
    final now = DateTime.now();
    // 新規作成時: 現在時刻の時間（hour）であれば現在の分、それ以外は0分
    // 編集時: 元の時間をそのまま使用
    final initialMinute =
        isNew ? (initial.hour == now.hour ? now.minute : 0) : initial.minute;
    final timeOfDay = TimeOfDay(hour: initial.hour, minute: initialMinute);

    final recordType = initialDraft.type;
    final minutesInput = switch (recordType) {
      RecordType.breastLeft ||
      RecordType.breastRight =>
        _formatMinutes(initialDraft.amount),
      _ => '0',
    };
    final amountInput = switch (recordType) {
      RecordType.formula ||
      RecordType.pump ||
      RecordType.temperature =>
        _formatAmount(initialDraft.amount),
      _ => '',
    };
    final noteInput = initialDraft.note ?? '';
    final selectedVolume = initialDraft.excretionVolume;
    final selectedTags = Set<String>.from(initialDraft.tags);

    return EditableRecordSheetState(
      draft: initialDraft,
      timeOfDay: timeOfDay,
      minutesInput: minutesInput,
      amountInput: amountInput,
      noteInput: noteInput,
      selectedVolume: selectedVolume,
      selectedTags: selectedTags,
      durationError: null,
      volumeError: null,
    );
  }

  static String _formatAmount(double? amount) {
    if (amount == null) {
      return '';
    }
    if (amount == amount.roundToDouble()) {
      return amount.toStringAsFixed(0);
    }
    return '$amount';
  }

  static String _formatMinutes(double? minutes) {
    if (minutes == null || minutes == 0) {
      return '';
    }
    if (minutes == minutes.roundToDouble()) {
      return minutes.toInt().toString();
    }
    return '$minutes';
  }

  void setTimeOfDay(TimeOfDay value) {
    state = state.copyWith(timeOfDay: value);
  }

  void updateMinutesInput(String value) {
    if (state.minutesInput == value) {
      return;
    }
    state = state.copyWith(minutesInput: value);
  }

  void updateAmountInput(String value) {
    if (state.amountInput == value) {
      return;
    }
    state = state.copyWith(amountInput: value);
  }

  void updateNoteInput(String value) {
    if (state.noteInput == value) {
      return;
    }
    state = state.copyWith(noteInput: value);
  }

  void selectVolume(ExcretionVolume? volume) {
    state = state.copyWith(
      selectedVolume: volume,
      volumeError: null,
    );
  }

  void toggleTag(String tag, bool isSelected) {
    final next = Set<String>.from(state.selectedTags);
    if (isSelected) {
      next.add(tag);
    } else {
      next.remove(tag);
    }
    state = state.copyWith(selectedTags: next);
  }

  void resetValidationErrors() {
    state = state.copyWith(
      durationError: null,
      volumeError: null,
    );
  }

  void syncSelectedTags(Iterable<String>? availableTags) {
    if (availableTags == null) {
      return;
    }
    final filtered =
        state.selectedTags.where((tag) => availableTags.contains(tag)).toSet();
    if (setEquals(filtered, state.selectedTags)) {
      return;
    }
    state = state.copyWith(selectedTags: filtered);
  }

  RecordDraft? submit() {
    final base = state.draft;
    final selectedDate = base.at;
    final at = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      state.timeOfDay.hour,
      state.timeOfDay.minute,
    );

    return switch (base.type) {
      RecordType.breastLeft ||
      RecordType.breastRight =>
        _buildBreastRecord(base, at),
      RecordType.formula || RecordType.pump => _buildAmountRecord(base, at),
      RecordType.temperature => _buildAmountRecord(base, at),
      RecordType.pee || RecordType.poop => _buildExcretionRecord(base, at),
      RecordType.other => _buildOtherRecord(base, at),
    };
  }

  RecordDraft? _buildBreastRecord(RecordDraft base, DateTime at) {
    final minutes = int.tryParse(state.minutesInput) ?? 0;
    if (minutes < 0) {
      state = state.copyWith(durationError: '0以上の値を入力してください');
      return null;
    }
    return base.copyWith(
      at: at,
      amount: minutes.toDouble(),
      note: _noteOrNull(),
    );
  }

  RecordDraft? _buildAmountRecord(RecordDraft base, DateTime at) {
    final amount = double.tryParse(state.amountInput);
    if (amount == null || amount <= 0) {
      return null;
    }
    return base.copyWith(
      at: at,
      amount: amount,
      note: _noteOrNull(),
    );
  }

  RecordDraft? _buildExcretionRecord(RecordDraft base, DateTime at) {
    final volume = state.selectedVolume;
    if (volume == null) {
      state = state.copyWith(volumeError: '量の目安を選択してください');
      return null;
    }
    return base.copyWith(
      at: at,
      excretionVolume: volume,
      note: _noteOrNull(),
    );
  }

  RecordDraft _buildOtherRecord(RecordDraft base, DateTime at) {
    final availableTags =
        _ref.read(recordViewModelProvider).otherTagsAsync.valueOrNull;
    if (availableTags != null) {
      syncSelectedTags(availableTags);
    }
    final tags = state.selectedTags.toList(growable: false);
    return base.copyWith(
      at: at,
      tags: tags,
      note: _noteOrNull(),
    );
  }

  String? _noteOrNull() {
    final trimmed = state.noteInput.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
