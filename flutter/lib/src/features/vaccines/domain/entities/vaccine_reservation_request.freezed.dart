// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_reservation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineReservationRequest {
  String get childId;
  String get vaccineId;
  String? get doseId; // 新規作成時はnull、更新時は必須
  DateTime get scheduledDate;
  VaccineRecordType get recordType;
  String? get reservationGroupId;

  /// Create a copy of VaccineReservationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineReservationRequestCopyWith<VaccineReservationRequest> get copyWith =>
      _$VaccineReservationRequestCopyWithImpl<VaccineReservationRequest>(
          this as VaccineReservationRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineReservationRequest &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.doseId, doseId) || other.doseId == doseId) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.recordType, recordType) ||
                other.recordType == recordType) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, childId, vaccineId, doseId,
      scheduledDate, recordType, reservationGroupId);

  @override
  String toString() {
    return 'VaccineReservationRequest(childId: $childId, vaccineId: $vaccineId, doseId: $doseId, scheduledDate: $scheduledDate, recordType: $recordType, reservationGroupId: $reservationGroupId)';
  }
}

/// @nodoc
abstract mixin class $VaccineReservationRequestCopyWith<$Res> {
  factory $VaccineReservationRequestCopyWith(VaccineReservationRequest value,
          $Res Function(VaccineReservationRequest) _then) =
      _$VaccineReservationRequestCopyWithImpl;
  @useResult
  $Res call(
      {String childId,
      String vaccineId,
      String? doseId,
      DateTime scheduledDate,
      VaccineRecordType recordType,
      String? reservationGroupId});
}

/// @nodoc
class _$VaccineReservationRequestCopyWithImpl<$Res>
    implements $VaccineReservationRequestCopyWith<$Res> {
  _$VaccineReservationRequestCopyWithImpl(this._self, this._then);

  final VaccineReservationRequest _self;
  final $Res Function(VaccineReservationRequest) _then;

  /// Create a copy of VaccineReservationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? childId = null,
    Object? vaccineId = null,
    Object? doseId = freezed,
    Object? scheduledDate = null,
    Object? recordType = null,
    Object? reservationGroupId = freezed,
  }) {
    return _then(_self.copyWith(
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      doseId: freezed == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledDate: null == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recordType: null == recordType
          ? _self.recordType
          : recordType // ignore: cast_nullable_to_non_nullable
              as VaccineRecordType,
      reservationGroupId: freezed == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineReservationRequest].
extension VaccineReservationRequestPatterns on VaccineReservationRequest {
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
    TResult Function(_VaccineReservationRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationRequest() when $default != null:
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
    TResult Function(_VaccineReservationRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationRequest():
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
    TResult? Function(_VaccineReservationRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationRequest() when $default != null:
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
            String childId,
            String vaccineId,
            String? doseId,
            DateTime scheduledDate,
            VaccineRecordType recordType,
            String? reservationGroupId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationRequest() when $default != null:
        return $default(_that.childId, _that.vaccineId, _that.doseId,
            _that.scheduledDate, _that.recordType, _that.reservationGroupId);
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
            String childId,
            String vaccineId,
            String? doseId,
            DateTime scheduledDate,
            VaccineRecordType recordType,
            String? reservationGroupId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationRequest():
        return $default(_that.childId, _that.vaccineId, _that.doseId,
            _that.scheduledDate, _that.recordType, _that.reservationGroupId);
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
            String childId,
            String vaccineId,
            String? doseId,
            DateTime scheduledDate,
            VaccineRecordType recordType,
            String? reservationGroupId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationRequest() when $default != null:
        return $default(_that.childId, _that.vaccineId, _that.doseId,
            _that.scheduledDate, _that.recordType, _that.reservationGroupId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineReservationRequest extends VaccineReservationRequest {
  const _VaccineReservationRequest(
      {required this.childId,
      required this.vaccineId,
      this.doseId,
      required this.scheduledDate,
      required this.recordType,
      this.reservationGroupId})
      : super._();

  @override
  final String childId;
  @override
  final String vaccineId;
  @override
  final String? doseId;
// 新規作成時はnull、更新時は必須
  @override
  final DateTime scheduledDate;
  @override
  final VaccineRecordType recordType;
  @override
  final String? reservationGroupId;

  /// Create a copy of VaccineReservationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineReservationRequestCopyWith<_VaccineReservationRequest>
      get copyWith =>
          __$VaccineReservationRequestCopyWithImpl<_VaccineReservationRequest>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineReservationRequest &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.doseId, doseId) || other.doseId == doseId) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.recordType, recordType) ||
                other.recordType == recordType) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, childId, vaccineId, doseId,
      scheduledDate, recordType, reservationGroupId);

  @override
  String toString() {
    return 'VaccineReservationRequest(childId: $childId, vaccineId: $vaccineId, doseId: $doseId, scheduledDate: $scheduledDate, recordType: $recordType, reservationGroupId: $reservationGroupId)';
  }
}

/// @nodoc
abstract mixin class _$VaccineReservationRequestCopyWith<$Res>
    implements $VaccineReservationRequestCopyWith<$Res> {
  factory _$VaccineReservationRequestCopyWith(_VaccineReservationRequest value,
          $Res Function(_VaccineReservationRequest) _then) =
      __$VaccineReservationRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String childId,
      String vaccineId,
      String? doseId,
      DateTime scheduledDate,
      VaccineRecordType recordType,
      String? reservationGroupId});
}

/// @nodoc
class __$VaccineReservationRequestCopyWithImpl<$Res>
    implements _$VaccineReservationRequestCopyWith<$Res> {
  __$VaccineReservationRequestCopyWithImpl(this._self, this._then);

  final _VaccineReservationRequest _self;
  final $Res Function(_VaccineReservationRequest) _then;

  /// Create a copy of VaccineReservationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? childId = null,
    Object? vaccineId = null,
    Object? doseId = freezed,
    Object? scheduledDate = null,
    Object? recordType = null,
    Object? reservationGroupId = freezed,
  }) {
    return _then(_VaccineReservationRequest(
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      doseId: freezed == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledDate: null == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recordType: null == recordType
          ? _self.recordType
          : recordType // ignore: cast_nullable_to_non_nullable
              as VaccineRecordType,
      reservationGroupId: freezed == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
