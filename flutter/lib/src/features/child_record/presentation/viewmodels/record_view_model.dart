import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../application/usecases/add_record.dart';
import '../../application/usecases/delete_record.dart';
import '../../child_record.dart';
import '../../infrastructure/repositories/child_record_repository_impl.dart';
import '../../infrastructure/sources/record_firestore_data_source.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../../menu/children/presentation/providers/ensure_active_child_provider.dart';
import '../../../../core/firebase/household_service.dart' as fbcore;
import '../mappers/record_ui_mapper.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';
import 'record_state.dart';

final recordUiMapperProvider = Provider<RecordUiMapper>((_) {
  return const RecordUiMapper();
});

final childRecordRepositoryProvider =
    Provider.family<ChildRecordRepository, String>((ref, hid) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  final remote = RecordFirestoreDataSource(db, hid);
  return ChildRecordRepositoryImpl(remote: remote);
});

final addRecordUseCaseProvider = Provider.family<AddRecord, String>(
    (ref, hid) => AddRecord(ref.watch(childRecordRepositoryProvider(hid))));
final deleteRecordUseCaseProvider = Provider.family<DeleteRecord, String>(
    (ref, hid) => DeleteRecord(ref.watch(childRecordRepositoryProvider(hid))));

final recordViewModelProvider =
    StateNotifierProvider<RecordViewModel, RecordPageState>((ref) {
  final mapper = ref.watch(recordUiMapperProvider);
  return RecordViewModel(ref, mapper);
});

class RecordViewModel extends StateNotifier<RecordPageState> {
  RecordViewModel(this._ref, this._mapper) : super(RecordPageState.initial()) {
    _initialize();
  }

  final Ref _ref;
  final RecordUiMapper _mapper;

  void _initialize() {
    _listenToChildContext();
  }

  /// ChildContextProviderを監視し、householdId/子供の変更に対応
  void _listenToChildContext() {
    _ref.listen<AsyncValue<ChildContext>>(
      childContextProvider,
      (previous, next) {
        if (!mounted) return;

        final previousContext = previous?.value;
        final currentContext = next.value;

        if (currentContext == null) return;

        final householdChanged =
            previousContext?.householdId != currentContext.householdId;
        final childChanged =
            previousContext?.selectedChildId != currentContext.selectedChildId;

        // householdIdが変わった場合
        if (householdChanged) {
          state = state.copyWith(
            householdId: currentContext.householdId,
            selectedChildId: currentContext.selectedChildId,
          );
        }

        // 子供が変わった場合
        if (childChanged && !householdChanged) {
          state = state.copyWith(
            selectedChildId: currentContext.selectedChildId,
            pendingUiEvent: null,
          );
        }
      },
      fireImmediately: true,
    );
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
    // 日付変更で Widget 側の dailyRecordsProvider が自動的に再購読
  }

  Future<void> addOrUpdateRecord(RecordDraft draft) async {
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }
    final childId = await _ensureActiveChild(householdId);
    if (childId == null) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('子どもの情報が見つかりません'),
      );
      return;
    }
    state = state.copyWith(isProcessing: true, pendingUiEvent: null);
    final upsert = _ref.read(addRecordUseCaseProvider(householdId));
    final previousId = draft.id;
    final record = _mapper.toDomain(draft);
    final shouldDeletePrevious = previousId != null && previousId != record.id;
    final deleteUseCase = shouldDeletePrevious
        ? _ref.read(deleteRecordUseCaseProvider(householdId))
        : null;
    try {
      await upsert(childId, record);
      if (!mounted) return;
      if (shouldDeletePrevious && deleteUseCase != null) {
        await deleteUseCase(childId, previousId);
        if (!mounted) return;
      }
      // Streamが自動的に更新されるので_fetchRecordsは不要
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: RecordUiEvent.showMessage(
          draft.id == null ? '記録を追加しました' : '記録を更新しました',
        ),
      );
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録の保存に失敗しました'),
      );
    }
  }

  Future<void> deleteRecord(String recordId) async {
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }
    final childId = await _ensureActiveChild(householdId);
    if (childId == null) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('子どもの情報が見つかりません'),
      );
      return;
    }
    state = state.copyWith(isProcessing: true, pendingUiEvent: null);
    final delete = _ref.read(deleteRecordUseCaseProvider(householdId));
    try {
      await delete(childId, recordId);
      if (!mounted) return;
      // Streamが自動的に更新されるので_fetchRecordsは不要
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録を削除しました'),
      );
    } catch (_) {
      if (!mounted) return;
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
    // 子供が登録されているかチェック
    final childId = state.selectedChildId;
    if (childId == null || childId.isEmpty) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage(
          '記録を行うには、メニューから子どもを登録してください。',
        ),
      );
      return;
    }

    final records = allRecords
        .where((record) => record.type == type && record.at.hour == hour)
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

  Future<String?> _requireHouseholdId() async {
    final existing = state.householdId;
    if (existing != null) {
      return existing;
    }
    try {
      final householdId =
          await _ref.read(fbcore.currentHouseholdIdProvider.future);
      state = state.copyWith(householdId: householdId);
      return householdId;
    } catch (_) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('世帯情報の取得に失敗しました'),
      );
      return null;
    }
  }

  Future<String?> _ensureActiveChild(String householdId) async {
    final currentSelected =
        await _ref.read(selectedChildControllerProvider.future);
    final useCase = _ref.read(ensureActiveChildProvider);

    final childId = await useCase(
      householdId: householdId,
      currentSelectedId: currentSelected,
      onSelect: (id) async {
        await _ref.read(selectedChildControllerProvider.notifier).select(id);
        if (mounted) {
          state = state.copyWith(selectedChildId: id);
        }
      },
    );

    if (childId != null && mounted) {
      state = state.copyWith(selectedChildId: childId);
    }
    return childId;
  }
}
