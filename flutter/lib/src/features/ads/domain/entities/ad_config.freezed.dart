// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdConfig {
  String get bannerAdUnitId;
  bool get isTestMode;

  /// Create a copy of AdConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdConfigCopyWith<AdConfig> get copyWith =>
      _$AdConfigCopyWithImpl<AdConfig>(this as AdConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdConfig &&
            (identical(other.bannerAdUnitId, bannerAdUnitId) ||
                other.bannerAdUnitId == bannerAdUnitId) &&
            (identical(other.isTestMode, isTestMode) ||
                other.isTestMode == isTestMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bannerAdUnitId, isTestMode);

  @override
  String toString() {
    return 'AdConfig(bannerAdUnitId: $bannerAdUnitId, isTestMode: $isTestMode)';
  }
}

/// @nodoc
abstract mixin class $AdConfigCopyWith<$Res> {
  factory $AdConfigCopyWith(AdConfig value, $Res Function(AdConfig) _then) =
      _$AdConfigCopyWithImpl;
  @useResult
  $Res call({String bannerAdUnitId, bool isTestMode});
}

/// @nodoc
class _$AdConfigCopyWithImpl<$Res> implements $AdConfigCopyWith<$Res> {
  _$AdConfigCopyWithImpl(this._self, this._then);

  final AdConfig _self;
  final $Res Function(AdConfig) _then;

  /// Create a copy of AdConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bannerAdUnitId = null,
    Object? isTestMode = null,
  }) {
    return _then(_self.copyWith(
      bannerAdUnitId: null == bannerAdUnitId
          ? _self.bannerAdUnitId
          : bannerAdUnitId // ignore: cast_nullable_to_non_nullable
              as String,
      isTestMode: null == isTestMode
          ? _self.isTestMode
          : isTestMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AdConfig].
extension AdConfigPatterns on AdConfig {
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
    TResult Function(_AdConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AdConfig() when $default != null:
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
    TResult Function(_AdConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdConfig():
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
    TResult? Function(_AdConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdConfig() when $default != null:
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
    TResult Function(String bannerAdUnitId, bool isTestMode)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AdConfig() when $default != null:
        return $default(_that.bannerAdUnitId, _that.isTestMode);
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
    TResult Function(String bannerAdUnitId, bool isTestMode) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdConfig():
        return $default(_that.bannerAdUnitId, _that.isTestMode);
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
    TResult? Function(String bannerAdUnitId, bool isTestMode)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdConfig() when $default != null:
        return $default(_that.bannerAdUnitId, _that.isTestMode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AdConfig implements AdConfig {
  const _AdConfig({required this.bannerAdUnitId, required this.isTestMode});

  @override
  final String bannerAdUnitId;
  @override
  final bool isTestMode;

  /// Create a copy of AdConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdConfigCopyWith<_AdConfig> get copyWith =>
      __$AdConfigCopyWithImpl<_AdConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdConfig &&
            (identical(other.bannerAdUnitId, bannerAdUnitId) ||
                other.bannerAdUnitId == bannerAdUnitId) &&
            (identical(other.isTestMode, isTestMode) ||
                other.isTestMode == isTestMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bannerAdUnitId, isTestMode);

  @override
  String toString() {
    return 'AdConfig(bannerAdUnitId: $bannerAdUnitId, isTestMode: $isTestMode)';
  }
}

/// @nodoc
abstract mixin class _$AdConfigCopyWith<$Res>
    implements $AdConfigCopyWith<$Res> {
  factory _$AdConfigCopyWith(_AdConfig value, $Res Function(_AdConfig) _then) =
      __$AdConfigCopyWithImpl;
  @override
  @useResult
  $Res call({String bannerAdUnitId, bool isTestMode});
}

/// @nodoc
class __$AdConfigCopyWithImpl<$Res> implements _$AdConfigCopyWith<$Res> {
  __$AdConfigCopyWithImpl(this._self, this._then);

  final _AdConfig _self;
  final $Res Function(_AdConfig) _then;

  /// Create a copy of AdConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bannerAdUnitId = null,
    Object? isTestMode = null,
  }) {
    return _then(_AdConfig(
      bannerAdUnitId: null == bannerAdUnitId
          ? _self.bannerAdUnitId
          : bannerAdUnitId // ignore: cast_nullable_to_non_nullable
              as String,
      isTestMode: null == isTestMode
          ? _self.isTestMode
          : isTestMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
