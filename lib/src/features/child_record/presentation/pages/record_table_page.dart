import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

import '../components/feeding_table_tab.dart';
import '../components/growth_chart_tab.dart';
import '../viewmodels/record_view_model.dart';
import '../widgets/app_bar_child_info.dart';
import '../widgets/app_bar_date_switcher.dart';

class RecordTablePage extends ConsumerWidget {
  const RecordTablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(recordViewModelProvider);
    final notifier = ref.read(recordViewModelProvider.notifier);
    final selectedDate = state.selectedDate;

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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: theme.textTheme.bodyMedium,
                tabs: const [
                  Tab(text: '授乳表'),
                  Tab(text: '成長曲線'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            FeedingTableTab(),
            GrowthChartTab(),
          ],
        ),
        bottomNavigationBar: const AppBottomNav(),
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
