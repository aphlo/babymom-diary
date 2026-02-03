import '../entities/notification_settings.dart';

abstract class NotificationRepository {
  /// 通知設定を取得
  Future<NotificationSettings?> getSettings({required String uid});

  /// 通知設定をリアルタイムで監視
  Stream<NotificationSettings?> watchSettings({required String uid});

  /// 通知設定を更新
  Future<void> updateSettings({
    required String uid,
    required NotificationSettings settings,
  });

  /// FCMトークンを登録
  Future<void> registerFcmToken({
    required String token,
    required String deviceId,
    required String platform,
  });

  /// FCMトークンを削除
  Future<void> unregisterFcmToken({
    required String deviceId,
  });
}
