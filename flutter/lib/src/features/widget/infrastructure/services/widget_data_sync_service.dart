import '../../../child_record/domain/entities/record.dart';
import '../../../child_record/domain/repositories/child_record_repository.dart';
import '../../../menu/children/domain/entities/child_summary.dart';
import '../../domain/entities/widget_child.dart';
import '../../domain/entities/widget_data.dart';
import '../../domain/entities/widget_record.dart';
import '../../domain/repositories/widget_data_repository.dart';

/// ウィジェットデータ同期サービス
class WidgetDataSyncService {
  final WidgetDataRepository _widgetRepository;
  final ChildRecordRepository _recordRepository;

  /// 直近記録の保持件数（各RecordType毎）
  static const int _recentRecordsLimit = 10;

  WidgetDataSyncService({
    required WidgetDataRepository widgetRepository,
    required ChildRecordRepository recordRepository,
  })  : _widgetRepository = widgetRepository,
        _recordRepository = recordRepository;

  /// Record変更時に呼び出し
  Future<void> onRecordChanged({
    required String householdId,
    required String childId,
  }) async {
    // 直近7日間の記録を取得
    final now = DateTime.now();
    final records = <Record>[];

    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final dayRecords =
          await _recordRepository.getRecordsForDay(childId, date);
      records.addAll(dayRecords);
    }

    // 日時順でソート（新しい順）
    records.sort((a, b) => b.at.compareTo(a.at));

    // 上位N件をWidgetRecord形式に変換
    final widgetRecords = records
        .take(_recentRecordsLimit)
        .map((r) => WidgetRecord(
              id: r.id,
              type: r.type,
              at: r.at,
              amount: r.amount,
              excretionVolume: r.excretionVolume,
            ))
        .toList();

    await _widgetRepository.updateChildRecords(childId, widgetRecords);
    await _widgetRepository.notifyWidgetUpdate();
  }

  /// 子供情報変更時に呼び出し
  Future<void> onChildrenChanged(List<ChildSummary> children) async {
    final data = await _widgetRepository.getWidgetData();

    final widgetChildren = children
        .map((c) => WidgetChild(
              id: c.id,
              name: c.name,
              birthday: c.birthday,
            ))
        .toList();

    // 選択中の子供が削除された場合は、最初の子供を選択
    String? selectedChildId = data.selectedChildId;
    if (selectedChildId != null &&
        !children.any((c) => c.id == selectedChildId)) {
      selectedChildId = children.isNotEmpty ? children.first.id : null;
    }

    final updatedData = data.copyWith(
      lastUpdated: DateTime.now(),
      selectedChildId: selectedChildId,
      children: widgetChildren,
    );

    await _widgetRepository.saveWidgetData(updatedData);
    await _widgetRepository.notifyWidgetUpdate();
  }

  /// 選択子供変更時に呼び出し
  Future<void> onSelectedChildChanged(String childId) async {
    await _widgetRepository.updateSelectedChildId(childId);
  }

  /// 全データを同期（アプリ起動時など）
  Future<void> syncAllData({
    required String householdId,
    required List<ChildSummary> children,
    required String? selectedChildId,
  }) async {
    // 子供情報を更新
    final widgetChildren = children
        .map((c) => WidgetChild(
              id: c.id,
              name: c.name,
              birthday: c.birthday,
            ))
        .toList();

    // 各子供の直近記録を取得
    final recentRecords = <String, List<WidgetRecord>>{};
    final now = DateTime.now();

    for (final child in children) {
      final records = <Record>[];

      for (int i = 0; i < 7; i++) {
        final date = now.subtract(Duration(days: i));
        final dayRecords =
            await _recordRepository.getRecordsForDay(child.id, date);
        records.addAll(dayRecords);
      }

      records.sort((a, b) => b.at.compareTo(a.at));

      recentRecords[child.id] = records
          .take(_recentRecordsLimit)
          .map((r) => WidgetRecord(
                id: r.id,
                type: r.type,
                at: r.at,
                amount: r.amount,
                excretionVolume: r.excretionVolume,
              ))
          .toList();
    }

    final data = WidgetData(
      lastUpdated: DateTime.now(),
      selectedChildId:
          selectedChildId ?? (children.isNotEmpty ? children.first.id : null),
      children: widgetChildren,
      recentRecords: recentRecords,
    );

    await _widgetRepository.saveWidgetData(data);
    await _widgetRepository.notifyWidgetUpdate();
  }
}
