import 'package:flutter/material.dart';

import '../../../child_record.dart';
import '../../models/record_draft.dart';

/// EditableRecordSheetViewModel の引数
@immutable
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

/// EditableRecordSheetViewModel の状態
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

  /// 初期状態を構築
  static EditableRecordSheetState initial({
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
}
