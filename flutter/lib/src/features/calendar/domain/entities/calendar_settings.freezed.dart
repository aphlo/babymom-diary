// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarSettings {
  /// 週の開始曜日（月曜始まり: true, 日曜始まり: false）
  bool get startingDayOfWeek;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalendarSettingsCopyWith<CalendarSettings> get copyWith =>
      _$CalendarSettingsCopyWithImpl<CalendarSettings>(
          this as CalendarSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalendarSettings &&
            (identical(other.startingDayOfWeek, startingDayOfWeek) ||
                other.startingDayOfWeek == startingDayOfWeek));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startingDayOfWeek);

  @override
  String toString() {
    return 'CalendarSettings(startingDayOfWeek: $startingDayOfWeek)';
  }
}

/// @nodoc
abstract mixin class $CalendarSettingsCopyWith<$Res> {
  factory $CalendarSettingsCopyWith(
          CalendarSettings value, $Res Function(CalendarSettings) _then) =
      _$CalendarSettingsCopyWithImpl;
  @useResult
  $Res call({bool startingDayOfWeek});
}

/// @nodoc
class _$CalendarSettingsCopyWithImpl<$Res>
    implements $CalendarSettingsCopyWith<$Res> {
  _$CalendarSettingsCopyWithImpl(this._self, this._then);

  final CalendarSettings _self;
  final $Res Function(CalendarSettings) _then;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startingDayOfWeek = null,
  }) {
    return _then(_self.copyWith(
      startingDayOfWeek: null == startingDayOfWeek
          ? _self.startingDayOfWeek
          : startingDayOfWeek // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [CalendarSettings].
extension CalendarSettingsPatterns on CalendarSettings {
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
    TResult Function(_CalendarSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarSettings() when $default != null:
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
    TResult Function(_CalendarSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettings():
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
    TResult? Function(_CalendarSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettings() when $default != null:
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
    TResult Function(bool startingDayOfWeek)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarSettings() when $default != null:
        return $default(_that.startingDayOfWeek);
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
    TResult Function(bool startingDayOfWeek) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettings():
        return $default(_that.startingDayOfWeek);
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
    TResult? Function(bool startingDayOfWeek)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarSettings() when $default != null:
        return $default(_that.startingDayOfWeek);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CalendarSettings implements CalendarSettings {
  const _CalendarSettings({required this.startingDayOfWeek});

  /// 週の開始曜日（月曜始まり: true, 日曜始まり: false）
  @override
  final bool startingDayOfWeek;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalendarSettingsCopyWith<_CalendarSettings> get copyWith =>
      __$CalendarSettingsCopyWithImpl<_CalendarSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalendarSettings &&
            (identical(other.startingDayOfWeek, startingDayOfWeek) ||
                other.startingDayOfWeek == startingDayOfWeek));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startingDayOfWeek);

  @override
  String toString() {
    return 'CalendarSettings(startingDayOfWeek: $startingDayOfWeek)';
  }
}

/// @nodoc
abstract mixin class _$CalendarSettingsCopyWith<$Res>
    implements $CalendarSettingsCopyWith<$Res> {
  factory _$CalendarSettingsCopyWith(
          _CalendarSettings value, $Res Function(_CalendarSettings) _then) =
      __$CalendarSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({bool startingDayOfWeek});
}

/// @nodoc
class __$CalendarSettingsCopyWithImpl<$Res>
    implements _$CalendarSettingsCopyWith<$Res> {
  __$CalendarSettingsCopyWithImpl(this._self, this._then);

  final _CalendarSettings _self;
  final $Res Function(_CalendarSettings) _then;

  /// Create a copy of CalendarSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startingDayOfWeek = null,
  }) {
    return _then(_CalendarSettings(
      startingDayOfWeek: null == startingDayOfWeek
          ? _self.startingDayOfWeek
          : startingDayOfWeek // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
