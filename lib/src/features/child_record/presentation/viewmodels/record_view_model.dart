import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/usecases/add_record.dart';
import '../../application/usecases/delete_record.dart';
import '../../application/usecases/get_records_for_day.dart';
import '../../child_record.dart';
import '../../infrastructure/repositories/child_record_repository_impl.dart';
import '../../infrastructure/sources/record_firestore_data_source.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../../menu/children/data/infrastructure/child_firestore_data_source.dart';
import '../../../../core/firebase/household_service.dart' as fbcore;
import '../mappers/record_ui_mapper.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';
import 'record_state.dart';

const String _tagsCollectionName = 'tags';

final recordUiMapperProvider = Provider<RecordUiMapper>((_) {
  return const RecordUiMapper();
});

final _recordFirestoreDataSourceProvider =
    Provider.family<RecordFirestoreDataSource, String>((ref, hid) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  return RecordFirestoreDataSource(db, hid);
});

final childRecordRepositoryProvider =
    Provider.family<ChildRecordRepository, String>((ref, hid) {
  final remote = ref.watch(_recordFirestoreDataSourceProvider(hid));
  return ChildRecordRepositoryImpl(remote: remote);
});

final addRecordUseCaseProvider = Provider.family<AddRecord, String>(
    (ref, hid) => AddRecord(ref.watch(childRecordRepositoryProvider(hid))));
final getRecordsForDayUseCaseProvider =
    Provider.family<GetRecordsForDay, String>((ref, hid) =>
        GetRecordsForDay(ref.watch(childRecordRepositoryProvider(hid))));
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

  FirebaseFirestore get _db => _ref.read(fbcore.firebaseFirestoreProvider);

  void _initialize() {
    _listenToSelectedChild();
    unawaited(_loadInitialData());
  }

  void _listenToSelectedChild() {
    _ref.listen<AsyncValue<String?>>(
      selectedChildControllerProvider,
      (previous, next) {
        final newId = next.valueOrNull;
        if (newId == state.selectedChildId) {
          return;
        }
        state = state.copyWith(
          selectedChildId: newId,
          pendingUiEvent: null,
        );
        final hid = state.householdId;
        if (hid == null) {
          return;
        }
        if (newId == null || newId.isEmpty) {
          state = state.copyWith(
            recordsAsync: const AsyncValue<List<RecordItemModel>>.data(
                <RecordItemModel>[]),
          );
          return;
        }
        unawaited(
          _fetchRecords(
            householdId: hid,
            childId: newId,
            date: state.selectedDate,
          ),
        );
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

  Future<void> _loadInitialData() async {
    final previousRecords = state.recordsAsync;
    final previousTags = state.otherTagsAsync;
    state = state.copyWith(
      recordsAsync: const AsyncValue<List<RecordItemModel>>.loading()
          .copyWithPrevious(previousRecords),
      otherTagsAsync: const AsyncValue<List<String>>.loading()
          .copyWithPrevious(previousTags),
    );
    try {
      final householdId =
          await _ref.read(fbcore.currentHouseholdIdProvider.future);
      state = state.copyWith(householdId: householdId);
      final childId = await _ensureActiveChild(
        householdId: householdId,
        watchSelected: true,
      );
      if (childId != null) {
        await _fetchRecords(
          householdId: householdId,
          childId: childId,
          date: state.selectedDate,
          keepPrevious: false,
        );
      } else {
        state = state.copyWith(
          recordsAsync:
              const AsyncValue<List<RecordItemModel>>.data(<RecordItemModel>[]),
        );
      }
      await _loadOtherTags(householdId);
    } catch (error, stackTrace) {
      state = state.copyWith(
        recordsAsync: AsyncValue.error(error, stackTrace),
        pendingUiEvent: const RecordUiEvent.showMessage('記録の読み込みに失敗しました'),
      );
    }
  }

  Future<void> refresh() async {
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }
    final childId = await _ensureActiveChild(
      householdId: householdId,
      watchSelected: false,
    );
    if (childId == null) {
      state = state.copyWith(
        recordsAsync:
            const AsyncValue<List<RecordItemModel>>.data(<RecordItemModel>[]),
      );
      return;
    }
    await Future.wait([
      _fetchRecords(
        householdId: householdId,
        childId: childId,
        date: state.selectedDate,
      ),
      _loadOtherTags(householdId),
    ]);
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
    final householdId = await _requireHouseholdId();
    final childId = state.selectedChildId;
    if (householdId != null && childId != null && childId.isNotEmpty) {
      await _fetchRecords(
        householdId: householdId,
        childId: childId,
        date: normalized,
      );
    }
  }

  Future<void> addOrUpdateRecord(RecordDraft draft) async {
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }
    final childId = await _ensureActiveChild(
      householdId: householdId,
      watchSelected: false,
    );
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
      if (shouldDeletePrevious && deleteUseCase != null) {
        await deleteUseCase(childId, previousId);
      }
      await _fetchRecords(
        householdId: householdId,
        childId: childId,
        date: state.selectedDate,
      );
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: RecordUiEvent.showMessage(
          draft.id == null ? '記録を追加しました' : '記録を更新しました',
        ),
      );
    } catch (_) {
      state = state.copyWith(
        isProcessing: false,
      );
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('記録の保存に失敗しました'),
      );
      // Optionally log error with stackTrace
    }
  }

  Future<void> deleteRecord(String recordId) async {
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }
    final childId = await _ensureActiveChild(
      householdId: householdId,
      watchSelected: false,
    );
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
      await _fetchRecords(
        householdId: householdId,
        childId: childId,
        date: state.selectedDate,
      );
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録を削除しました'),
      );
    } catch (_) {
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const RecordUiEvent.showMessage('記録の削除に失敗しました'),
      );
      // Optionally log error with stackTrace
    }
  }

  Future<void> addTag(String tag) async {
    final normalized = tag.trim();
    if (normalized.isEmpty) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('タグ名を入力してください'),
      );
      return;
    }
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }

    final currentTags =
        List.of(state.otherTagsAsync.valueOrNull ?? const <String>[]);
    if (currentTags.contains(normalized)) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('既に同じタグが登録されています'),
      );
      return;
    }

    try {
      await _tagCollection(householdId).doc(normalized).set({
        'name': normalized,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      currentTags.add(normalized);
      currentTags.sort();
      state = state.copyWith(
        otherTagsAsync: AsyncValue.data(
          List.unmodifiable(currentTags),
        ),
      );
    } catch (_) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('タグの追加に失敗しました'),
      );
    }
  }

  Future<void> removeTag(String tag) async {
    final householdId = await _requireHouseholdId();
    if (householdId == null) {
      return;
    }
    final currentTags =
        List.of(state.otherTagsAsync.valueOrNull ?? const <String>[]);
    if (!currentTags.contains(tag)) {
      return;
    }
    try {
      await _tagCollection(householdId).doc(tag).delete();
      currentTags.remove(tag);
      state = state.copyWith(
        otherTagsAsync: AsyncValue.data(
          List.unmodifiable(currentTags),
        ),
      );
    } catch (_) {
      state = state.copyWith(
        pendingUiEvent: const RecordUiEvent.showMessage('タグの削除に失敗しました'),
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

    final records = state.records
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

  Future<String?> _ensureActiveChild({
    required String householdId,
    required bool watchSelected,
  }) async {
    final selected = watchSelected
        ? await _ref.watch(selectedChildControllerProvider.future)
        : await _ref.read(selectedChildControllerProvider.future);
    if (selected != null && selected.isNotEmpty) {
      state = state.copyWith(selectedChildId: selected);
      return selected;
    }

    final ds = ChildFirestoreDataSource(
      _db,
      householdId,
    );
    final snap = await ds.childrenQuery().limit(1).get();
    if (snap.docs.isEmpty) {
      state = state.copyWith(selectedChildId: null);
      return null;
    }
    final firstId = snap.docs.first.id;
    await _ref.read(selectedChildControllerProvider.notifier).select(firstId);
    state = state.copyWith(selectedChildId: firstId);
    return firstId;
  }

  Future<void> _fetchRecords({
    required String householdId,
    required String childId,
    required DateTime date,
    bool keepPrevious = true,
  }) async {
    if (!mounted) return;
    final previous = state.recordsAsync;
    const loading = AsyncValue<List<RecordItemModel>>.loading();
    if (!mounted) return;
    state = state.copyWith(
      recordsAsync: keepPrevious ? loading.copyWithPrevious(previous) : loading,
    );
    final getRecords = _ref.read(getRecordsForDayUseCaseProvider(householdId));
    try {
      final records = await getRecords(childId, date);
      final items = records.map(_mapper.toUiModel).toList(growable: false);
      if (!mounted) return;
      state = state.copyWith(
        recordsAsync: AsyncValue.data(items),
      );
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = state.copyWith(
        recordsAsync: AsyncValue.error(error, stackTrace),
        pendingUiEvent: const RecordUiEvent.showMessage('記録の取得に失敗しました'),
      );
    }
  }

  Future<void> _loadOtherTags(String householdId) async {
    if (!mounted) return;
    final previous = state.otherTagsAsync;
    if (!mounted) return;
    state = state.copyWith(
      otherTagsAsync:
          const AsyncValue<List<String>>.loading().copyWithPrevious(previous),
    );
    try {
      final snap = await _tagCollection(householdId).orderBy('name').get();
      final tags = snap.docs
          .map((doc) => (doc.data()['name'] as String?)?.trim())
          .whereType<String>()
          .where((name) => name.isNotEmpty)
          .toList(growable: true);
      tags.sort();
      if (!mounted) return;
      state = state.copyWith(
        otherTagsAsync: AsyncValue.data(
          List.unmodifiable(tags),
        ),
      );
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = state.copyWith(
        otherTagsAsync: AsyncValue.error(error, stackTrace),
        pendingUiEvent: const RecordUiEvent.showMessage('タグの取得に失敗しました'),
      );
    }
  }

  CollectionReference<Map<String, dynamic>> _tagCollection(
    String householdId,
  ) {
    return _db
        .collection('households')
        .doc(householdId)
        .collection(_tagsCollectionName);
  }
}
