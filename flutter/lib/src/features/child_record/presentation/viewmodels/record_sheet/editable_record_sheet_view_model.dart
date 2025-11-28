import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../menu/children/application/child_context_provider.dart';
import '../../../child_record.dart';
import '../../models/record_draft.dart';
import '../../providers/record_tag_controller.dart';
import 'editable_record_sheet_state.dart';

export 'editable_record_sheet_state.dart';

part 'editable_record_sheet_view_model.g.dart';

@riverpod
class EditableRecordSheetViewModel extends _$EditableRecordSheetViewModel {
  @override
  EditableRecordSheetState build(EditableRecordSheetViewModelArgs args) {
    return EditableRecordSheetState.initial(
      initialDraft: args.initialDraft,
      isNew: args.isNew,
    );
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
    final householdId = ref.read(childContextProvider).value?.householdId;
    if (householdId != null) {
      final availableTags =
          ref.read(recordTagControllerProvider(householdId)).value;
      if (availableTags != null) {
        syncSelectedTags(availableTags);
      }
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
