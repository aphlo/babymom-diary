// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_requirement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateRequirement {
  AppVersion get minimumVersion;
  String get message;
  String get storeUrl;

  /// Create a copy of UpdateRequirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateRequirementCopyWith<UpdateRequirement> get copyWith =>
      _$UpdateRequirementCopyWithImpl<UpdateRequirement>(
          this as UpdateRequirement, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateRequirement &&
            (identical(other.minimumVersion, minimumVersion) ||
                other.minimumVersion == minimumVersion) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.storeUrl, storeUrl) ||
                other.storeUrl == storeUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, minimumVersion, message, storeUrl);

  @override
  String toString() {
    return 'UpdateRequirement(minimumVersion: $minimumVersion, message: $message, storeUrl: $storeUrl)';
  }
}

/// @nodoc
abstract mixin class $UpdateRequirementCopyWith<$Res> {
  factory $UpdateRequirementCopyWith(
          UpdateRequirement value, $Res Function(UpdateRequirement) _then) =
      _$UpdateRequirementCopyWithImpl;
  @useResult
  $Res call({AppVersion minimumVersion, String message, String storeUrl});

  $AppVersionCopyWith<$Res> get minimumVersion;
}

/// @nodoc
class _$UpdateRequirementCopyWithImpl<$Res>
    implements $UpdateRequirementCopyWith<$Res> {
  _$UpdateRequirementCopyWithImpl(this._self, this._then);

  final UpdateRequirement _self;
  final $Res Function(UpdateRequirement) _then;

  /// Create a copy of UpdateRequirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minimumVersion = null,
    Object? message = null,
    Object? storeUrl = null,
  }) {
    return _then(_self.copyWith(
      minimumVersion: null == minimumVersion
          ? _self.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as AppVersion,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      storeUrl: null == storeUrl
          ? _self.storeUrl
          : storeUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of UpdateRequirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppVersionCopyWith<$Res> get minimumVersion {
    return $AppVersionCopyWith<$Res>(_self.minimumVersion, (value) {
      return _then(_self.copyWith(minimumVersion: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UpdateRequirement].
extension UpdateRequirementPatterns on UpdateRequirement {
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
    TResult Function(_UpdateRequirement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateRequirement() when $default != null:
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
    TResult Function(_UpdateRequirement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequirement():
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
    TResult? Function(_UpdateRequirement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequirement() when $default != null:
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
    TResult Function(
            AppVersion minimumVersion, String message, String storeUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateRequirement() when $default != null:
        return $default(_that.minimumVersion, _that.message, _that.storeUrl);
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
    TResult Function(AppVersion minimumVersion, String message, String storeUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequirement():
        return $default(_that.minimumVersion, _that.message, _that.storeUrl);
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
    TResult? Function(
            AppVersion minimumVersion, String message, String storeUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateRequirement() when $default != null:
        return $default(_that.minimumVersion, _that.message, _that.storeUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UpdateRequirement implements UpdateRequirement {
  const _UpdateRequirement(
      {required this.minimumVersion,
      required this.message,
      required this.storeUrl});

  @override
  final AppVersion minimumVersion;
  @override
  final String message;
  @override
  final String storeUrl;

  /// Create a copy of UpdateRequirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateRequirementCopyWith<_UpdateRequirement> get copyWith =>
      __$UpdateRequirementCopyWithImpl<_UpdateRequirement>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateRequirement &&
            (identical(other.minimumVersion, minimumVersion) ||
                other.minimumVersion == minimumVersion) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.storeUrl, storeUrl) ||
                other.storeUrl == storeUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, minimumVersion, message, storeUrl);

  @override
  String toString() {
    return 'UpdateRequirement(minimumVersion: $minimumVersion, message: $message, storeUrl: $storeUrl)';
  }
}

/// @nodoc
abstract mixin class _$UpdateRequirementCopyWith<$Res>
    implements $UpdateRequirementCopyWith<$Res> {
  factory _$UpdateRequirementCopyWith(
          _UpdateRequirement value, $Res Function(_UpdateRequirement) _then) =
      __$UpdateRequirementCopyWithImpl;
  @override
  @useResult
  $Res call({AppVersion minimumVersion, String message, String storeUrl});

  @override
  $AppVersionCopyWith<$Res> get minimumVersion;
}

/// @nodoc
class __$UpdateRequirementCopyWithImpl<$Res>
    implements _$UpdateRequirementCopyWith<$Res> {
  __$UpdateRequirementCopyWithImpl(this._self, this._then);

  final _UpdateRequirement _self;
  final $Res Function(_UpdateRequirement) _then;

  /// Create a copy of UpdateRequirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minimumVersion = null,
    Object? message = null,
    Object? storeUrl = null,
  }) {
    return _then(_UpdateRequirement(
      minimumVersion: null == minimumVersion
          ? _self.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as AppVersion,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      storeUrl: null == storeUrl
          ? _self.storeUrl
          : storeUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of UpdateRequirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppVersionCopyWith<$Res> get minimumVersion {
    return $AppVersionCopyWith<$Res>(_self.minimumVersion, (value) {
      return _then(_self.copyWith(minimumVersion: value));
    });
  }
}

// dart format on
