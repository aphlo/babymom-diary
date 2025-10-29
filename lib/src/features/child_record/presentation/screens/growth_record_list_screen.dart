import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../viewmodels/growth_chart_view_model.dart';
import '../widgets/growth_measurement_sheet.dart';

class GrowthRecordListScreen extends ConsumerWidget {
  const GrowthRecordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('身長と体重の記録'),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: '身長'),
              Tab(text: '体重'),
            ],
          ),
        ),
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
          (record) => DateFormat('yyyy/MM').format(record.recordedAt),
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
            final formattedDate =
                DateFormat('yyyy/MM/dd').format(record.recordedAt);
            final value = (type == RecordType.height)
                ? _formatHeight(record.height)
                : _formatWeight(record.weight);

            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text(formattedDate),
                    subtitle: Text(value),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
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
