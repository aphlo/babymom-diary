import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/firebase/household_service.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';
import '../sources/fcm_data_source.dart';
import '../sources/notification_settings_firestore_data_source.dart';

part 'notification_repository_impl.g.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required NotificationSettingsFirestoreDataSource settingsDataSource,
    required FcmDataSource fcmDataSource,
  })  : _settingsDataSource = settingsDataSource,
        _fcmDataSource = fcmDataSource;

  final NotificationSettingsFirestoreDataSource _settingsDataSource;
  final FcmDataSource _fcmDataSource;

  @override
  Future<NotificationSettings?> getSettings({required String uid}) {
    return _settingsDataSource.getSettings(uid: uid);
  }

  @override
  Stream<NotificationSettings?> watchSettings({required String uid}) {
    return _settingsDataSource.watchSettings(uid: uid);
  }

  @override
  Future<void> updateSettings({
    required String uid,
    required NotificationSettings settings,
  }) {
    return _settingsDataSource.updateSettings(
      uid: uid,
      settings: settings,
    );
  }

  @override
  Future<void> registerFcmToken({
    required String token,
    required String deviceId,
    required String platform,
  }) {
    return _fcmDataSource.registerToken(
      token: token,
      deviceId: deviceId,
      platform: platform,
    );
  }

  @override
  Future<void> unregisterFcmToken({required String deviceId}) {
    return _fcmDataSource.unregisterToken(deviceId: deviceId);
  }
}

@Riverpod(keepAlive: true)
NotificationSettingsFirestoreDataSource notificationSettingsDataSource(
    Ref ref) {
  return NotificationSettingsFirestoreDataSource(
      ref.watch(firebaseFirestoreProvider));
}

@Riverpod(keepAlive: true)
FcmDataSource fcmDataSource(Ref ref) {
  return FcmDataSource(ref.watch(firebaseFunctionsProvider));
}

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    settingsDataSource: ref.watch(notificationSettingsDataSourceProvider),
    fcmDataSource: ref.watch(fcmDataSourceProvider),
  );
}
