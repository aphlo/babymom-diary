// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FcmTokenInfo {
  String get token;
  String get deviceId;
  FcmPlatform get platform;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of FcmTokenInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FcmTokenInfoCopyWith<FcmTokenInfo> get copyWith =>
      _$FcmTokenInfoCopyWithImpl<FcmTokenInfo>(
          this as FcmTokenInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FcmTokenInfo &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, token, deviceId, platform, createdAt, updatedAt);

  @override
  String toString() {
    return 'FcmTokenInfo(token: $token, deviceId: $deviceId, platform: $platform, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $FcmTokenInfoCopyWith<$Res> {
  factory $FcmTokenInfoCopyWith(
          FcmTokenInfo value, $Res Function(FcmTokenInfo) _then) =
      _$FcmTokenInfoCopyWithImpl;
  @useResult
  $Res call(
      {String token,
      String deviceId,
      FcmPlatform platform,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$FcmTokenInfoCopyWithImpl<$Res> implements $FcmTokenInfoCopyWith<$Res> {
  _$FcmTokenInfoCopyWithImpl(this._self, this._then);

  final FcmTokenInfo _self;
  final $Res Function(FcmTokenInfo) _then;

  /// Create a copy of FcmTokenInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? deviceId = null,
    Object? platform = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as FcmPlatform,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [FcmTokenInfo].
extension FcmTokenInfoPatterns on FcmTokenInfo {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FcmTokenInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FcmTokenInfo() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FcmTokenInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FcmTokenInfo():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FcmTokenInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FcmTokenInfo() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String token, String deviceId, FcmPlatform platform,
            DateTime createdAt, DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FcmTokenInfo() when $default != null:
        return $default(_that.token, _that.deviceId, _that.platform,
            _that.createdAt, _that.updatedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String token, String deviceId, FcmPlatform platform,
            DateTime createdAt, DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FcmTokenInfo():
        return $default(_that.token, _that.deviceId, _that.platform,
            _that.createdAt, _that.updatedAt);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String token, String deviceId, FcmPlatform platform,
            DateTime createdAt, DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FcmTokenInfo() when $default != null:
        return $default(_that.token, _that.deviceId, _that.platform,
            _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FcmTokenInfo implements FcmTokenInfo {
  const _FcmTokenInfo(
      {required this.token,
      required this.deviceId,
      required this.platform,
      required this.createdAt,
      required this.updatedAt});

  @override
  final String token;
  @override
  final String deviceId;
  @override
  final FcmPlatform platform;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of FcmTokenInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FcmTokenInfoCopyWith<_FcmTokenInfo> get copyWith =>
      __$FcmTokenInfoCopyWithImpl<_FcmTokenInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FcmTokenInfo &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, token, deviceId, platform, createdAt, updatedAt);

  @override
  String toString() {
    return 'FcmTokenInfo(token: $token, deviceId: $deviceId, platform: $platform, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$FcmTokenInfoCopyWith<$Res>
    implements $FcmTokenInfoCopyWith<$Res> {
  factory _$FcmTokenInfoCopyWith(
          _FcmTokenInfo value, $Res Function(_FcmTokenInfo) _then) =
      __$FcmTokenInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String token,
      String deviceId,
      FcmPlatform platform,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$FcmTokenInfoCopyWithImpl<$Res>
    implements _$FcmTokenInfoCopyWith<$Res> {
  __$FcmTokenInfoCopyWithImpl(this._self, this._then);

  final _FcmTokenInfo _self;
  final $Res Function(_FcmTokenInfo) _then;

  /// Create a copy of FcmTokenInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? deviceId = null,
    Object? platform = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_FcmTokenInfo(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as FcmPlatform,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
