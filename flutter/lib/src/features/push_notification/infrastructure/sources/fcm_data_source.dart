import 'package:cloud_functions/cloud_functions.dart';

class FcmDataSource {
  FcmDataSource(this._functions);

  final FirebaseFunctions _functions;

  Future<void> registerToken({
    required String token,
    required String deviceId,
    required String platform,
  }) async {
    final callable = _functions.httpsCallable('register-fcm-token');
    await callable.call<void>({
      'token': token,
      'deviceId': deviceId,
      'platform': platform,
    });
  }

  Future<void> unregisterToken({
    required String deviceId,
  }) async {
    final callable = _functions.httpsCallable('unregister-fcm-token');
    await callable.call<void>({
      'deviceId': deviceId,
    });
  }
}
