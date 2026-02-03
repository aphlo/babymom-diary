import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';

class UpdateNotificationSettings {
  UpdateNotificationSettings(this._repository);

  final NotificationRepository _repository;

  Future<void> call({
    required String uid,
    required NotificationSettings settings,
  }) async {
    await _repository.updateSettings(
      uid: uid,
      settings: settings,
    );
  }
}
