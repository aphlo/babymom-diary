// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsState {
  bool get isLoading;
  String? get error;
  NotificationSettings? get settings;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationSettingsStateCopyWith<NotificationSettingsState> get copyWith =>
      _$NotificationSettingsStateCopyWithImpl<NotificationSettingsState>(
          this as NotificationSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationSettingsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error, settings);

  @override
  String toString() {
    return 'NotificationSettingsState(isLoading: $isLoading, error: $error, settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $NotificationSettingsStateCopyWith<$Res> {
  factory $NotificationSettingsStateCopyWith(NotificationSettingsState value,
          $Res Function(NotificationSettingsState) _then) =
      _$NotificationSettingsStateCopyWithImpl;
  @useResult
  $Res call({bool isLoading, String? error, NotificationSettings? settings});

  $NotificationSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$NotificationSettingsStateCopyWithImpl<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  _$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final NotificationSettingsState _self;
  final $Res Function(NotificationSettingsState) _then;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? settings = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings?,
    ));
  }

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
      return null;
    }

    return $NotificationSettingsCopyWith<$Res>(_self.settings!, (value) {
      return _then(_self.copyWith(settings: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NotificationSettingsState].
extension NotificationSettingsStatePatterns on NotificationSettingsState {
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
    TResult Function(_NotificationSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsState() when $default != null:
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
    TResult Function(_NotificationSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsState():
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
    TResult? Function(_NotificationSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsState() when $default != null:
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
            bool isLoading, String? error, NotificationSettings? settings)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.settings);
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
    TResult Function(
            bool isLoading, String? error, NotificationSettings? settings)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsState():
        return $default(_that.isLoading, _that.error, _that.settings);
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
            bool isLoading, String? error, NotificationSettings? settings)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.settings);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NotificationSettingsState extends NotificationSettingsState {
  const _NotificationSettingsState(
      {this.isLoading = true, this.error, this.settings})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final NotificationSettings? settings;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationSettingsStateCopyWith<_NotificationSettingsState>
      get copyWith =>
          __$NotificationSettingsStateCopyWithImpl<_NotificationSettingsState>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationSettingsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error, settings);

  @override
  String toString() {
    return 'NotificationSettingsState(isLoading: $isLoading, error: $error, settings: $settings)';
  }
}

/// @nodoc
abstract mixin class _$NotificationSettingsStateCopyWith<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  factory _$NotificationSettingsStateCopyWith(_NotificationSettingsState value,
          $Res Function(_NotificationSettingsState) _then) =
      __$NotificationSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoading, String? error, NotificationSettings? settings});

  @override
  $NotificationSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$NotificationSettingsStateCopyWithImpl<$Res>
    implements _$NotificationSettingsStateCopyWith<$Res> {
  __$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final _NotificationSettingsState _self;
  final $Res Function(_NotificationSettingsState) _then;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? settings = freezed,
  }) {
    return _then(_NotificationSettingsState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings?,
    ));
  }

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
      return null;
    }

    return $NotificationSettingsCopyWith<$Res>(_self.settings!, (value) {
      return _then(_self.copyWith(settings: value));
    });
  }
}

// dart format on
