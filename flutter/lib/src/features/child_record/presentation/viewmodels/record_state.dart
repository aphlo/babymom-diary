import 'package:freezed_annotation/freezed_annotation.dart';

import '../../child_record.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';

part 'record_state.freezed.dart';

@freezed
sealed class RecordSlotRequest with _$RecordSlotRequest {
  const factory RecordSlotRequest({
    required DateTime date,
    required int hour,
    required RecordType type,
    required List<RecordItemModel> records,
  }) = _RecordSlotRequest;
}

@freezed
sealed class RecordEditorRequest with _$RecordEditorRequest {
  const factory RecordEditorRequest({
    required RecordDraft draft,
    required bool isNew,
  }) = _RecordEditorRequest;
}

/// 離乳食エディター表示のリクエスト
@freezed
sealed class BabyFoodEditorRequest with _$BabyFoodEditorRequest {
  const factory BabyFoodEditorRequest({
    required DateTime initialDateTime,
  }) = _BabyFoodEditorRequest;
}

@freezed
sealed class RecordUiEvent with _$RecordUiEvent {
  const factory RecordUiEvent({
    String? message,
    RecordSlotRequest? openSlot,
    RecordEditorRequest? openEditor,
    BabyFoodEditorRequest? openBabyFoodEditor,
  }) = _RecordUiEvent;

  factory RecordUiEvent.showMessage(String message) =>
      RecordUiEvent(message: message);

  factory RecordUiEvent.openSlot(RecordSlotRequest request) =>
      RecordUiEvent(openSlot: request);

  factory RecordUiEvent.openEditor(RecordEditorRequest request) =>
      RecordUiEvent(openEditor: request);

  factory RecordUiEvent.openBabyFoodEditor(BabyFoodEditorRequest request) =>
      RecordUiEvent(openBabyFoodEditor: request);
}

@freezed
sealed class RecordPageState with _$RecordPageState {
  const factory RecordPageState({
    required DateTime selectedDate,
    required int selectedTabIndex,
    @Default(false) bool isProcessing,
    RecordUiEvent? pendingUiEvent,
    RecordDraft? activeDraft,
  }) = _RecordPageState;

  factory RecordPageState.initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month, now.day);
    return RecordPageState(
      selectedDate: normalized,
      selectedTabIndex: 0,
    );
  }
}
