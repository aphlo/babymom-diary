// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccination_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoseEntryDto {
  String get doseId;
  DoseStatus get status;
  DateTime? get scheduledDate;
  String? get reservationGroupId;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of DoseEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DoseEntryDtoCopyWith<DoseEntryDto> get copyWith =>
      _$DoseEntryDtoCopyWithImpl<DoseEntryDto>(
          this as DoseEntryDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DoseEntryDto &&
            (identical(other.doseId, doseId) || other.doseId == doseId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doseId, status, scheduledDate,
      reservationGroupId, createdAt, updatedAt);

  @override
  String toString() {
    return 'DoseEntryDto(doseId: $doseId, status: $status, scheduledDate: $scheduledDate, reservationGroupId: $reservationGroupId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $DoseEntryDtoCopyWith<$Res> {
  factory $DoseEntryDtoCopyWith(
          DoseEntryDto value, $Res Function(DoseEntryDto) _then) =
      _$DoseEntryDtoCopyWithImpl;
  @useResult
  $Res call(
      {String doseId,
      DoseStatus status,
      DateTime? scheduledDate,
      String? reservationGroupId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DoseEntryDtoCopyWithImpl<$Res> implements $DoseEntryDtoCopyWith<$Res> {
  _$DoseEntryDtoCopyWithImpl(this._self, this._then);

  final DoseEntryDto _self;
  final $Res Function(DoseEntryDto) _then;

  /// Create a copy of DoseEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doseId = null,
    Object? status = null,
    Object? scheduledDate = freezed,
    Object? reservationGroupId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      doseId: null == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DoseStatus,
      scheduledDate: freezed == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reservationGroupId: freezed == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
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

/// Adds pattern-matching-related methods to [DoseEntryDto].
extension DoseEntryDtoPatterns on DoseEntryDto {
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
    TResult Function(_DoseEntryDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoseEntryDto() when $default != null:
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
    TResult Function(_DoseEntryDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseEntryDto():
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
    TResult? Function(_DoseEntryDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseEntryDto() when $default != null:
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
    TResult Function(String doseId, DoseStatus status, DateTime? scheduledDate,
            String? reservationGroupId, DateTime createdAt, DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoseEntryDto() when $default != null:
        return $default(_that.doseId, _that.status, _that.scheduledDate,
            _that.reservationGroupId, _that.createdAt, _that.updatedAt);
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
    TResult Function(String doseId, DoseStatus status, DateTime? scheduledDate,
            String? reservationGroupId, DateTime createdAt, DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseEntryDto():
        return $default(_that.doseId, _that.status, _that.scheduledDate,
            _that.reservationGroupId, _that.createdAt, _that.updatedAt);
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
    TResult? Function(String doseId, DoseStatus status, DateTime? scheduledDate,
            String? reservationGroupId, DateTime createdAt, DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseEntryDto() when $default != null:
        return $default(_that.doseId, _that.status, _that.scheduledDate,
            _that.reservationGroupId, _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DoseEntryDto extends DoseEntryDto {
  const _DoseEntryDto(
      {required this.doseId,
      required this.status,
      this.scheduledDate,
      this.reservationGroupId,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  @override
  final String doseId;
  @override
  final DoseStatus status;
  @override
  final DateTime? scheduledDate;
  @override
  final String? reservationGroupId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of DoseEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DoseEntryDtoCopyWith<_DoseEntryDto> get copyWith =>
      __$DoseEntryDtoCopyWithImpl<_DoseEntryDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DoseEntryDto &&
            (identical(other.doseId, doseId) || other.doseId == doseId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doseId, status, scheduledDate,
      reservationGroupId, createdAt, updatedAt);

  @override
  String toString() {
    return 'DoseEntryDto(doseId: $doseId, status: $status, scheduledDate: $scheduledDate, reservationGroupId: $reservationGroupId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$DoseEntryDtoCopyWith<$Res>
    implements $DoseEntryDtoCopyWith<$Res> {
  factory _$DoseEntryDtoCopyWith(
          _DoseEntryDto value, $Res Function(_DoseEntryDto) _then) =
      __$DoseEntryDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String doseId,
      DoseStatus status,
      DateTime? scheduledDate,
      String? reservationGroupId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$DoseEntryDtoCopyWithImpl<$Res>
    implements _$DoseEntryDtoCopyWith<$Res> {
  __$DoseEntryDtoCopyWithImpl(this._self, this._then);

  final _DoseEntryDto _self;
  final $Res Function(_DoseEntryDto) _then;

  /// Create a copy of DoseEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? doseId = null,
    Object? status = null,
    Object? scheduledDate = freezed,
    Object? reservationGroupId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_DoseEntryDto(
      doseId: null == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DoseStatus,
      scheduledDate: freezed == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reservationGroupId: freezed == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
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
