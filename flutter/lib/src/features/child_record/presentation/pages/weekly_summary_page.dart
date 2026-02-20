import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../../feeding_table_settings/application/providers/feeding_table_settings_providers.dart';
import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../models/weekly_summary_model.dart';
import '../providers/weekly_summary_provider.dart';
import '../viewmodels/record_view_model.dart';
import '../viewmodels/weekly_summary/weekly_summary_state.dart';
import '../viewmodels/weekly_summary/weekly_summary_view_model.dart';
import '../widgets/weekly_summary_category_tab.dart';

/// 週間サマリーフルスクリーンモーダルを開く
void openWeeklySummaryPage({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final childContext = ref.read(childContextProvider).value;
  if (childContext == null || !childContext.hasSelectedChild) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('記録を行うには、メニューから子どもを登録してください。')),
    );
    return;
  }

  final selectedDate = ref.read(recordViewModelProvider).selectedDate;

  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => WeeklySummaryPage(
        householdId: childContext.householdId,
        childId: childContext.selectedChildId!,
        initialDate: selectedDate,
      ),
    ),
  );
}

class WeeklySummaryPage extends ConsumerStatefulWidget {
  const WeeklySummaryPage({
    required this.householdId,
    required this.childId,
    required this.initialDate,
    super.key,
  });

  final String householdId;
  final String childId;
  final DateTime initialDate;

  @override
  ConsumerState<WeeklySummaryPage> createState() => _WeeklySummaryPageState();
}

class _WeeklySummaryPageState extends ConsumerState<WeeklySummaryPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _tabCount = 0;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _ensureTabController(int tabCount) {
    if (_tabCount == tabCount) return;
    _tabController?.dispose();
    _tabCount = tabCount;
    if (tabCount == 0) {
      _tabController = null;
      return;
    }
    final oldIndex = _tabController?.index ?? 0;
    _tabController = TabController(
      length: tabCount,
      vsync: this,
      initialIndex: oldIndex.clamp(0, tabCount - 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vmState = ref.watch(
      weeklySummaryViewModelProvider(widget.initialDate),
    );
    final vmNotifier = ref.read(
      weeklySummaryViewModelProvider(widget.initialDate).notifier,
    );

    final feedingSettingsAsync = ref.watch(feedingTableSettingsStreamProvider);
    final settings = feedingSettingsAsync.value ?? const FeedingTableSettings();

    final categories = settings.visibleCategories
        .where((c) =>
            c != FeedingTableCategory.other &&
            c != FeedingTableCategory.babyFood)
        .toList();

    final tabCount = categories.length;
    _ensureTabController(tabCount);
    final tabController = _tabController;

    final query = WeeklySummaryQuery(
      householdId: widget.householdId,
      childId: widget.childId,
      weekStart: vmState.weekStart,
    );
    final summaryAsync = ref.watch(weeklySummaryProvider(query));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('週間サマリー'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 週ナビゲーション
          _WeekNavigator(
            state: vmState,
            onPrevious: vmNotifier.goToPreviousWeek,
            onNext: vmState.canGoToNextWeek ? vmNotifier.goToNextWeek : null,
          ),
          // タブバー
          if (tabController != null && tabCount > 0)
            TabBar(
              controller: tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: context.subtextColor,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: [
                for (final c in categories)
                  Tab(
                    child: SizedBox(
                      width: 32,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(c.label),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          const Divider(height: 1),
          // タブコンテンツ
          Expanded(
            child: summaryAsync.when(
              data: (data) {
                if (tabController == null || tabCount == 0) {
                  return const SizedBox.shrink();
                }
                return TabBarView(
                  controller: tabController,
                  children: [
                    for (final c in categories)
                      CategoryDetailTab(data: data, category: c),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('データの取得に失敗しました: $e'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 週ナビゲーション（前週・次週切り替え）
class _WeekNavigator extends StatelessWidget {
  const _WeekNavigator({
    required this.state,
    required this.onPrevious,
    required this.onNext,
  });

  final WeeklySummaryState state;
  final VoidCallback onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onPrevious,
            tooltip: '前の週',
          ),
          Expanded(
            child: Center(
              child: Text(
                state.dateRangeLabel,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: onNext != null ? null : Colors.grey.shade400,
            ),
            onPressed: onNext,
            tooltip: '次の週',
          ),
        ],
      ),
    );
  }
}
