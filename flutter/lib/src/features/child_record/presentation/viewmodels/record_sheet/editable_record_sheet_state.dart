import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../child_record.dart';
import '../../models/record_draft.dart';

part 'editable_record_sheet_state.freezed.dart';

/// EditableRecordSheetViewModel の引数
@freezed
sealed class EditableRecordSheetViewModelArgs
    with _$EditableRecordSheetViewModelArgs {
  const factory EditableRecordSheetViewModelArgs({
    required RecordDraft initialDraft,
    required bool isNew,
  }) = _EditableRecordSheetViewModelArgs;
}

/// EditableRecordSheetViewModel の状態
@freezed
sealed class EditableRecordSheetState with _$EditableRecordSheetState {
  const EditableRecordSheetState._();

  const factory EditableRecordSheetState({
    required RecordDraft draft,
    required TimeOfDay timeOfDay,
    required String minutesInput,
    required String amountInput,
    required String noteInput,
    required Set<String> selectedTags,
    ExcretionVolume? selectedVolume,
    String? durationError,
    String? volumeError,
  }) = _EditableRecordSheetState;

  RecordType get type => draft.type;

  /// 初期状態を構築
  factory EditableRecordSheetState.initial({
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
