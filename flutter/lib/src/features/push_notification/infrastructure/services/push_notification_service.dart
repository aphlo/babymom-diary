import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/usecases/register_fcm_token.dart';
import '../repositories/notification_repository_impl.dart';

part 'push_notification_service.g.dart';

class PushNotificationService {
  PushNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required RegisterFcmToken registerFcmToken,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _registerFcmToken = registerFcmToken;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final RegisterFcmToken _registerFcmToken;

  static const String _deviceIdKey = 'fcm_device_id';
  static const String _channelId = 'milu_notifications';
  static const String _channelName = 'milu通知';
  static const String _channelDescription = 'miluからの通知';

  Future<void> initialize() async {
    // 1. ローカル通知の初期化
    await _initializeLocalNotifications();

    // 2. FCMトークンを取得・登録（許可状態に関係なく）
    await _registerToken();

    // 3. トークンリフレッシュをリッスン（許可状態に関係なく）
    _messaging.onTokenRefresh.listen((_) {
      _registerToken();
    });

    // 4. プッシュ通知の許可をリクエスト（ダイアログ表示）
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // 5. フォアグラウンド通知設定
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Androidの通知チャンネルを作成
    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
      );
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  Future<void> _registerToken() async {
    debugPrint('[PushNotification] _registerToken started');
    String? token;

    // iOSではAPNSトークンが設定されるまで待つ（最大10秒）
    if (Platform.isIOS) {
      debugPrint('[PushNotification] iOS: Waiting for APNS token...');
      for (var i = 0; i < 10; i++) {
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null) {
          debugPrint('[PushNotification] iOS: APNS token received');
          break;
        }
        debugPrint(
            '[PushNotification] iOS: APNS token not ready, retry ${i + 1}/10');
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    try {
      token = await _messaging.getToken();
      debugPrint('[PushNotification] FCM token: ${token?.substring(0, 20)}...');
    } catch (e) {
      debugPrint('[PushNotification] Failed to get FCM token: $e');
      return;
    }

    if (token == null) {
      debugPrint('[PushNotification] FCM token is null, aborting');
      return;
    }

    final deviceId = await _getOrCreateDeviceId();
    final platform = Platform.isIOS ? 'ios' : 'android';
    debugPrint(
        '[PushNotification] Registering token - deviceId: $deviceId, platform: $platform');

    try {
      await _registerFcmToken.call(
        token: token,
        deviceId: deviceId,
        platform: platform,
      );
      debugPrint('[PushNotification] Token registered successfully');
    } catch (e) {
      debugPrint('[PushNotification] Failed to register token: $e');
    }
  }

  Future<String> _getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    var deviceId = prefs.getString(_deviceIdKey);
    if (deviceId == null) {
      deviceId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString(_deviceIdKey, deviceId);
    }
    return deviceId;
  }

  void _onNotificationTapped(NotificationResponse response) {
    // 通知タップ時の処理（必要に応じて実装）
  }

  void setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen(_showLocalNotification);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
    );
  }

  Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceIdKey);
  }
}

@Riverpod(keepAlive: true)
FirebaseMessaging firebaseMessaging(Ref ref) {
  return FirebaseMessaging.instance;
}

@Riverpod(keepAlive: true)
FlutterLocalNotificationsPlugin flutterLocalNotifications(Ref ref) {
  return FlutterLocalNotificationsPlugin();
}

@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(Ref ref) {
  return PushNotificationService(
    messaging: ref.watch(firebaseMessagingProvider),
    localNotifications: ref.watch(flutterLocalNotificationsProvider),
    registerFcmToken:
        RegisterFcmToken(ref.watch(notificationRepositoryProvider)),
  );
}
