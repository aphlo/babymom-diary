import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_info.freezed.dart';

@freezed
sealed class FcmTokenInfo with _$FcmTokenInfo {
  const factory FcmTokenInfo({
    required String token,
    required String deviceId,
    required FcmPlatform platform,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FcmTokenInfo;
}

enum FcmPlatform {
  ios,
  android,
}
