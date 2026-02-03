import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/notification_settings.dart';
import '../models/notification_settings_dto.dart';

class NotificationSettingsFirestoreDataSource {
  NotificationSettingsFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _settingsRef(String uid) => _firestore
      .collection('users')
      .doc(uid)
      .collection('notification_settings')
      .doc('settings');

  Future<NotificationSettings?> getSettings({required String uid}) async {
    final doc = await _settingsRef(uid).get();
    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return NotificationSettingsDto.fromJson(doc.data()!).toEntity();
  }

  Stream<NotificationSettings?> watchSettings({required String uid}) {
    return _settingsRef(uid).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return NotificationSettingsDto.fromJson(doc.data()!).toEntity();
    });
  }

  Future<void> updateSettings({
    required String uid,
    required NotificationSettings settings,
  }) async {
    final dto = NotificationSettingsDto.fromEntity(settings);
    final data = dto.toJson();
    data['updatedAt'] = FieldValue.serverTimestamp();

    final docRef = _settingsRef(uid);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update(data);
    } else {
      data['createdAt'] = FieldValue.serverTimestamp();
      await docRef.set(data);
    }
  }

  Future<void> createDefaultSettings({required String uid}) async {
    final docRef = _settingsRef(uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      final defaultSettings = NotificationSettings.defaultSettings(uid);
      final dto = NotificationSettingsDto.fromEntity(defaultSettings);
      final data = dto.toJson();
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      await docRef.set(data);
    }
  }
}
