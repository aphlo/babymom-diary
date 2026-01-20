import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../models/growth_measurement_point.dart';
import '../viewmodels/growth_chart/growth_chart_view_model.dart';
import '../widgets/growth_measurement_sheet.dart';
import '../widgets/growth_record_list_tile.dart';

class GrowthRecordListPage extends ConsumerWidget {
  const GrowthRecordListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tabLabelColor =
        context.isDarkMode ? context.primaryColor : Colors.white;
    final tabUnselectedColor = context.isDarkMode
        ? context.primaryColor.withValues(alpha: 0.6)
        : Colors.white70;

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
                labelColor: tabLabelColor,
                unselectedLabelColor: tabUnselectedColor,
                indicatorColor: tabLabelColor,
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
          ),
        ),
        backgroundColor: context.pageBackground,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _RecordListView(isHeightRecord: true),
                  _RecordListView(isHeightRecord: false),
                ],
              ),
            ),
            const BannerAdWidget(slot: BannerAdSlot.growthRecordList),
          ],
        ),
      ),
    );
  }
}

class _RecordListView extends ConsumerWidget {
  const _RecordListView({required this.isHeightRecord});

  final bool isHeightRecord;

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
        final records = isHeightRecord
            ? data.allMeasurements.where((m) => m.hasHeight).toList()
            : data.allMeasurements.where((m) => m.hasWeight).toList();

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
              return GrowthRecordMonthHeader(month: item);
            }

            final record = item as GrowthMeasurementPoint;
            return GrowthRecordListTile(
              record: record,
              isHeightRecord: isHeightRecord,
              childBirthday: childBirthday,
              onEdit: () => _onEdit(context, record, childBirthday),
              onDelete: () => _onDelete(context, ref, record),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
    );
  }

  void _onEdit(
    BuildContext context,
    GrowthMeasurementPoint record,
    DateTime? childBirthday,
  ) {
    if (isHeightRecord) {
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
  }

  Future<void> _onDelete(
    BuildContext context,
    WidgetRef ref,
    GrowthMeasurementPoint record,
  ) async {
    final confirmed = await _showDeleteConfirmDialog(context);
    if (confirmed == true) {
      final notifier = ref.read(growthChartViewModelProvider.notifier);
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
  }
}
