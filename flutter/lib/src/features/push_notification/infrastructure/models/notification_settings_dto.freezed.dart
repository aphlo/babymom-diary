// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsDto {
  String get uid;
  VaccineReminderSettingsDto get vaccineReminder;
  DailyEncouragementSettingsDto get dailyEncouragement;
  @TimestampConverter()
  DateTime get createdAt;
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationSettingsDtoCopyWith<NotificationSettingsDto> get copyWith =>
      _$NotificationSettingsDtoCopyWithImpl<NotificationSettingsDto>(
          this as NotificationSettingsDto, _$identity);

  /// Serializes this NotificationSettingsDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationSettingsDto &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.vaccineReminder, vaccineReminder) ||
                other.vaccineReminder == vaccineReminder) &&
            (identical(other.dailyEncouragement, dailyEncouragement) ||
                other.dailyEncouragement == dailyEncouragement) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, vaccineReminder,
      dailyEncouragement, createdAt, updatedAt);

  @override
  String toString() {
    return 'NotificationSettingsDto(uid: $uid, vaccineReminder: $vaccineReminder, dailyEncouragement: $dailyEncouragement, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $NotificationSettingsDtoCopyWith<$Res> {
  factory $NotificationSettingsDtoCopyWith(NotificationSettingsDto value,
          $Res Function(NotificationSettingsDto) _then) =
      _$NotificationSettingsDtoCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      VaccineReminderSettingsDto vaccineReminder,
      DailyEncouragementSettingsDto dailyEncouragement,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});

  $VaccineReminderSettingsDtoCopyWith<$Res> get vaccineReminder;
  $DailyEncouragementSettingsDtoCopyWith<$Res> get dailyEncouragement;
}

/// @nodoc
class _$NotificationSettingsDtoCopyWithImpl<$Res>
    implements $NotificationSettingsDtoCopyWith<$Res> {
  _$NotificationSettingsDtoCopyWithImpl(this._self, this._then);

  final NotificationSettingsDto _self;
  final $Res Function(NotificationSettingsDto) _then;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? vaccineReminder = null,
    Object? dailyEncouragement = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineReminder: null == vaccineReminder
          ? _self.vaccineReminder
          : vaccineReminder // ignore: cast_nullable_to_non_nullable
              as VaccineReminderSettingsDto,
      dailyEncouragement: null == dailyEncouragement
          ? _self.dailyEncouragement
          : dailyEncouragement // ignore: cast_nullable_to_non_nullable
              as DailyEncouragementSettingsDto,
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

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VaccineReminderSettingsDtoCopyWith<$Res> get vaccineReminder {
    return $VaccineReminderSettingsDtoCopyWith<$Res>(_self.vaccineReminder,
        (value) {
      return _then(_self.copyWith(vaccineReminder: value));
    });
  }

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyEncouragementSettingsDtoCopyWith<$Res> get dailyEncouragement {
    return $DailyEncouragementSettingsDtoCopyWith<$Res>(
        _self.dailyEncouragement, (value) {
      return _then(_self.copyWith(dailyEncouragement: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NotificationSettingsDto].
extension NotificationSettingsDtoPatterns on NotificationSettingsDto {
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
    TResult Function(_NotificationSettingsDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsDto() when $default != null:
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
    TResult Function(_NotificationSettingsDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsDto():
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
    TResult? Function(_NotificationSettingsDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsDto() when $default != null:
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
            String uid,
            VaccineReminderSettingsDto vaccineReminder,
            DailyEncouragementSettingsDto dailyEncouragement,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsDto() when $default != null:
        return $default(_that.uid, _that.vaccineReminder,
            _that.dailyEncouragement, _that.createdAt, _that.updatedAt);
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
            String uid,
            VaccineReminderSettingsDto vaccineReminder,
            DailyEncouragementSettingsDto dailyEncouragement,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsDto():
        return $default(_that.uid, _that.vaccineReminder,
            _that.dailyEncouragement, _that.createdAt, _that.updatedAt);
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
            String uid,
            VaccineReminderSettingsDto vaccineReminder,
            DailyEncouragementSettingsDto dailyEncouragement,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationSettingsDto() when $default != null:
        return $default(_that.uid, _that.vaccineReminder,
            _that.dailyEncouragement, _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationSettingsDto extends NotificationSettingsDto {
  const _NotificationSettingsDto(
      {required this.uid,
      required this.vaccineReminder,
      required this.dailyEncouragement,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt})
      : super._();
  factory _NotificationSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsDtoFromJson(json);

  @override
  final String uid;
  @override
  final VaccineReminderSettingsDto vaccineReminder;
  @override
  final DailyEncouragementSettingsDto dailyEncouragement;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationSettingsDtoCopyWith<_NotificationSettingsDto> get copyWith =>
      __$NotificationSettingsDtoCopyWithImpl<_NotificationSettingsDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationSettingsDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationSettingsDto &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.vaccineReminder, vaccineReminder) ||
                other.vaccineReminder == vaccineReminder) &&
            (identical(other.dailyEncouragement, dailyEncouragement) ||
                other.dailyEncouragement == dailyEncouragement) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, vaccineReminder,
      dailyEncouragement, createdAt, updatedAt);

  @override
  String toString() {
    return 'NotificationSettingsDto(uid: $uid, vaccineReminder: $vaccineReminder, dailyEncouragement: $dailyEncouragement, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$NotificationSettingsDtoCopyWith<$Res>
    implements $NotificationSettingsDtoCopyWith<$Res> {
  factory _$NotificationSettingsDtoCopyWith(_NotificationSettingsDto value,
          $Res Function(_NotificationSettingsDto) _then) =
      __$NotificationSettingsDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      VaccineReminderSettingsDto vaccineReminder,
      DailyEncouragementSettingsDto dailyEncouragement,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});

  @override
  $VaccineReminderSettingsDtoCopyWith<$Res> get vaccineReminder;
  @override
  $DailyEncouragementSettingsDtoCopyWith<$Res> get dailyEncouragement;
}

/// @nodoc
class __$NotificationSettingsDtoCopyWithImpl<$Res>
    implements _$NotificationSettingsDtoCopyWith<$Res> {
  __$NotificationSettingsDtoCopyWithImpl(this._self, this._then);

  final _NotificationSettingsDto _self;
  final $Res Function(_NotificationSettingsDto) _then;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? vaccineReminder = null,
    Object? dailyEncouragement = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_NotificationSettingsDto(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineReminder: null == vaccineReminder
          ? _self.vaccineReminder
          : vaccineReminder // ignore: cast_nullable_to_non_nullable
              as VaccineReminderSettingsDto,
      dailyEncouragement: null == dailyEncouragement
          ? _self.dailyEncouragement
          : dailyEncouragement // ignore: cast_nullable_to_non_nullable
              as DailyEncouragementSettingsDto,
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

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VaccineReminderSettingsDtoCopyWith<$Res> get vaccineReminder {
    return $VaccineReminderSettingsDtoCopyWith<$Res>(_self.vaccineReminder,
        (value) {
      return _then(_self.copyWith(vaccineReminder: value));
    });
  }

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyEncouragementSettingsDtoCopyWith<$Res> get dailyEncouragement {
    return $DailyEncouragementSettingsDtoCopyWith<$Res>(
        _self.dailyEncouragement, (value) {
      return _then(_self.copyWith(dailyEncouragement: value));
    });
  }
}

/// @nodoc
mixin _$VaccineReminderSettingsDto {
  bool get enabled;
  List<int> get daysBefore;

  /// Create a copy of VaccineReminderSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineReminderSettingsDtoCopyWith<VaccineReminderSettingsDto>
      get copyWith =>
          _$VaccineReminderSettingsDtoCopyWithImpl<VaccineReminderSettingsDto>(
              this as VaccineReminderSettingsDto, _$identity);

  /// Serializes this VaccineReminderSettingsDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineReminderSettingsDto &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other.daysBefore, daysBefore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, const DeepCollectionEquality().hash(daysBefore));

  @override
  String toString() {
    return 'VaccineReminderSettingsDto(enabled: $enabled, daysBefore: $daysBefore)';
  }
}

/// @nodoc
abstract mixin class $VaccineReminderSettingsDtoCopyWith<$Res> {
  factory $VaccineReminderSettingsDtoCopyWith(VaccineReminderSettingsDto value,
          $Res Function(VaccineReminderSettingsDto) _then) =
      _$VaccineReminderSettingsDtoCopyWithImpl;
  @useResult
  $Res call({bool enabled, List<int> daysBefore});
}

/// @nodoc
class _$VaccineReminderSettingsDtoCopyWithImpl<$Res>
    implements $VaccineReminderSettingsDtoCopyWith<$Res> {
  _$VaccineReminderSettingsDtoCopyWithImpl(this._self, this._then);

  final VaccineReminderSettingsDto _self;
  final $Res Function(VaccineReminderSettingsDto) _then;

  /// Create a copy of VaccineReminderSettingsDto
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

/// Adds pattern-matching-related methods to [VaccineReminderSettingsDto].
extension VaccineReminderSettingsDtoPatterns on VaccineReminderSettingsDto {
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
    TResult Function(_VaccineReminderSettingsDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettingsDto() when $default != null:
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
    TResult Function(_VaccineReminderSettingsDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettingsDto():
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
    TResult? Function(_VaccineReminderSettingsDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReminderSettingsDto() when $default != null:
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
      case _VaccineReminderSettingsDto() when $default != null:
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
      case _VaccineReminderSettingsDto():
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
      case _VaccineReminderSettingsDto() when $default != null:
        return $default(_that.enabled, _that.daysBefore);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VaccineReminderSettingsDto extends VaccineReminderSettingsDto {
  const _VaccineReminderSettingsDto(
      {required this.enabled, required final List<int> daysBefore})
      : _daysBefore = daysBefore,
        super._();
  factory _VaccineReminderSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$VaccineReminderSettingsDtoFromJson(json);

  @override
  final bool enabled;
  final List<int> _daysBefore;
  @override
  List<int> get daysBefore {
    if (_daysBefore is EqualUnmodifiableListView) return _daysBefore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysBefore);
  }

  /// Create a copy of VaccineReminderSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineReminderSettingsDtoCopyWith<_VaccineReminderSettingsDto>
      get copyWith => __$VaccineReminderSettingsDtoCopyWithImpl<
          _VaccineReminderSettingsDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VaccineReminderSettingsDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineReminderSettingsDto &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other._daysBefore, _daysBefore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, const DeepCollectionEquality().hash(_daysBefore));

  @override
  String toString() {
    return 'VaccineReminderSettingsDto(enabled: $enabled, daysBefore: $daysBefore)';
  }
}

/// @nodoc
abstract mixin class _$VaccineReminderSettingsDtoCopyWith<$Res>
    implements $VaccineReminderSettingsDtoCopyWith<$Res> {
  factory _$VaccineReminderSettingsDtoCopyWith(
          _VaccineReminderSettingsDto value,
          $Res Function(_VaccineReminderSettingsDto) _then) =
      __$VaccineReminderSettingsDtoCopyWithImpl;
  @override
  @useResult
  $Res call({bool enabled, List<int> daysBefore});
}

/// @nodoc
class __$VaccineReminderSettingsDtoCopyWithImpl<$Res>
    implements _$VaccineReminderSettingsDtoCopyWith<$Res> {
  __$VaccineReminderSettingsDtoCopyWithImpl(this._self, this._then);

  final _VaccineReminderSettingsDto _self;
  final $Res Function(_VaccineReminderSettingsDto) _then;

  /// Create a copy of VaccineReminderSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
    Object? daysBefore = null,
  }) {
    return _then(_VaccineReminderSettingsDto(
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
mixin _$DailyEncouragementSettingsDto {
  bool get enabled;

  /// Create a copy of DailyEncouragementSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DailyEncouragementSettingsDtoCopyWith<DailyEncouragementSettingsDto>
      get copyWith => _$DailyEncouragementSettingsDtoCopyWithImpl<
              DailyEncouragementSettingsDto>(
          this as DailyEncouragementSettingsDto, _$identity);

  /// Serializes this DailyEncouragementSettingsDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DailyEncouragementSettingsDto &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @override
  String toString() {
    return 'DailyEncouragementSettingsDto(enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class $DailyEncouragementSettingsDtoCopyWith<$Res> {
  factory $DailyEncouragementSettingsDtoCopyWith(
          DailyEncouragementSettingsDto value,
          $Res Function(DailyEncouragementSettingsDto) _then) =
      _$DailyEncouragementSettingsDtoCopyWithImpl;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class _$DailyEncouragementSettingsDtoCopyWithImpl<$Res>
    implements $DailyEncouragementSettingsDtoCopyWith<$Res> {
  _$DailyEncouragementSettingsDtoCopyWithImpl(this._self, this._then);

  final DailyEncouragementSettingsDto _self;
  final $Res Function(DailyEncouragementSettingsDto) _then;

  /// Create a copy of DailyEncouragementSettingsDto
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

/// Adds pattern-matching-related methods to [DailyEncouragementSettingsDto].
extension DailyEncouragementSettingsDtoPatterns
    on DailyEncouragementSettingsDto {
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
    TResult Function(_DailyEncouragementSettingsDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettingsDto() when $default != null:
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
    TResult Function(_DailyEncouragementSettingsDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettingsDto():
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
    TResult? Function(_DailyEncouragementSettingsDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyEncouragementSettingsDto() when $default != null:
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
      case _DailyEncouragementSettingsDto() when $default != null:
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
      case _DailyEncouragementSettingsDto():
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
      case _DailyEncouragementSettingsDto() when $default != null:
        return $default(_that.enabled);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DailyEncouragementSettingsDto extends DailyEncouragementSettingsDto {
  const _DailyEncouragementSettingsDto({required this.enabled}) : super._();
  factory _DailyEncouragementSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$DailyEncouragementSettingsDtoFromJson(json);

  @override
  final bool enabled;

  /// Create a copy of DailyEncouragementSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DailyEncouragementSettingsDtoCopyWith<_DailyEncouragementSettingsDto>
      get copyWith => __$DailyEncouragementSettingsDtoCopyWithImpl<
          _DailyEncouragementSettingsDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DailyEncouragementSettingsDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DailyEncouragementSettingsDto &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @override
  String toString() {
    return 'DailyEncouragementSettingsDto(enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class _$DailyEncouragementSettingsDtoCopyWith<$Res>
    implements $DailyEncouragementSettingsDtoCopyWith<$Res> {
  factory _$DailyEncouragementSettingsDtoCopyWith(
          _DailyEncouragementSettingsDto value,
          $Res Function(_DailyEncouragementSettingsDto) _then) =
      __$DailyEncouragementSettingsDtoCopyWithImpl;
  @override
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$DailyEncouragementSettingsDtoCopyWithImpl<$Res>
    implements _$DailyEncouragementSettingsDtoCopyWith<$Res> {
  __$DailyEncouragementSettingsDtoCopyWithImpl(this._self, this._then);

  final _DailyEncouragementSettingsDto _self;
  final $Res Function(_DailyEncouragementSettingsDto) _then;

  /// Create a copy of DailyEncouragementSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_DailyEncouragementSettingsDto(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
