// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarSettingsState {
  CalendarSettings get settings;
  bool get isLoading;
  String? get error;

  /// Create a copy of CalendarSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalendarSettingsStateCopyWith<CalendarSettingsState> get copyWith =>
      _$CalendarSettingsStateCopyWithImpl<CalendarSettingsState>(
          this as CalendarSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalendarSettingsState &&
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
    return 'CalendarSettingsState(settings: $settings, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $CalendarSettingsStateCopyWith<$Res> {
  factory $CalendarSettingsStateCopyWith(CalendarSettingsState value,
          $Res Function(CalendarSettingsState) _then) =
      _$CalendarSettingsStateCopyWithImpl;
  @useResult
  $Res call({CalendarSettings settings, bool isLoading, String? error});
}

/// @nodoc
class _$CalendarSettingsStateCopyWithImpl<$Res>
    implements $CalendarSettingsStateCopyWith<$Res> {
  _$CalendarSettingsStateCopyWithImpl(this._self, this._then);

  final CalendarSettingsState _self;
  final $Res Function(CalendarSettingsState) _then;

  /// Create a copy of CalendarSettingsState
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
              as CalendarSettings,
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
}

/// Adds pattern-matching-related methods to [CalendarSettingsState].
extension CalendarSettingsStatePatterns on CalendarSettingsState {
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
    TResult Function(_CalendarSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarSettingsState() when $default != null:
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
    TResult Function(_CalendarSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettingsState():
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
    TResult? Function(_CalendarSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettingsState() when $default != null:
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
    TResult Function(CalendarSettings settings, bool isLoading, String? error)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarSettingsState() when $default != null:
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
    TResult Function(CalendarSettings settings, bool isLoading, String? error)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettingsState():
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
    TResult? Function(CalendarSettings settings, bool isLoading, String? error)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettingsState() when $default != null:
        return $default(_that.settings, _that.isLoading, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CalendarSettingsState implements CalendarSettingsState {
  const _CalendarSettingsState(
      {required this.settings, this.isLoading = false, this.error});

  @override
  final CalendarSettings settings;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  /// Create a copy of CalendarSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalendarSettingsStateCopyWith<_CalendarSettingsState> get copyWith =>
      __$CalendarSettingsStateCopyWithImpl<_CalendarSettingsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalendarSettingsState &&
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
    return 'CalendarSettingsState(settings: $settings, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$CalendarSettingsStateCopyWith<$Res>
    implements $CalendarSettingsStateCopyWith<$Res> {
  factory _$CalendarSettingsStateCopyWith(_CalendarSettingsState value,
          $Res Function(_CalendarSettingsState) _then) =
      __$CalendarSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({CalendarSettings settings, bool isLoading, String? error});
}

/// @nodoc
class __$CalendarSettingsStateCopyWithImpl<$Res>
    implements _$CalendarSettingsStateCopyWith<$Res> {
  __$CalendarSettingsStateCopyWithImpl(this._self, this._then);

  final _CalendarSettingsState _self;
  final $Res Function(_CalendarSettingsState) _then;

  /// Create a copy of CalendarSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_CalendarSettingsState(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as CalendarSettings,
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
}

// dart format on
