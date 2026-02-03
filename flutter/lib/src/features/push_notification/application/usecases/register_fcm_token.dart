import '../../domain/repositories/notification_repository.dart';

class RegisterFcmToken {
  RegisterFcmToken(this._repository);

  final NotificationRepository _repository;

  Future<void> call({
    required String token,
    required String deviceId,
    required String platform,
  }) async {
    await _repository.registerFcmToken(
      token: token,
      deviceId: deviceId,
      platform: platform,
    );
  }
}
