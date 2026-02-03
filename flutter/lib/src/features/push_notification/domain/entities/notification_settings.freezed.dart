// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettings {
  VaccineReminderSettings get vaccineReminder;
  DailyEncouragementSettings get dailyEncouragement;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      _$NotificationSettingsCopyWithImpl<NotificationSettings>(
          this as NotificationSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationSettings &&
            (identical(other.vaccineReminder, vaccineReminder) ||
                other.vaccineReminder == vaccineReminder) &&
            (identical(other.dailyEncouragement, dailyEncouragement) ||
                other.dailyEncouragement == dailyEncouragement) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, vaccineReminder, dailyEncouragement, createdAt, updatedAt);

  @override
  String toString() {
    return 'NotificationSettings(vaccineReminder: $vaccineReminder, dailyEncouragement: $dailyEncouragement, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) _then) =
      _$NotificationSettingsCopyWithImpl;
  @useResult
  $Res call(
      {VaccineReminderSettings vaccineReminder,
      DailyEncouragementSettings dailyEncouragement,
      DateTime createdAt,
      DateTime updatedAt});

  $VaccineReminderSettingsCopyWith<$Res> get vaccineReminder;
  $DailyEncouragementSettingsCopyWith<$Res> get dailyEncouragement;
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._self, this._then);

  final NotificationSettings _self;
  final $Res Function(NotificationSettings) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vaccineReminder = null,
    Object? dailyEncouragement = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      vaccineReminder: null == vaccineReminder
          ? _self.vaccineReminder
          : vaccineReminder // ignore: cast_nullable_to_non_nullable
              as VaccineReminderSettings,
      dailyEncouragement: null == dailyEncouragement
          ? _self.dailyEncouragement
          : dailyEncouragement // ignore: cast_nullable_to_non_nullable
              as DailyEncouragementSettings,
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

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VaccineReminderSettingsCopyWith<$Res> get vaccineReminder {
    return $VaccineReminderSettingsCopyWith<$Res>(_self.vaccineReminder,
        (value) {
      return _then(_self.copyWith(vaccineReminder: value));
    });
  }

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyEncouragementSettingsCopyWith<$Res> get dailyEncouragement {
    return $DailyEncouragementSettingsCopyWith<$Res>(_self.dailyEncouragement,
        (value) {
      return _then(_self.copyWith(dailyEncouragement: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NotificationSettings].
extension NotificationSettingsPatterns on NotificationSettings {
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
    TResult Function(_NotificationSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettings() when $default != null:
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
    TResult Function(_NotificationSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettings():
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
    TResult? Function(_NotificationSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettings() when $default != null:
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
            VaccineReminderSettings vaccineReminder,
            DailyEncouragementSettings dailyEncouragement,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettings() when $default != null:
        return $default(_that.vaccineReminder, _that.dailyEncouragement,
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
    TResult Function(
            VaccineReminderSettings vaccineReminder,
            DailyEncouragementSettings dailyEncouragement,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettings():
        return $default(_that.vaccineReminder, _that.dailyEncouragement,
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
    TResult? Function(
            VaccineReminderSettings vaccineReminder,
            DailyEncouragementSettings dailyEncouragement,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettings() when $default != null:
        return $default(_that.vaccineReminder, _that.dailyEncouragement,
            _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NotificationSettings extends NotificationSettings {
  const _NotificationSettings(
      {required this.vaccineReminder,
      required this.dailyEncouragement,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  @override
  final VaccineReminderSettings vaccineReminder;
  @override
  final DailyEncouragementSettings dailyEncouragement;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationSettingsCopyWith<_NotificationSettings> get copyWith =>
      __$NotificationSettingsCopyWithImpl<_NotificationSettings>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationSettings &&
            (identical(other.vaccineReminder, vaccineReminder) ||
                other.vaccineReminder == vaccineReminder) &&
            (identical(other.dailyEncouragement, dailyEncouragement) ||
                other.dailyEncouragement == dailyEncouragement) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, vaccineReminder, dailyEncouragement, createdAt, updatedAt);

  @override
  String toString() {
    return 'NotificationSettings(vaccineReminder: $vaccineReminder, dailyEncouragement: $dailyEncouragement, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$NotificationSettingsCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$NotificationSettingsCopyWith(_NotificationSettings value,
          $Res Function(_NotificationSettings) _then) =
      __$NotificationSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {VaccineReminderSettings vaccineReminder,
      DailyEncouragementSettings dailyEncouragement,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $VaccineReminderSettingsCopyWith<$Res> get vaccineReminder;
  @override
  $DailyEncouragementSettingsCopyWith<$Res> get dailyEncouragement;
}

/// @nodoc
class __$NotificationSettingsCopyWithImpl<$Res>
    implements _$NotificationSettingsCopyWith<$Res> {
  __$NotificationSettingsCopyWithImpl(this._self, this._then);

  final _NotificationSettings _self;
  final $Res Function(_NotificationSettings) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vaccineReminder = null,
    Object? dailyEncouragement = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_NotificationSettings(
      vaccineReminder: null == vaccineReminder
          ? _self.vaccineReminder
          : vaccineReminder // ignore: cast_nullable_to_non_nullable
              as VaccineReminderSettings,
      dailyEncouragement: null == dailyEncouragement
          ? _self.dailyEncouragement
          : dailyEncouragement // ignore: cast_nullable_to_non_nullable
              as DailyEncouragementSettings,
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

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VaccineReminderSettingsCopyWith<$Res> get vaccineReminder {
    return $VaccineReminderSettingsCopyWith<$Res>(_self.vaccineReminder,
        (value) {
      return _then(_self.copyWith(vaccineReminder: value));
    });
  }

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyEncouragementSettingsCopyWith<$Res> get dailyEncouragement {
    return $DailyEncouragementSettingsCopyWith<$Res>(_self.dailyEncouragement,
        (value) {
      return _then(_self.copyWith(dailyEncouragement: value));
    });
  }
}

/// @nodoc
mixin _$VaccineReminderSettings {
  bool get enabled;
  List<int> get daysBefore;

  /// Create a copy of VaccineReminderSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineReminderSettingsCopyWith<VaccineReminderSettings> get copyWith =>
      _$VaccineReminderSettingsCopyWithImpl<VaccineReminderSettings>(
          this as VaccineReminderSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineReminderSettings &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other.daysBefore, daysBefore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, const DeepCollectionEquality().hash(daysBefore));

  @override
  String toString() {
    return 'VaccineReminderSettings(enabled: $enabled, daysBefore: $daysBefore)';
  }
}

/// @nodoc
abstract mixin class $VaccineReminderSettingsCopyWith<$Res> {
  factory $VaccineReminderSettingsCopyWith(VaccineReminderSettings value,
          $Res Function(VaccineReminderSettings) _then) =
      _$VaccineReminderSettingsCopyWithImpl;
  @useResult
  $Res call({bool enabled, List<int> daysBefore});
}

/// @nodoc
class _$VaccineReminderSettingsCopyWithImpl<$Res>
    implements $VaccineReminderSettingsCopyWith<$Res> {
  _$VaccineReminderSettingsCopyWithImpl(this._self, this._then);

  final VaccineReminderSettings _self;
  final $Res Function(VaccineReminderSettings) _then;

  /// Create a copy of VaccineReminderSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? daysBefore = null,
  }) {
    return _then(_self.copyWith(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      daysBefore: null == daysBefore
          ? _self.daysBefore
          : daysBefore // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineReminderSettings].
extension VaccineReminderSettingsPatterns on VaccineReminderSettings {
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
    TResult Function(_VaccineReminderSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettings() when $default != null:
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
    TResult Function(_VaccineReminderSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettings():
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
    TResult? Function(_VaccineReminderSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettings() when $default != null:
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
    TResult Function(bool enabled, List<int> daysBefore)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettings() when $default != null:
        return $default(_that.enabled, _that.daysBefore);
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
    TResult Function(bool enabled, List<int> daysBefore) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettings():
        return $default(_that.enabled, _that.daysBefore);
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
    TResult? Function(bool enabled, List<int> daysBefore)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettings() when $default != null:
        return $default(_that.enabled, _that.daysBefore);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineReminderSettings implements VaccineReminderSettings {
  const _VaccineReminderSettings(
      {required this.enabled, required final List<int> daysBefore})
      : _daysBefore = daysBefore;

  @override
  final bool enabled;
  final List<int> _daysBefore;
  @override
  List<int> get daysBefore {
    if (_daysBefore is EqualUnmodifiableListView) return _daysBefore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysBefore);
  }

  /// Create a copy of VaccineReminderSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineReminderSettingsCopyWith<_VaccineReminderSettings> get copyWith =>
      __$VaccineReminderSettingsCopyWithImpl<_VaccineReminderSettings>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineReminderSettings &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other._daysBefore, _daysBefore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, const DeepCollectionEquality().hash(_daysBefore));

  @override
  String toString() {
    return 'VaccineReminderSettings(enabled: $enabled, daysBefore: $daysBefore)';
  }
}

/// @nodoc
abstract mixin class _$VaccineReminderSettingsCopyWith<$Res>
    implements $VaccineReminderSettingsCopyWith<$Res> {
  factory _$VaccineReminderSettingsCopyWith(_VaccineReminderSettings value,
          $Res Function(_VaccineReminderSettings) _then) =
      __$VaccineReminderSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({bool enabled, List<int> daysBefore});
}

/// @nodoc
class __$VaccineReminderSettingsCopyWithImpl<$Res>
    implements _$VaccineReminderSettingsCopyWith<$Res> {
  __$VaccineReminderSettingsCopyWithImpl(this._self, this._then);

  final _VaccineReminderSettings _self;
  final $Res Function(_VaccineReminderSettings) _then;

  /// Create a copy of VaccineReminderSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
    Object? daysBefore = null,
  }) {
    return _then(_VaccineReminderSettings(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      daysBefore: null == daysBefore
          ? _self._daysBefore
          : daysBefore // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$DailyEncouragementSettings {
  bool get enabled;

  /// Create a copy of DailyEncouragementSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DailyEncouragementSettingsCopyWith<DailyEncouragementSettings>
      get copyWith =>
          _$DailyEncouragementSettingsCopyWithImpl<DailyEncouragementSettings>(
              this as DailyEncouragementSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DailyEncouragementSettings &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @override
  String toString() {
    return 'DailyEncouragementSettings(enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class $DailyEncouragementSettingsCopyWith<$Res> {
  factory $DailyEncouragementSettingsCopyWith(DailyEncouragementSettings value,
          $Res Function(DailyEncouragementSettings) _then) =
      _$DailyEncouragementSettingsCopyWithImpl;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class _$DailyEncouragementSettingsCopyWithImpl<$Res>
    implements $DailyEncouragementSettingsCopyWith<$Res> {
  _$DailyEncouragementSettingsCopyWithImpl(this._self, this._then);

  final DailyEncouragementSettings _self;
  final $Res Function(DailyEncouragementSettings) _then;

  /// Create a copy of DailyEncouragementSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_self.copyWith(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [DailyEncouragementSettings].
extension DailyEncouragementSettingsPatterns on DailyEncouragementSettings {
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
    TResult Function(_DailyEncouragementSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettings() when $default != null:
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
    TResult Function(_DailyEncouragementSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettings():
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
    TResult? Function(_DailyEncouragementSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettings() when $default != null:
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
    TResult Function(bool enabled)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettings() when $default != null:
        return $default(_that.enabled);
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
    TResult Function(bool enabled) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettings():
        return $default(_that.enabled);
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
    TResult? Function(bool enabled)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettings() when $default != null:
        return $default(_that.enabled);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DailyEncouragementSettings implements DailyEncouragementSettings {
  const _DailyEncouragementSettings({required this.enabled});

  @override
  final bool enabled;

  /// Create a copy of DailyEncouragementSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DailyEncouragementSettingsCopyWith<_DailyEncouragementSettings>
      get copyWith => __$DailyEncouragementSettingsCopyWithImpl<
          _DailyEncouragementSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DailyEncouragementSettings &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @override
  String toString() {
    return 'DailyEncouragementSettings(enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class _$DailyEncouragementSettingsCopyWith<$Res>
    implements $DailyEncouragementSettingsCopyWith<$Res> {
  factory _$DailyEncouragementSettingsCopyWith(
          _DailyEncouragementSettings value,
          $Res Function(_DailyEncouragementSettings) _then) =
      __$DailyEncouragementSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$DailyEncouragementSettingsCopyWithImpl<$Res>
    implements _$DailyEncouragementSettingsCopyWith<$Res> {
  __$DailyEncouragementSettingsCopyWithImpl(this._self, this._then);

  final _DailyEncouragementSettings _self;
  final $Res Function(_DailyEncouragementSettings) _then;

  /// Create a copy of DailyEncouragementSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_DailyEncouragementSettings(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
