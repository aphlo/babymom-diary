// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineSettingsState {
  VaccineSettings get settings;
  bool get isLoading;
  String? get error;

  /// Create a copy of VaccineSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineSettingsStateCopyWith<VaccineSettingsState> get copyWith =>
      _$VaccineSettingsStateCopyWithImpl<VaccineSettingsState>(
          this as VaccineSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineSettingsState &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings, isLoading, error);

  @override
  String toString() {
    return 'VaccineSettingsState(settings: $settings, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $VaccineSettingsStateCopyWith<$Res> {
  factory $VaccineSettingsStateCopyWith(VaccineSettingsState value,
          $Res Function(VaccineSettingsState) _then) =
      _$VaccineSettingsStateCopyWithImpl;
  @useResult
  $Res call({VaccineSettings settings, bool isLoading, String? error});

  $VaccineSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$VaccineSettingsStateCopyWithImpl<$Res>
    implements $VaccineSettingsStateCopyWith<$Res> {
  _$VaccineSettingsStateCopyWithImpl(this._self, this._then);

  final VaccineSettingsState _self;
  final $Res Function(VaccineSettingsState) _then;

  /// Create a copy of VaccineSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as VaccineSettings,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of VaccineSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VaccineSettingsCopyWith<$Res> get settings {
    return $VaccineSettingsCopyWith<$Res>(_self.settings, (value) {
      return _then(_self.copyWith(settings: value));
    });
  }
}

/// Adds pattern-matching-related methods to [VaccineSettingsState].
extension VaccineSettingsStatePatterns on VaccineSettingsState {
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
    TResult Function(_VaccineSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineSettingsState() when $default != null:
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
    TResult Function(_VaccineSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettingsState():
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
    TResult? Function(_VaccineSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettingsState() when $default != null:
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
    TResult Function(VaccineSettings settings, bool isLoading, String? error)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineSettingsState() when $default != null:
        return $default(_that.settings, _that.isLoading, _that.error);
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
    TResult Function(VaccineSettings settings, bool isLoading, String? error)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettingsState():
        return $default(_that.settings, _that.isLoading, _that.error);
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
    TResult? Function(VaccineSettings settings, bool isLoading, String? error)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineSettingsState() when $default != null:
        return $default(_that.settings, _that.isLoading, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineSettingsState implements VaccineSettingsState {
  const _VaccineSettingsState(
      {required this.settings, this.isLoading = false, this.error});

  @override
  final VaccineSettings settings;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  /// Create a copy of VaccineSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineSettingsStateCopyWith<_VaccineSettingsState> get copyWith =>
      __$VaccineSettingsStateCopyWithImpl<_VaccineSettingsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineSettingsState &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings, isLoading, error);

  @override
  String toString() {
    return 'VaccineSettingsState(settings: $settings, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$VaccineSettingsStateCopyWith<$Res>
    implements $VaccineSettingsStateCopyWith<$Res> {
  factory _$VaccineSettingsStateCopyWith(_VaccineSettingsState value,
          $Res Function(_VaccineSettingsState) _then) =
      __$VaccineSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({VaccineSettings settings, bool isLoading, String? error});

  @override
  $VaccineSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$VaccineSettingsStateCopyWithImpl<$Res>
    implements _$VaccineSettingsStateCopyWith<$Res> {
  __$VaccineSettingsStateCopyWithImpl(this._self, this._then);

  final _VaccineSettingsState _self;
  final $Res Function(_VaccineSettingsState) _then;

  /// Create a copy of VaccineSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_VaccineSettingsState(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as VaccineSettings,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of VaccineSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VaccineSettingsCopyWith<$Res> get settings {
    return $VaccineSettingsCopyWith<$Res>(_self.settings, (value) {
      return _then(_self.copyWith(settings: value));
    });
  }
}

// dart format on
