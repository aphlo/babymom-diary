import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/mom_record/presentation/components/mom_diary_overview_tab.dart';
import 'package:babymom_diary/src/features/mom_record/presentation/components/mom_record_overview_tab.dart';
import 'package:babymom_diary/src/features/mom_record/presentation/viewmodels/mom_record_view_model.dart';

class MomScreen extends ConsumerWidget {
  const MomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(momRecordViewModelProvider);
    final notifier = ref.read(momRecordViewModelProvider.notifier);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 72,
          titleSpacing: 0,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _AppBarIconButton(
                      icon: Icons.chevron_left,
                      tooltip: '前の月',
                      onPressed: () => notifier.goToPreviousMonth(),
                    ),
                    Flexible(
                      child: Center(
                        child: Text(
                          state.monthLabel,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    _AppBarIconButton(
                      icon: Icons.chevron_right,
                      tooltip: '次の月',
                      onPressed: () => notifier.goToNextMonth(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: SizedBox(
              height: 44,
              child: TabBar(
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
        body: const TabBarView(
          children: [
            MomRecordOverviewTab(),
            MomDiaryOverviewTab(),
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
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      splashRadius: 22,
    );
  }
}
