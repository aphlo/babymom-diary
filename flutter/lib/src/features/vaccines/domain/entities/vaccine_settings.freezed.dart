// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineSettings {
  VaccineViewMode get viewMode;

  /// Create a copy of VaccineSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineSettingsCopyWith<VaccineSettings> get copyWith =>
      _$VaccineSettingsCopyWithImpl<VaccineSettings>(
          this as VaccineSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineSettings &&
            (identical(other.viewMode, viewMode) ||
                other.viewMode == viewMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, viewMode);

  @override
  String toString() {
    return 'VaccineSettings(viewMode: $viewMode)';
  }
}

/// @nodoc
abstract mixin class $VaccineSettingsCopyWith<$Res> {
  factory $VaccineSettingsCopyWith(
          VaccineSettings value, $Res Function(VaccineSettings) _then) =
      _$VaccineSettingsCopyWithImpl;
  @useResult
  $Res call({VaccineViewMode viewMode});
}

/// @nodoc
class _$VaccineSettingsCopyWithImpl<$Res>
    implements $VaccineSettingsCopyWith<$Res> {
  _$VaccineSettingsCopyWithImpl(this._self, this._then);

  final VaccineSettings _self;
  final $Res Function(VaccineSettings) _then;

  /// Create a copy of VaccineSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewMode = null,
  }) {
    return _then(_self.copyWith(
      viewMode: null == viewMode
          ? _self.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as VaccineViewMode,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineSettings].
extension VaccineSettingsPatterns on VaccineSettings {
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
    TResult Function(_VaccineSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineSettings() when $default != null:
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
    TResult Function(_VaccineSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettings():
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
    TResult? Function(_VaccineSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettings() when $default != null:
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
    TResult Function(VaccineViewMode viewMode)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineSettings() when $default != null:
        return $default(_that.viewMode);
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
    TResult Function(VaccineViewMode viewMode) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettings():
        return $default(_that.viewMode);
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
    TResult? Function(VaccineViewMode viewMode)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettings() when $default != null:
        return $default(_that.viewMode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineSettings implements VaccineSettings {
  const _VaccineSettings({this.viewMode = VaccineViewMode.table});

  @override
  @JsonKey()
  final VaccineViewMode viewMode;

  /// Create a copy of VaccineSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineSettingsCopyWith<_VaccineSettings> get copyWith =>
      __$VaccineSettingsCopyWithImpl<_VaccineSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineSettings &&
            (identical(other.viewMode, viewMode) ||
                other.viewMode == viewMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, viewMode);

  @override
  String toString() {
    return 'VaccineSettings(viewMode: $viewMode)';
  }
}

/// @nodoc
abstract mixin class _$VaccineSettingsCopyWith<$Res>
    implements $VaccineSettingsCopyWith<$Res> {
  factory _$VaccineSettingsCopyWith(
          _VaccineSettings value, $Res Function(_VaccineSettings) _then) =
      __$VaccineSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({VaccineViewMode viewMode});
}

/// @nodoc
class __$VaccineSettingsCopyWithImpl<$Res>
    implements _$VaccineSettingsCopyWith<$Res> {
  __$VaccineSettingsCopyWithImpl(this._self, this._then);

  final _VaccineSettings _self;
  final $Res Function(_VaccineSettings) _then;

  /// Create a copy of VaccineSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? viewMode = null,
  }) {
    return _then(_VaccineSettings(
      viewMode: null == viewMode
          ? _self.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as VaccineViewMode,
    ));
  }
}

// dart format on
