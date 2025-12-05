import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../child_record.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../mappers/record_ui_mapper.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';
import '../providers/child_record_providers.dart';
import 'record_state.dart';

part 'record_view_model.g.dart';

@Riverpod(keepAlive: true)
class RecordViewModel extends _$RecordViewModel {
  @override
  RecordPageState build() {
    return RecordPageState.initial();
  }

  void onSelectTab(int index) {
    if (index == state.selectedTabIndex) {
      return;
    }
    state = state.copyWith(
      selectedTabIndex: index,
      pendingUiEvent: null,
    );
  }

  Future<void> onSelectDate(DateTime date) async {
    final normalized = DateTime(date.year, date.month, date.day);
    if (normalized.isAtSameMomentAs(state.selectedDate)) {
      return;
    }
    state = state.copyWith(
      selectedDate: normalized,
      pendingUiEvent: null,
    );
  }

  Future<void> addOrUpdateRecord(RecordDraft draft) async {
    final context = ref.read(childContextProvider).value;
    if (context == null) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('データの読み込み中です'),
      );
      return;
    }

    final householdId = context.householdId;
    final childId = context.selectedChildId;
    if (childId == null || childId.isEmpty) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('子どもの情報が見つかりません'),
      );
      return;
    }

    state = state.copyWith(isProcessing: true, pendingUiEvent: null);
    const mapper = RecordUiMapper();
    final previousId = draft.id;
    final record = mapper.toDomain(draft);
    final shouldDeletePrevious = previousId != null && previousId != record.id;
    try {
      final addRecordWithSync =
          ref.read(addRecordWithWidgetSyncProvider(householdId));
      await addRecordWithSync(childId: childId, record: record);
      if (shouldDeletePrevious) {
        final deleteRecordWithSync =
            ref.read(deleteRecordWithWidgetSyncProvider(householdId));
        await deleteRecordWithSync(childId: childId, id: previousId);
      }
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: RecordUiEvent.showMessage(
          draft.id == null ? '記録を追加しました' : '記録を更新しました',
        ),
      );
    } catch (_) {
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録の保存に失敗しました'),
      );
    }
  }

  Future<void> deleteRecord(String recordId) async {
    final context = ref.read(childContextProvider).value;
    if (context == null) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('データの読み込み中です'),
      );
      return;
    }

    final householdId = context.householdId;
    final childId = context.selectedChildId;
    if (childId == null || childId.isEmpty) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('子どもの情報が見つかりません'),
      );
      return;
    }

    state = state.copyWith(isProcessing: true, pendingUiEvent: null);
    try {
      final deleteRecordWithSync =
          ref.read(deleteRecordWithWidgetSyncProvider(householdId));
      await deleteRecordWithSync(childId: childId, id: recordId);
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録を削除しました'),
      );
    } catch (_) {
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録の削除に失敗しました'),
      );
    }
  }

  void openCreateRecord({
    required RecordType type,
    required DateTime initialDateTime,
  }) {
    final draft = RecordDraft(
      type: type,
      at: initialDateTime,
    );
    state = state.copyWith(
      activeDraft: draft,
      pendingUiEvent: RecordUiEvent.openEditor(
          RecordEditorRequest(draft: draft, isNew: true)),
    );
  }

  void openEditRecord(RecordItemModel item) {
    final draft = RecordDraft(
      id: item.id,
      type: item.type,
      at: item.at,
      amount: item.amount,
      note: item.note,
      excretionVolume: item.excretionVolume,
      tags: item.tags,
    );
    state = state.copyWith(
      activeDraft: draft,
      pendingUiEvent: RecordUiEvent.openEditor(
          RecordEditorRequest(draft: draft, isNew: false)),
    );
  }

  void openSlotDetails({
    required int hour,
    required RecordType type,
    required List<RecordItemModel> allRecords,
  }) {
    final context = ref.read(childContextProvider).value;
    if (context == null || !context.hasSelectedChild) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage(
          '記録を行うには、メニューから子どもを登録してください。',
        ),
      );
      return;
    }

    final targetTypes =
        (type == RecordType.breastLeft || type == RecordType.breastRight)
            ? [RecordType.breastLeft, RecordType.breastRight]
            : [type];

    final records = allRecords
        .where((record) =>
            targetTypes.contains(record.type) && record.at.hour == hour)
        .toList(growable: false)
      ..sort((a, b) => a.at.compareTo(b.at));
    final request = RecordSlotRequest(
      date: state.selectedDate,
      hour: hour,
      type: type,
      records: records,
    );
    state = state.copyWith(
      pendingUiEvent: RecordUiEvent.openSlot(request),
    );
  }

  void clearUiEvent() {
    if (state.pendingUiEvent != null) {
      state = state.copyWith(pendingUiEvent: null);
    }
  }
}
