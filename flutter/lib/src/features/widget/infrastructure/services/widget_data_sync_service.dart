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

  /// Record追加/更新時に呼び出し（保存したレコードを直接受け取る）
  Future<void> onRecordAdded({
    required String childId,
    required Record record,
  }) async {
    final widgetRecord = WidgetRecord(
      id: record.id,
      type: record.type,
      at: record.at,
      amount: record.amount,
      excretionVolume: record.excretionVolume,
    );

    final data = await _widgetRepository.getWidgetData();
    final existingRecords =
        List<WidgetRecord>.from(data.recentRecords[childId] ?? []);

    // 同じIDのレコードがあれば更新、なければ追加
    final existingIndex = existingRecords.indexWhere((r) => r.id == record.id);
    if (existingIndex >= 0) {
      existingRecords[existingIndex] = widgetRecord;
    } else {
      existingRecords.add(widgetRecord);
    }

    // 日時順でソート（新しい順）、上限件数に制限
    existingRecords.sort((a, b) => b.at.compareTo(a.at));
    final limitedRecords = existingRecords.take(_recentRecordsLimit).toList();

    await _widgetRepository.updateChildRecords(childId, limitedRecords);
    await _widgetRepository.notifyWidgetUpdate();
  }

  /// Record削除時に呼び出し
  Future<void> onRecordDeleted({
    required String childId,
    required String recordId,
  }) async {
    final data = await _widgetRepository.getWidgetData();
    final existingRecords =
        List<WidgetRecord>.from(data.recentRecords[childId] ?? []);

    // 該当レコードを削除
    existingRecords.removeWhere((r) => r.id == recordId);

    await _widgetRepository.updateChildRecords(childId, existingRecords);
    await _widgetRepository.notifyWidgetUpdate();
  }

  /// Record変更時に呼び出し（後方互換性のため残す、フル同期が必要な場合用）
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
  ///
  /// 子供情報の保存とレコード取得を分離し、レコード取得が失敗しても
  /// 子供情報は保存されるようにする。
  Future<void> syncAllData({
    required String householdId,
    required List<ChildSummary> children,
    required String? selectedChildId,
  }) async {
    // 1. まず既存のウィジェットデータを取得
    final existingData = await _widgetRepository.getWidgetData();

    // 2. 子供情報を準備（Firestore読み取り不要）
    final widgetChildren = children
        .map((c) => WidgetChild(
              id: c.id,
              name: c.name,
              birthday: c.birthday,
            ))
        .toList();

    // 3. 子供情報を先に保存（これは必ず成功する）
    final childOnlyData = WidgetData(
      lastUpdated: DateTime.now(),
      selectedChildId:
          selectedChildId ?? (children.isNotEmpty ? children.first.id : null),
      children: widgetChildren,
      recentRecords: existingData.recentRecords, // 既存のレコードを維持
    );
    await _widgetRepository.saveWidgetData(childOnlyData);

    // 4. レコードを取得してマージ（失敗しても子供情報は既に保存済み）
    final recentRecords = <String, List<WidgetRecord>>{};
    final now = DateTime.now();

    for (final child in children) {
      try {
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
      } catch (e) {
        // 個別の子供のレコード取得失敗は、既存データを維持
        final existingChildRecords = existingData.recentRecords[child.id];
        if (existingChildRecords != null) {
          recentRecords[child.id] = existingChildRecords;
        }
      }
    }

    // 5. レコードも含めた完全なデータを保存
    if (recentRecords.isNotEmpty) {
      final fullData = childOnlyData.copyWith(
        lastUpdated: DateTime.now(),
        recentRecords: recentRecords,
      );
      await _widgetRepository.saveWidgetData(fullData);
    }

    await _widgetRepository.notifyWidgetUpdate();
  }
}
