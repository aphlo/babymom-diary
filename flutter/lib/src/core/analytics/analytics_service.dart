import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Google Analyticsサービス
///
/// 画面遷移やカスタムイベントの記録を行う
class AnalyticsService {
  AnalyticsService({
    required this.analytics,
    this.enabled = true,
  });

  final FirebaseAnalytics analytics;
  final bool enabled;

  /// 画面遷移を記録する
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!enabled) return;

    await analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );

    if (kDebugMode) {
      print('[Analytics] Screen view: $screenName');
    }
  }

  /// カスタムイベントを記録する
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    if (!enabled) return;

    await analytics.logEvent(
      name: name,
      parameters: parameters,
    );

    if (kDebugMode) {
      print('[Analytics] Event: $name, params: $parameters');
    }
  }

  /// ユーザープロパティを設定する
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    if (!enabled) return;

    await analytics.setUserProperty(name: name, value: value);

    if (kDebugMode) {
      print('[Analytics] User property: $name = $value');
    }
  }

  /// NavigatorObserverを取得する（go_router用）
  FirebaseAnalyticsObserver get observer => FirebaseAnalyticsObserver(
        analytics: analytics,
        nameExtractor: _screenNameExtractor,
      );

  /// ルート設定から画面名を抽出する
  String? _screenNameExtractor(RouteSettings settings) {
    // ルート名またはパスを画面名として使用
    return settings.name;
  }
}

/// FirebaseAnalyticsのインスタンスを提供
final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

/// Analyticsが有効かどうかを管理するProvider
/// main_prod.dartでtrueにoverrideする
final analyticsEnabledProvider = Provider<bool>((ref) => false);

/// AnalyticsServiceのインスタンスを提供
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final analytics = ref.watch(firebaseAnalyticsProvider);
  final enabled = ref.watch(analyticsEnabledProvider);
  return AnalyticsService(
    analytics: analytics,
    enabled: enabled,
  );
});
