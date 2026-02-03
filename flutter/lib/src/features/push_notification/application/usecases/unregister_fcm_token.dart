import '../../domain/repositories/notification_repository.dart';

class UnregisterFcmToken {
  UnregisterFcmToken(this._repository);

  final NotificationRepository _repository;

  Future<void> call({required String deviceId}) async {
    await _repository.unregisterFcmToken(deviceId: deviceId);
  }
}
