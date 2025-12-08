import 'dart:convert';
import 'dart:io';

import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/widget_data.dart';
import '../../domain/entities/widget_record.dart';
import '../../domain/entities/widget_settings.dart';
import '../../domain/repositories/widget_data_repository.dart';

/// ウィジェットデータリポジトリの実装
class WidgetDataRepositoryImpl implements WidgetDataRepository {
  static const _widgetDataKey = 'widget_data';
  static const _widgetSettingsKey = 'widget_settings';
  static const _iOSWidgetName = 'MiluWidget';
  // Android: mainソースセットのクラス名をフルパスで指定
  // AndroidManifest.xmlで .widget.MiluWidgetProvider と指定しているが、
  // 実際に登録されるComponentNameはmainソースセットのクラスになる
  static const _androidWidgetName =
      'com.aphlo.babymomdiary.widget.MiluWidgetProvider';
  static const _androidSmallWidgetName =
      'com.aphlo.babymomdiary.widget.MiluWidgetSmallProvider';

  final SharedPreferences _prefs;

  WidgetDataRepositoryImpl(this._prefs);

  /// 初期化（iOS App Group設定）
  /// [isProduction] が true の場合は本番用のApp Groupを使用
  static Future<void> initialize({required bool isProduction}) async {
    final appGroupId = isProduction
        ? 'group.com.aphlo.babymomdiary'
        : 'group.com.aphlo.babymomdiary.stg';
    await HomeWidget.setAppGroupId(appGroupId);
  }

  @override
  Future<WidgetData> getWidgetData() async {
    final jsonString = await HomeWidget.getWidgetData<String>(_widgetDataKey);
    if (jsonString == null) {
      return WidgetData.empty();
    }
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return WidgetData.fromJson(json);
    } catch (_) {
      return WidgetData.empty();
    }
  }

  @override
  Future<void> saveWidgetData(WidgetData data) async {
    final jsonString = jsonEncode(data.toJson());
    await HomeWidget.saveWidgetData<String>(_widgetDataKey, jsonString);
  }

  @override
  Future<WidgetSettings> getWidgetSettings() async {
    final jsonString = _prefs.getString(_widgetSettingsKey);
    if (jsonString == null) {
      return const WidgetSettings();
    }
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return WidgetSettings.fromJson(json);
    } catch (_) {
      return const WidgetSettings();
    }
  }

  @override
  Future<void> saveWidgetSettings(WidgetSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_widgetSettingsKey, jsonString);

    // 設定もウィジェットに共有
    await HomeWidget.saveWidgetData<String>(_widgetSettingsKey, jsonString);
    await notifyWidgetUpdate();
  }

  @override
  Future<void> updateChildRecords(
    String childId,
    List<WidgetRecord> records,
  ) async {
    final data = await getWidgetData();
    final updatedRecords =
        Map<String, List<WidgetRecord>>.from(data.recentRecords);
    updatedRecords[childId] = records;

    final updatedData = data.copyWith(
      lastUpdated: DateTime.now(),
      recentRecords: updatedRecords,
    );
    await saveWidgetData(updatedData);
  }

  @override
  Future<void> updateSelectedChildId(String childId) async {
    final data = await getWidgetData();
    final updatedData = data.copyWith(
      lastUpdated: DateTime.now(),
      selectedChildId: childId,
    );
    await saveWidgetData(updatedData);
    await notifyWidgetUpdate();
  }

  @override
  Future<void> notifyWidgetUpdate() async {
    // プラットフォームごとにウィジェット更新通知を送信
    try {
      if (Platform.isIOS) {
        await HomeWidget.updateWidget(
          name: _iOSWidgetName,
          iOSName: _iOSWidgetName,
        );
      } else if (Platform.isAndroid) {
        // Medium widget
        await HomeWidget.updateWidget(
          qualifiedAndroidName: _androidWidgetName,
        );
        // Small widget
        await HomeWidget.updateWidget(
          qualifiedAndroidName: _androidSmallWidgetName,
        );
      }
    } catch (e) {
      // ウィジェット更新エラーは無視（ウィジェットが配置されていない場合など）
    }
  }
}
