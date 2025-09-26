import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import '../controllers/log_controller.dart';
import '../components/entry_tile.dart';
import '../../baby_log.dart';
import '../widgets/app_bar_child_info.dart';
import '../widgets/app_bar_date_switcher.dart';
import '../controllers/selected_log_date_provider.dart';

class LogListScreen extends ConsumerWidget {
  const LogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(logControllerProvider);

    const headerRowHeight = 44.0;
    const bodyRowHeight = 32.0;

    Widget buildCell(
      BuildContext context,
      WidgetRef ref,
      List<Entry> entries,
      int hour,
      EntryType? type,
    ) {
      final inHour = entries.where((e) => e.at.hour == hour).toList();
      final filtered =
          type == null ? inHour : inHour.where((e) => e.type == type).toList();

      String text = '';
      if (filtered.isNotEmpty) {
        switch (type) {
          case EntryType.formula:
            final sum = filtered.fold<double>(0, (p, e) => p + (e.amount ?? 0));
            text = sum == 0 ? '${filtered.length}' : sum.toStringAsFixed(0);
            break;
          case EntryType.pump:
            final sum = filtered.fold<double>(0, (p, e) => p + (e.amount ?? 0));
            text = sum == 0 ? '${filtered.length}' : sum.toStringAsFixed(0);
            break;
          case EntryType.breastLeft || EntryType.breastRight:
            final mins =
                filtered.fold<double>(0, (p, e) => p + (e.amount ?? 0));
            text = mins == 0 ? '${filtered.length}' : mins.toStringAsFixed(0);
            break;
          case EntryType.pee || EntryType.poop || EntryType.other:
            text = '${filtered.length}';
            break;
          case null:
            text = '${filtered.length}';
            break;
        }
      }

      return InkWell(
        onTap: () => _openSlotSheet(context, ref, hour, type, inHour),
        child: SizedBox(
          height: bodyRowHeight,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }

    Widget buildTotalValueCell(String value) => SizedBox(
          height: bodyRowHeight,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );

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
          Consumer(builder: (context, ref, _) {
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
          }),
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
        data: (list) {
          final headers = <String>[
            '時間',
            '授乳\n(右)',
            '授乳\n(左)',
            'ミルク',
            '搾乳',
            '尿',
            '便',
            'その他'
          ];
          final totalBreastRight =
              list.where((e) => e.type == EntryType.breastRight).length;
          final totalBreastLeft =
              list.where((e) => e.type == EntryType.breastLeft).length;
          final totalFormulaMl = list
              .where((e) => e.type == EntryType.formula)
              .fold<double>(0, (sum, e) => sum + (e.amount ?? 0));
          final totalPumpMl = list
              .where((e) => e.type == EntryType.pump)
              .fold<double>(0, (sum, e) => sum + (e.amount ?? 0));
          final totalPeeCount =
              list.where((e) => e.type == EntryType.pee).length;
          final totalPoopCount =
              list.where((e) => e.type == EntryType.poop).length;
          const columnWidths = <int, TableColumnWidth>{
            0: FlexColumnWidth(0.8),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(1.0),
            3: FlexColumnWidth(1.0),
            4: FlexColumnWidth(1.0),
            5: FlexColumnWidth(1.0),
            6: FlexColumnWidth(1.0),
            7: FlexColumnWidth(2.0), // その他 少し広め
          };
          final borderSide = BorderSide(color: Colors.grey.shade400);

          final totalsRow = SizedBox(
            width: double.infinity,
            child: Table(
              columnWidths: columnWidths,
              border: TableBorder(
                top: borderSide,
                left: borderSide,
                right: borderSide,
                bottom: borderSide,
                verticalInside: borderSide,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  children: [
                    const SizedBox(
                      height: bodyRowHeight,
                      child: Center(
                        child: Text(
                          '合計',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    buildTotalValueCell('$totalBreastRight'),
                    buildTotalValueCell('$totalBreastLeft'),
                    buildTotalValueCell(totalFormulaMl.toStringAsFixed(0)),
                    buildTotalValueCell(totalPumpMl.toStringAsFixed(0)),
                    buildTotalValueCell('$totalPeeCount'),
                    buildTotalValueCell('$totalPoopCount'),
                    buildTotalValueCell(''),
                  ],
                ),
              ],
            ),
          );

          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Table(
                        columnWidths: columnWidths,
                        border: TableBorder(
                          top: borderSide,
                          left: borderSide,
                          right: borderSide,
                          bottom: borderSide,
                          verticalInside: borderSide,
                        ),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade100),
                            children: headers
                                .map(
                                  (h) => SizedBox(
                                    height: headerRowHeight,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          h,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: bodyRowHeight,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Table(
                                        columnWidths: columnWidths,
                                        border: TableBorder(
                                          top: BorderSide.none,
                                          left: borderSide,
                                          right: borderSide,
                                          bottom: BorderSide.none,
                                          horizontalInside: borderSide,
                                          verticalInside: borderSide,
                                        ),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          for (int h = 0; h < 24; h++)
                                            TableRow(
                                              decoration: BoxDecoration(
                                                color: h.isEven
                                                    ? Colors.white
                                                    : Colors.pink.shade50,
                                              ),
                                              children: [
                                                SizedBox(
                                                  height: bodyRowHeight,
                                                  child: Center(
                                                    child: Text('$h'),
                                                  ),
                                                ),
                                                buildCell(context, ref, list, h,
                                                    EntryType.breastRight),
                                                buildCell(context, ref, list, h,
                                                    EntryType.breastLeft),
                                                buildCell(context, ref, list, h,
                                                    EntryType.formula),
                                                buildCell(context, ref, list, h,
                                                    EntryType.pump),
                                                buildCell(context, ref, list, h,
                                                    EntryType.pee),
                                                buildCell(context, ref, list, h,
                                                    EntryType.poop),
                                                buildCell(context, ref, list, h,
                                                    EntryType.other),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: totalsRow,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

void _openSlotSheet(
  BuildContext context,
  WidgetRef ref,
  int hour,
  EntryType? onlyType,
  List<Entry> inHour,
) {
  final base = ref.read(selectedLogDateProvider);
  final slot = DateTime(base.year, base.month, base.day, hour);

  Future<void> quickAdd(EntryType t) async {
    final defaultAmount = switch (t) {
      EntryType.formula => 100.0,
      EntryType.pump => 100.0,
      EntryType.breastLeft || EntryType.breastRight => 10.0,
      EntryType.pee || EntryType.poop || EntryType.other => null,
    };
    final entry = Entry(type: t, at: slot, amount: defaultAmount);
    await ref.read(logControllerProvider.notifier).add(entry);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('記録しました')));
      Navigator.of(context).maybePop();
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      final entries = onlyType == null
          ? inHour
          : inHour.where((e) => e.type == onlyType).toList();
      final actions = onlyType == null
          ? <EntryType>[
              EntryType.breastRight,
              EntryType.breastLeft,
              EntryType.formula,
              EntryType.pump,
              EntryType.pee,
              EntryType.poop,
              EntryType.other,
            ]
          : <EntryType>[onlyType];
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${hour.toString().padLeft(2, '0')}:00 の記録',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('合計: ${entries.length}件'),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: entries.length,
                    itemBuilder: (_, i) => EntryTile(entry: entries[i]),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final t in actions)
                      FilledButton.tonalIcon(
                        onPressed: () => quickAdd(t),
                        icon: Icon(_iconFor(t)),
                        label: Text(_quickLabelFor(t)),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

IconData _iconFor(EntryType t) => switch (t) {
      EntryType.formula => Icons.local_drink,
      EntryType.pump => Icons.local_drink_outlined,
      EntryType.breastRight || EntryType.breastLeft => Icons.child_care,
      EntryType.pee => Icons.water_drop,
      EntryType.poop => Icons.delete_outline,
      EntryType.other => Icons.more_horiz,
    };

String _quickLabelFor(EntryType t) => switch (t) {
      EntryType.formula => 'ミルク 100ml',
      EntryType.pump => '搾乳 100ml',
      EntryType.breastRight => '右 10分',
      EntryType.breastLeft => '左 10分',
      EntryType.pee => '尿',
      EntryType.poop => '便',
      EntryType.other => 'その他',
    };
