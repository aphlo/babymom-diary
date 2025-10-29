import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';
import '../viewmodels/growth_chart_view_model.dart';
import '../widgets/growth_measurement_sheet.dart';

class GrowthRecordListScreen extends ConsumerWidget {
  const GrowthRecordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('身長と体重の記録'),
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
                    Tab(text: '身長'),
                    Tab(text: '体重'),
                  ],
                ),
              ),
            )),
        backgroundColor: AppColors.pageBackground,
        body: TabBarView(
          children: [
            _RecordListView(type: RecordType.height),
            _RecordListView(type: RecordType.weight),
          ],
        ),
      ),
    );
  }
}

enum RecordType { height, weight }

class _RecordListView extends ConsumerWidget {
  const _RecordListView({required this.type});

  final RecordType type;

  String _formatHeight(double? value) {
    if (value == null) {
      return '-';
    }
    return '${value.toStringAsFixed(1)} cm';
  }

  String _formatWeight(double? value) {
    if (value == null) {
      return '-';
    }
    final normalized = value > 20 ? value / 1000 : value;
    return '${normalized.toStringAsFixed(2)} kg';
  }

  String? _formatElapsedSinceBirth(DateTime? birthday, DateTime recordedAt) {
    if (birthday == null) {
      return null;
    }
    final birthDate = DateUtils.dateOnly(birthday);
    final recordDate = DateUtils.dateOnly(recordedAt);

    if (recordDate.isBefore(birthDate)) {
      return null;
    }

    int years = recordDate.year - birthDate.year;
    int months = recordDate.month - birthDate.month;
    int days = recordDate.day - birthDate.day;

    if (days < 0) {
      final previousMonth = DateTime(recordDate.year, recordDate.month, 0);
      days += previousMonth.day;
      months -= 1;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    final totalMonths = years * 12 + months;
    final buffer = StringBuffer();

    if (totalMonths > 0) {
      buffer.write('$totalMonthsヶ月');
    }

    if (days > 0) {
      buffer.write('$days日');
    }

    if (buffer.isEmpty) {
      buffer.write('0日');
    }

    return '生後${buffer.toString()}目';
  }

  Future<bool?> _showDeleteConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('記録を削除'),
          content: const Text('この記録を削除してもよろしいですか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final growthChartState = ref.watch(growthChartViewModelProvider);
    final chartData = growthChartState.chartData;
    final childBirthday = growthChartState.childSummary?.birthday;

    return chartData.when(
      data: (data) {
        final records = (type == RecordType.height)
            ? data.measurements.where((m) => m.hasHeight).toList()
            : data.measurements.where((m) => m.hasWeight).toList();

        records.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));

        if (records.isEmpty) {
          return const Center(
            child: Text('記録がありません'),
          );
        }

        final groupedRecords = groupBy(
          records,
          (record) => DateFormatter.yyyyMM(record.recordedAt),
        );

        final List<dynamic> items = [];
        groupedRecords.forEach((month, recordsInMonth) {
          items.add(month);
          items.addAll(recordsInMonth);
        });

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            if (item is String) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Divider(height: 1),
                ],
              );
            }

            final record = item;
            final formattedDate = DateFormatter.ddE(record.recordedAt);
            final value = (type == RecordType.height)
                ? _formatHeight(record.height)
                : _formatWeight(record.weight);
            final ageText =
                _formatElapsedSinceBirth(childBirthday, record.recordedAt);
            final theme = Theme.of(context);
            final valueTextStyle = theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: (theme.textTheme.titleMedium?.fontSize ??
                      theme.textTheme.bodyLarge?.fontSize ??
                      16) +
                  2,
              color: theme.textTheme.titleMedium?.color,
            );

            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      right: 8,
                    ),
                    title: Text(
                      formattedDate,
                      style: theme.textTheme.bodyLarge,
                    ),
                    subtitle: ageText == null ? null : Text(ageText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value,
                          style: valueTextStyle,
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                          visualDensity: VisualDensity.compact,
                          splashRadius: 18,
                          onPressed: () {
                            if (type == RecordType.height) {
                              showHeightRecordSheet(
                                context: context,
                                initialDate: record.recordedAt,
                                minimumDate: childBirthday,
                                maximumDate: DateTime.now(),
                                record: record,
                              );
                            } else {
                              showWeightRecordSheet(
                                context: context,
                                initialDate: record.recordedAt,
                                minimumDate: childBirthday,
                                maximumDate: DateTime.now(),
                                record: record,
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                          visualDensity: VisualDensity.compact,
                          splashRadius: 18,
                          onPressed: () async {
                            final confirmed =
                                await _showDeleteConfirmDialog(context);
                            if (confirmed == true) {
                              final notifier = ref
                                  .read(growthChartViewModelProvider.notifier);
                              try {
                                await notifier.deleteGrowthRecord(record.id);
                              } catch (error) {
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('削除に失敗しました: $error'),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
    );
  }
}
