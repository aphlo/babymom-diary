import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/mom_record/presentation/components/mom_diary_overview_tab.dart';
import 'package:babymom_diary/src/features/mom_record/presentation/components/mom_record_overview_tab.dart';
import 'package:babymom_diary/src/features/mom_record/presentation/viewmodels/mom_record_view_model.dart';

class MomRecordPage extends ConsumerStatefulWidget {
  const MomRecordPage({super.key});

  @override
  ConsumerState<MomRecordPage> createState() => _MomRecordPageState();
}

class _MomRecordPageState extends ConsumerState<MomRecordPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialIndex = ref.read(momRecordViewModelProvider).selectedTabIndex;
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initialIndex,
    );
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      return;
    }
    ref
        .read(momRecordViewModelProvider.notifier)
        .onSelectTab(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(momRecordViewModelProvider);
    final notifier = ref.read(momRecordViewModelProvider.notifier);

    final tabIndex = state.selectedTabIndex;
    if (tabIndex >= 0 &&
        tabIndex < _tabController.length &&
        _tabController.index != tabIndex &&
        !_tabController.indexIsChanging) {
      _tabController.animateTo(tabIndex);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 44,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _AppBarIconButton(
              icon: Icons.chevron_left,
              tooltip: '前の月',
              onPressed: () => notifier.goToPreviousMonth(),
            ),
            Flexible(
              child: Text(
                state.monthLabel,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            _AppBarIconButton(
              icon: Icons.chevron_right,
              tooltip: '次の月',
              onPressed: () => notifier.goToNextMonth(),
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
                Tab(text: 'ママの記録'),
                Tab(text: '日記'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MomRecordOverviewTab(),
          MomDiaryOverviewTab(),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
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
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 28, height: 28),
      splashRadius: 16,
    );
  }
}
