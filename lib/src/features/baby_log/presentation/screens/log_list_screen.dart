import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

import '../../baby_log.dart';
import '../controllers/log_controller.dart';
import '../controllers/selected_log_date_provider.dart';
import '../widgets/app_bar_child_info.dart';
import '../widgets/app_bar_date_switcher.dart';
import '../widgets/log_slot_sheet.dart';
import '../widgets/log_table.dart';

class LogListScreen extends ConsumerWidget {
  const LogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(logControllerProvider);
    final selectedDate = ref.watch(selectedLogDateProvider);

    final today = DateTime.now();
    final today0 = DateTime(today.year, today.month, today.day);
    final isToday = selectedDate.isAtSameMomentAs(today0);

    void goToPreviousDate() {
      final d = ref.read(selectedLogDateProvider);
      ref.read(selectedLogDateProvider.notifier).state =
          DateTime(d.year, d.month, d.day).subtract(const Duration(days: 1));
    }

    void goToNextDate() {
      final d = ref.read(selectedLogDateProvider);
      final nd = d.add(const Duration(days: 1));
      ref.read(selectedLogDateProvider.notifier).state =
          DateTime(nd.year, nd.month, nd.day);
    }

    void handleSlotTap(
      BuildContext _,
      int hour,
      EntryType? type,
      List<Entry> inHour,
    ) {
      showLogSlotSheet(
        context: context,
        ref: ref,
        hour: hour,
        onlyType: type,
        inHour: inHour,
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppBarChildInfo(),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: Row(
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
            ),
          ],
        ),
      ),
      body: state.when(
        data: (entries) => LogTable(
          entries: entries,
          onSlotTap: handleSlotTap,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
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
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      splashRadius: 22,
    );
  }
}
