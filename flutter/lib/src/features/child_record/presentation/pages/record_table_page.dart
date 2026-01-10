import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../baby_food/presentation/models/baby_food_draft.dart';
import '../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../baby_food/presentation/viewmodels/baby_food_sheet_view_model.dart';
import '../../../baby_food/presentation/widgets/baby_food_sheet.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../components/baby_food_tab.dart';
import '../components/feeding_table_tab.dart';
import '../components/growth_chart_tab.dart';
import '../models/record_draft.dart';
import '../viewmodels/record_state.dart';
import '../viewmodels/record_view_model.dart';
import '../widgets/app_bar_child_info.dart';
import '../widgets/app_bar_date_switcher.dart';
import '../widgets/record_sheet/editable_record_sheet.dart';

class RecordTablePage extends ConsumerStatefulWidget {
  const RecordTablePage({super.key});

  @override
  ConsumerState<RecordTablePage> createState() => _RecordTablePageState();
}

class _RecordTablePageState extends ConsumerState<RecordTablePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ProviderSubscription<RecordPageState> _stateSub;
  String? _previousChildId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(_onTabChanged);

    // UIイベントをリッスン（どのタブでも処理できるように）
    _stateSub = ref.listenManual<RecordPageState>(
      recordViewModelProvider,
      _handleStateEvent,
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _stateSub.close();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    // TabControllerの変更を検知するだけ（何もしない）
  }

  void _handleStateEvent(RecordPageState? previous, RecordPageState next) {
    final event = next.pendingUiEvent;
    if (event == null) return;
    if (!mounted) return;

    // ディープリンクからのイベント（openEditor, openBabyFoodEditor）のみ処理
    // openSlotはFeedingTableTabで処理（スロットタップ時のみ発生）
    final isDeepLinkEvent =
        event.openEditor != null || event.openBabyFoodEditor != null;
    if (!isDeepLinkEvent) return;

    // initStateから呼ばれた場合、contextがまだ使えないのでビルド後に処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _processUiEvent(event);
    });
  }

  void _processUiEvent(RecordUiEvent event) {
    if (!mounted) return;
    final notifier = ref.read(recordViewModelProvider.notifier);

    if (event.openEditor != null) {
      // 授乳表タブに切り替えてからダイアログを表示
      if (_tabController.index != 0) {
        _tabController.animateTo(0);
      }
      _openEditor(event.openEditor!);
      notifier.clearUiEvent();
    }

    if (event.openBabyFoodEditor != null) {
      // 離乳食の記録画面を表示（タブは切り替えない）
      _openBabyFoodEditor(event.openBabyFoodEditor!);
      notifier.clearUiEvent();
    }
  }

  Future<void> _openEditor(RecordEditorRequest request) async {
    final notifier = ref.read(recordViewModelProvider.notifier);
    final result = await showDialog<RecordDraft>(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: EditableRecordSheet(
            initialDraft: request.draft,
            isNew: request.isNew,
          ),
        ),
      ),
    );
    if (result != null && mounted) {
      await notifier.addOrUpdateRecord(result);
    }
  }

  Future<void> _openBabyFoodEditor(BabyFoodEditorRequest request) async {
    final childContext = ref.read(childContextProvider).value;
    if (childContext == null || !childContext.hasSelectedChild) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('記録を行うには、メニューから子どもを登録してください。')),
      );
      return;
    }

    final householdId = childContext.householdId;
    final childId = childContext.selectedChildId!;
    final selectedDate = ref.read(recordViewModelProvider).selectedDate;

    // カスタム食材と非表示食材を取得
    final customIngredients =
        ref.read(customIngredientsProvider(householdId)).value ?? [];
    final hiddenIngredients =
        ref.read(hiddenIngredientsProvider(householdId)).value ?? <String>{};

    final draft = BabyFoodDraft.newRecord(recordedAt: request.initialDateTime);
    final args = BabyFoodSheetArgs(
      householdId: householdId,
      childId: childId,
      initialDraft: draft,
      customIngredients: customIngredients,
      hiddenIngredients: hiddenIngredients,
    );

    await showBabyFoodSheet(
      context: context,
      args: args,
      selectedDate: selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(recordViewModelProvider);
    final notifier = ref.read(recordViewModelProvider.notifier);
    final selectedDate = state.selectedDate;

    // 子供の変更を検知して、TabControllerのインデックスを保持
    final childContext = ref.watch(childContextProvider).value;
    final currentChildId = childContext?.selectedChildId;
    if (_previousChildId != currentChildId) {
      // 子供が変更された - TabControllerのインデックスはそのまま保持
      _previousChildId = currentChildId;
    }

    final today = DateTime.now();
    final today0 = DateTime(today.year, today.month, today.day);
    final isToday = selectedDate.isAtSameMomentAs(today0);

    Future<void> goToPreviousDate() async {
      final d = state.selectedDate;
      final prev =
          DateTime(d.year, d.month, d.day).subtract(const Duration(days: 1));
      await notifier.onSelectDate(prev);
    }

    Future<void> goToNextDate() async {
      final d = state.selectedDate;
      final nd = DateTime(d.year, d.month, d.day).add(const Duration(days: 1));
      await notifier.onSelectDate(nd);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 64,
        titleSpacing: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppBarChildInfo(),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _AppBarIconButton(
                  icon: Icons.chevron_left,
                  tooltip: '前日',
                  onPressed: goToPreviousDate,
                ),
                const Expanded(
                  child: Center(child: AppBarDateSwitcher()),
                ),
                _AppBarIconButton(
                  icon: Icons.chevron_right,
                  tooltip: '翌日',
                  onPressed: isToday ? null : goToNextDate,
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: SizedBox(
            height: 32,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: theme.textTheme.bodyMedium,
              tabs: const [
                Tab(text: '授乳表'),
                Tab(text: '離乳食'),
                Tab(text: '成長曲線'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FeedingTableTab(),
          BabyFoodTab(),
          GrowthChartTab(),
        ],
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  const _AppBarIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: onPressed == null ? Colors.white38 : Colors.white,
      ),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
      splashRadius: 18,
    );
  }
}
