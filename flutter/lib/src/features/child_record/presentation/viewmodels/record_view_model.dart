import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/usecases/add_record.dart';
import '../../application/usecases/delete_record.dart';
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
  StreamSubscription<List<Record>>? _recordsSubscription;

  FirebaseFirestore get _db => _ref.read(fbcore.firebaseFirestoreProvider);

  @override
  void dispose() {
    _recordsSubscription?.cancel();
    super.dispose();
  }

  void _initialize() {
    _listenToHouseholdChange();
    _listenToSelectedChild();
    unawaited(_loadInitialData());
  }

  void _listenToHouseholdChange() {
    _ref.listen<AsyncValue<String>>(
      fbcore.currentHouseholdIdProvider,
      (previous, next) {
        final newHouseholdId = next.valueOrNull;
        final previousHouseholdId = previous?.valueOrNull;

        // 世帯IDが変更された場合、データを再読み込み
        if (newHouseholdId != null &&
            previousHouseholdId != null &&
            newHouseholdId != previousHouseholdId) {
          // 世帯が変わったので、選択中の子どもをリセットしてデータを再読み込み
          _recordsSubscription?.cancel();
          state = state.copyWith(
            householdId: newHouseholdId,
            selectedChildId: null,
            recordsAsync: const AsyncValue<List<RecordItemModel>>.loading(),
          );
          // 次のフレームでリロードを実行（Riverpodの状態が安定した後）
          Future.microtask(() => _reloadForNewHousehold(newHouseholdId));
        }
      },
    );
  }

  Future<void> _reloadForNewHousehold(String householdId) async {
    if (!mounted) return;

    try {
      // Providerを使わずに直接Firestoreから子どもを取得
      final ds = ChildFirestoreDataSource(_db, householdId);
      final snap = await ds.childrenQuery().limit(1).get();

      if (!mounted) return;

      String? childId;
      if (snap.docs.isNotEmpty) {
        childId = snap.docs.first.id;
        // SharedPreferencesに保存（selectedChildControllerProviderを経由）
        await _ref
            .read(selectedChildControllerProvider.notifier)
            .select(childId);
        state = state.copyWith(selectedChildId: childId);
      } else {
        await _ref.read(selectedChildControllerProvider.notifier).select(null);
        state = state.copyWith(selectedChildId: null);
      }

      if (!mounted) return;

      if (childId != null) {
        _subscribeToRecords(
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
      if (!mounted) return;
      state = state.copyWith(
        recordsAsync: AsyncValue.error(error, stackTrace),
        pendingUiEvent: const RecordUiEvent.showMessage('記録の読み込みに失敗しました'),
      );
    }
  }

  void _listenToSelectedChild() {
    _ref.listen<AsyncValue<String?>>(
      selectedChildControllerProvider,
      (previous, next) {
        // loading状態の場合は何もしない（_loadInitialDataが処理する）
        if (next.isLoading) {
          return;
        }
        final newId = next.valueOrNull;
        // 前回もdata状態で、値が同じ場合はスキップ
        final previousWasData = previous != null && !previous.isLoading;
        if (previousWasData && newId == state.selectedChildId) {
          return;
        }
        state = state.copyWith(
          selectedChildId: newId,
          pendingUiEvent: null,
        );
        // 子供IDがnullの場合は空リストを設定（householdIdに関係なく）
        if (newId == null || newId.isEmpty) {
          _recordsSubscription?.cancel();
          state = state.copyWith(
            recordsAsync: const AsyncValue<List<RecordItemModel>>.data(
                <RecordItemModel>[]),
          );
          return;
        }
        final hid = state.householdId;
        if (hid == null) {
          // householdIdがまだ設定されていない場合は、_loadInitialDataが処理する
          return;
        }
        _subscribeToRecords(
          householdId: hid,
          childId: newId,
          date: state.selectedDate,
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
      if (!mounted) return;
      state = state.copyWith(householdId: householdId);
      final childId = await _ensureActiveChild(
        householdId: householdId,
        watchSelected: true,
      );
      if (!mounted) return;
      if (childId != null) {
        _subscribeToRecords(
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
      if (!mounted) return;
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
    // Streamを再購読してリフレッシュ
    _subscribeToRecords(
      householdId: householdId,
      childId: childId,
      date: state.selectedDate,
    );
    await _loadOtherTags(householdId);
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
      _subscribeToRecords(
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
      if (!mounted) return;
      currentTags.add(normalized);
      currentTags.sort();
      state = state.copyWith(
        otherTagsAsync: AsyncValue.data(
          List.unmodifiable(currentTags),
        ),
      );
    } catch (_) {
      if (!mounted) return;
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
      if (!mounted) return;
      currentTags.remove(tag);
      state = state.copyWith(
        otherTagsAsync: AsyncValue.data(
          List.unmodifiable(currentTags),
        ),
      );
    } catch (_) {
      if (!mounted) return;
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

    final ds = ChildFirestoreDataSource(
      _db,
      householdId,
    );

    // 選択されている子どもが現在の世帯に存在するか確認
    if (selected != null && selected.isNotEmpty) {
      final childDoc = await ds
          .childrenQuery()
          .where(FieldPath.documentId, isEqualTo: selected)
          .limit(1)
          .get();
      if (childDoc.docs.isNotEmpty) {
        state = state.copyWith(selectedChildId: selected);
        return selected;
      }
      // 子どもが現在の世帯に存在しない場合はリセット
    }

    // 世帯内の最初の子どもを選択
    final snap = await ds.childrenQuery().limit(1).get();
    if (snap.docs.isEmpty) {
      await _ref.read(selectedChildControllerProvider.notifier).select(null);
      state = state.copyWith(selectedChildId: null);
      return null;
    }
    final firstId = snap.docs.first.id;
    await _ref.read(selectedChildControllerProvider.notifier).select(firstId);
    state = state.copyWith(selectedChildId: firstId);
    return firstId;
  }

  void _subscribeToRecords({
    required String householdId,
    required String childId,
    required DateTime date,
    bool keepPrevious = true,
  }) {
    // 既存の購読をキャンセル
    _recordsSubscription?.cancel();

    if (!mounted) return;
    final previous = state.recordsAsync;
    const loading = AsyncValue<List<RecordItemModel>>.loading();
    state = state.copyWith(
      recordsAsync: keepPrevious ? loading.copyWithPrevious(previous) : loading,
    );

    final dataSource =
        _ref.read(_recordFirestoreDataSourceProvider(householdId));
    _recordsSubscription = dataSource.watchForDay(childId, date).listen(
      (records) {
        if (!mounted) return;
        final items = records.map(_mapper.toUiModel).toList(growable: false);
        state = state.copyWith(
          recordsAsync: AsyncValue.data(items),
        );
      },
      onError: (error, stackTrace) {
        if (!mounted) return;
        // Firestore権限エラーの場合はスナックバーを表示しない
        // （世帯変更時に一時的に発生する可能性があるため）
        final isPermissionError =
            error.toString().contains('permission-denied') ||
                error.toString().contains('PERMISSION_DENIED');
        state = state.copyWith(
          recordsAsync: AsyncValue.error(error, stackTrace),
          pendingUiEvent: isPermissionError
              ? null
              : const RecordUiEvent.showMessage('記録の取得に失敗しました'),
        );
      },
    );
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
