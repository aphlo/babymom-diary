import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../child_record.dart';
import '../providers/daily_records_provider.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../../baby_food/domain/entities/baby_food_record.dart';
import '../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../baby_food/presentation/widgets/baby_food_slot_sheet.dart';
import '../../../feeding_table_settings/application/providers/feeding_table_settings_providers.dart';
import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../models/record_item_model.dart';
import '../viewmodels/record_state.dart';
import '../viewmodels/record_view_model.dart';
import '../widgets/record_sheet/record_slot_sheet.dart';
import '../widgets/record_table.dart';

class FeedingTableTab extends ConsumerStatefulWidget {
  const FeedingTableTab({super.key});

  @override
  ConsumerState<FeedingTableTab> createState() => _FeedingTableTabState();
}

class _FeedingTableTabState extends ConsumerState<FeedingTableTab> {
  late final ProviderSubscription<RecordPageState> _stateSub;

  @override
  void initState() {
    super.initState();
    _stateSub = ref.listenManual<RecordPageState>(
      recordViewModelProvider,
      _handleStateEvent,
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _stateSub.close();
    super.dispose();
  }

  void _handleStateEvent(RecordPageState? previous, RecordPageState next) {
    final event = next.pendingUiEvent;
    if (event == null) return;
    if (!mounted) return;

    // openEditor, openBabyFoodEditorはRecordTablePageで処理するためスキップ
    // ここではopenSlotとmessageのみ処理
    final shouldHandle = event.openSlot != null || event.message != null;
    if (!shouldHandle) return;

    final notifier = ref.read(recordViewModelProvider.notifier);

    // initStateから呼ばれた場合、contextがまだ使えないのでビルド後に処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _processUiEvent(event, notifier);
    });
  }

  void _processUiEvent(RecordUiEvent event, RecordViewModel notifier) {
    if (!mounted) return;

    if (event.message != null) {
      // 子供未登録のメッセージの場合はダイアログを表示
      if (event.message == '記録を行うには、メニューから子どもを登録してください。') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              '子どもを登録してください',
              style: TextStyle(fontSize: 16),
            ),
            content: Text(
              event.message!,
              style: const TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    }
    if (event.openSlot != null) {
      showRecordSlotSheet(
        context: context,
        ref: ref,
        request: event.openSlot!,
      );
    }
    notifier.clearUiEvent();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recordViewModelProvider);
    final notifier = ref.read(recordViewModelProvider.notifier);
    final childContext = ref.watch(childContextProvider).value;
    final selectedDate = state.selectedDate;

    // ChildContext と selectedChildId が揃っている場合のみ記録を取得
    final selectedChildId = childContext?.selectedChildId;
    final hasValidContext = childContext != null &&
        selectedChildId != null &&
        selectedChildId.isNotEmpty;

    final recordsAsync = hasValidContext
        ? ref.watch(dailyRecordsProvider(DailyRecordsQuery(
            householdId: childContext.householdId,
            childId: selectedChildId,
            date: selectedDate,
          )))
        : const AsyncValue<List<RecordItemModel>>.data(<RecordItemModel>[]);

    // 離乳食記録を取得
    final babyFoodRecordsAsync = hasValidContext
        ? ref.watch(dailyBabyFoodRecordsProvider(DailyBabyFoodRecordsQuery(
            householdId: childContext.householdId,
            childId: selectedChildId,
            date: selectedDate,
          )))
        : const AsyncValue<List<BabyFoodRecord>>.data(<BabyFoodRecord>[]);

    // カスタム食材を取得
    final customIngredientsAsync = hasValidContext
        ? ref.watch(customIngredientsProvider(childContext.householdId))
        : null;

    // 非表示食材を取得
    final hiddenIngredientsAsync = hasValidContext
        ? ref.watch(hiddenIngredientsProvider(childContext.householdId))
        : null;

    // 授乳表設定を取得
    final feedingTableSettingsAsync =
        ref.watch(feedingTableSettingsStreamProvider);
    final feedingTableSettings =
        feedingTableSettingsAsync.value ?? const FeedingTableSettings();

    void handleSlotTap(int hour, RecordType type) {
      final records = recordsAsync.value ?? const <RecordItemModel>[];
      notifier.openSlotDetails(hour: hour, type: type, allRecords: records);
    }

    void handleBabyFoodSlotTap(int hour) {
      if (!hasValidContext) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('記録を行うには、メニューから子どもを登録してください。')),
        );
        return;
      }

      final babyFoodRecords = babyFoodRecordsAsync.value ?? <BabyFoodRecord>[];
      final recordsInHour = babyFoodRecords
          .where((record) => record.recordedAt.hour == hour)
          .toList();
      final customIngredients = customIngredientsAsync?.value ?? [];
      final hiddenIngredients = hiddenIngredientsAsync?.value ?? <String>{};

      // bottom sheetで記録一覧を表示
      showBabyFoodSlotSheet(
        context: context,
        ref: ref,
        householdId: childContext.householdId,
        childId: selectedChildId,
        selectedDate: selectedDate,
        hour: hour,
        recordsInHour: recordsInHour,
        customIngredients: customIngredients,
        hiddenIngredients: hiddenIngredients,
      );
    }

    final scrollStorageKey = PageStorageKey<String>(
      'record_table_scroll_${selectedDate.toIso8601String()}',
    );

    Widget buildRecordTable(
      List<RecordItemModel> records,
      List<BabyFoodRecord> babyFoodRecords,
    ) {
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                RecordTable(
                  records: records,
                  onSlotTap: handleSlotTap,
                  scrollStorageKey: scrollStorageKey,
                  selectedDate: selectedDate,
                  babyFoodRecords: babyFoodRecords,
                  onBabyFoodSlotTap: handleBabyFoodSlotTap,
                  settings: feedingTableSettings,
                ),
                if ((recordsAsync.isLoading && !recordsAsync.hasValue) ||
                    (babyFoodRecordsAsync.isLoading &&
                        !babyFoodRecordsAsync.hasValue) ||
                    state.isProcessing)
                  const Positioned(
                    right: 16,
                    bottom: 16,
                    child: SizedBox(
                      height: 36,
                      width: 36,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                  ),
              ],
            ),
          ),
          const BannerAdWidget(slot: BannerAdSlot.feedingTable),
        ],
      );
    }

    // 両方のデータが揃ったら表示
    final records = recordsAsync.value ?? <RecordItemModel>[];
    final babyFoodRecords = babyFoodRecordsAsync.value ?? <BabyFoodRecord>[];

    if (recordsAsync.isLoading && !recordsAsync.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recordsAsync.hasError) {
      return Center(child: Text('Error: ${recordsAsync.error}'));
    }

    return buildRecordTable(records, babyFoodRecords);
  }
}
