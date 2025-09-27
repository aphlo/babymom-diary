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

    void handleSlotTap(
      BuildContext cellContext,
      int hour,
      EntryType? type,
      List<Entry> inHour,
    ) {
      showLogSlotSheet(
        context: cellContext,
        ref: ref,
        hour: hour,
        onlyType: type,
        inHour: inHour,
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        leading: IconButton(
          tooltip: '前日',
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            final d = ref.read(selectedLogDateProvider);
            ref.read(selectedLogDateProvider.notifier).state =
                DateTime(d.year, d.month, d.day)
                    .subtract(const Duration(days: 1));
          },
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final d = ref.watch(selectedLogDateProvider);
              final today = DateTime.now();
              final today0 = DateTime(today.year, today.month, today.day);
              final isToday = d.isAtSameMomentAs(today0);
              return IconButton(
                tooltip: '翌日',
                icon: const Icon(Icons.chevron_right),
                onPressed: isToday
                    ? null
                    : () {
                        final nd = d.add(const Duration(days: 1));
                        ref.read(selectedLogDateProvider.notifier).state =
                            DateTime(nd.year, nd.month, nd.day);
                      },
              );
            },
          ),
        ],
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarChildInfo(),
            SizedBox(height: 2),
            AppBarDateSwitcher(),
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
