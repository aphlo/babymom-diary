// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoseStatusInfo {
  int get doseNumber;
  DoseStatus? get status;
  DateTime? get scheduledDate;
  String? get reservationGroupId;

  /// Create a copy of DoseStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DoseStatusInfoCopyWith<DoseStatusInfo> get copyWith =>
      _$DoseStatusInfoCopyWithImpl<DoseStatusInfo>(
          this as DoseStatusInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DoseStatusInfo &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, doseNumber, status, scheduledDate, reservationGroupId);

  @override
  String toString() {
    return 'DoseStatusInfo(doseNumber: $doseNumber, status: $status, scheduledDate: $scheduledDate, reservationGroupId: $reservationGroupId)';
  }
}

/// @nodoc
abstract mixin class $DoseStatusInfoCopyWith<$Res> {
  factory $DoseStatusInfoCopyWith(
          DoseStatusInfo value, $Res Function(DoseStatusInfo) _then) =
      _$DoseStatusInfoCopyWithImpl;
  @useResult
  $Res call(
      {int doseNumber,
      DoseStatus? status,
      DateTime? scheduledDate,
      String? reservationGroupId});
}

/// @nodoc
class _$DoseStatusInfoCopyWithImpl<$Res>
    implements $DoseStatusInfoCopyWith<$Res> {
  _$DoseStatusInfoCopyWithImpl(this._self, this._then);

  final DoseStatusInfo _self;
  final $Res Function(DoseStatusInfo) _then;

  /// Create a copy of DoseStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doseNumber = null,
    Object? status = freezed,
    Object? scheduledDate = freezed,
    Object? reservationGroupId = freezed,
  }) {
    return _then(_self.copyWith(
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DoseStatus?,
      scheduledDate: freezed == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reservationGroupId: freezed == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DoseStatusInfo].
extension DoseStatusInfoPatterns on DoseStatusInfo {
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
    TResult Function(_DoseStatusInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoseStatusInfo() when $default != null:
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
    TResult Function(_DoseStatusInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseStatusInfo():
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
    TResult? Function(_DoseStatusInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseStatusInfo() when $default != null:
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
    TResult Function(int doseNumber, DoseStatus? status,
            DateTime? scheduledDate, String? reservationGroupId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoseStatusInfo() when $default != null:
        return $default(_that.doseNumber, _that.status, _that.scheduledDate,
            _that.reservationGroupId);
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
    TResult Function(int doseNumber, DoseStatus? status,
            DateTime? scheduledDate, String? reservationGroupId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseStatusInfo():
        return $default(_that.doseNumber, _that.status, _that.scheduledDate,
            _that.reservationGroupId);
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
    TResult? Function(int doseNumber, DoseStatus? status,
            DateTime? scheduledDate, String? reservationGroupId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseStatusInfo() when $default != null:
        return $default(_that.doseNumber, _that.status, _that.scheduledDate,
            _that.reservationGroupId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DoseStatusInfo implements DoseStatusInfo {
  const _DoseStatusInfo(
      {required this.doseNumber,
      this.status,
      this.scheduledDate,
      this.reservationGroupId});

  @override
  final int doseNumber;
  @override
  final DoseStatus? status;
  @override
  final DateTime? scheduledDate;
  @override
  final String? reservationGroupId;

  /// Create a copy of DoseStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DoseStatusInfoCopyWith<_DoseStatusInfo> get copyWith =>
      __$DoseStatusInfoCopyWithImpl<_DoseStatusInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DoseStatusInfo &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, doseNumber, status, scheduledDate, reservationGroupId);

  @override
  String toString() {
    return 'DoseStatusInfo(doseNumber: $doseNumber, status: $status, scheduledDate: $scheduledDate, reservationGroupId: $reservationGroupId)';
  }
}

/// @nodoc
abstract mixin class _$DoseStatusInfoCopyWith<$Res>
    implements $DoseStatusInfoCopyWith<$Res> {
  factory _$DoseStatusInfoCopyWith(
          _DoseStatusInfo value, $Res Function(_DoseStatusInfo) _then) =
      __$DoseStatusInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int doseNumber,
      DoseStatus? status,
      DateTime? scheduledDate,
      String? reservationGroupId});
}

/// @nodoc
class __$DoseStatusInfoCopyWithImpl<$Res>
    implements _$DoseStatusInfoCopyWith<$Res> {
  __$DoseStatusInfoCopyWithImpl(this._self, this._then);

  final _DoseStatusInfo _self;
  final $Res Function(_DoseStatusInfo) _then;

  /// Create a copy of DoseStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? doseNumber = null,
    Object? status = freezed,
    Object? scheduledDate = freezed,
    Object? reservationGroupId = freezed,
  }) {
    return _then(_DoseStatusInfo(
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DoseStatus?,
      scheduledDate: freezed == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reservationGroupId: freezed == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$DoseRecommendationInfo {
  int get doseNumber;
  String get message;
  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of DoseRecommendationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DoseRecommendationInfoCopyWith<DoseRecommendationInfo> get copyWith =>
      _$DoseRecommendationInfoCopyWithImpl<DoseRecommendationInfo>(
          this as DoseRecommendationInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DoseRecommendationInfo &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, doseNumber, message, startDate, endDate);

  @override
  String toString() {
    return 'DoseRecommendationInfo(doseNumber: $doseNumber, message: $message, startDate: $startDate, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class $DoseRecommendationInfoCopyWith<$Res> {
  factory $DoseRecommendationInfoCopyWith(DoseRecommendationInfo value,
          $Res Function(DoseRecommendationInfo) _then) =
      _$DoseRecommendationInfoCopyWithImpl;
  @useResult
  $Res call(
      {int doseNumber, String message, DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class _$DoseRecommendationInfoCopyWithImpl<$Res>
    implements $DoseRecommendationInfoCopyWith<$Res> {
  _$DoseRecommendationInfoCopyWithImpl(this._self, this._then);

  final DoseRecommendationInfo _self;
  final $Res Function(DoseRecommendationInfo) _then;

  /// Create a copy of DoseRecommendationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doseNumber = null,
    Object? message = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_self.copyWith(
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DoseRecommendationInfo].
extension DoseRecommendationInfoPatterns on DoseRecommendationInfo {
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
    TResult Function(_DoseRecommendationInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoseRecommendationInfo() when $default != null:
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
    TResult Function(_DoseRecommendationInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseRecommendationInfo():
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
    TResult? Function(_DoseRecommendationInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseRecommendationInfo() when $default != null:
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
    TResult Function(int doseNumber, String message, DateTime? startDate,
            DateTime? endDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoseRecommendationInfo() when $default != null:
        return $default(
            _that.doseNumber, _that.message, _that.startDate, _that.endDate);
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
    TResult Function(int doseNumber, String message, DateTime? startDate,
            DateTime? endDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseRecommendationInfo():
        return $default(
            _that.doseNumber, _that.message, _that.startDate, _that.endDate);
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
    TResult? Function(int doseNumber, String message, DateTime? startDate,
            DateTime? endDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoseRecommendationInfo() when $default != null:
        return $default(
            _that.doseNumber, _that.message, _that.startDate, _that.endDate);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DoseRecommendationInfo implements DoseRecommendationInfo {
  const _DoseRecommendationInfo(
      {required this.doseNumber,
      required this.message,
      this.startDate,
      this.endDate});

  @override
  final int doseNumber;
  @override
  final String message;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  /// Create a copy of DoseRecommendationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DoseRecommendationInfoCopyWith<_DoseRecommendationInfo> get copyWith =>
      __$DoseRecommendationInfoCopyWithImpl<_DoseRecommendationInfo>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DoseRecommendationInfo &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, doseNumber, message, startDate, endDate);

  @override
  String toString() {
    return 'DoseRecommendationInfo(doseNumber: $doseNumber, message: $message, startDate: $startDate, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class _$DoseRecommendationInfoCopyWith<$Res>
    implements $DoseRecommendationInfoCopyWith<$Res> {
  factory _$DoseRecommendationInfoCopyWith(_DoseRecommendationInfo value,
          $Res Function(_DoseRecommendationInfo) _then) =
      __$DoseRecommendationInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int doseNumber, String message, DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$DoseRecommendationInfoCopyWithImpl<$Res>
    implements _$DoseRecommendationInfoCopyWith<$Res> {
  __$DoseRecommendationInfoCopyWithImpl(this._self, this._then);

  final _DoseRecommendationInfo _self;
  final $Res Function(_DoseRecommendationInfo) _then;

  /// Create a copy of DoseRecommendationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? doseNumber = null,
    Object? message = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_DoseRecommendationInfo(
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$VaccineDetailState {
  bool get isLoading;
  String? get error;
  Map<int, DoseStatusInfo> get doseStatuses;
  List<int> get doseNumbers;
  int? get activeDoseNumber;
  int? get pendingDoseNumber;
  DoseRecommendationInfo? get recommendation;

  /// Create a copy of VaccineDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineDetailStateCopyWith<VaccineDetailState> get copyWith =>
      _$VaccineDetailStateCopyWithImpl<VaccineDetailState>(
          this as VaccineDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineDetailState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other.doseStatuses, doseStatuses) &&
            const DeepCollectionEquality()
                .equals(other.doseNumbers, doseNumbers) &&
            (identical(other.activeDoseNumber, activeDoseNumber) ||
                other.activeDoseNumber == activeDoseNumber) &&
            (identical(other.pendingDoseNumber, pendingDoseNumber) ||
                other.pendingDoseNumber == pendingDoseNumber) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      const DeepCollectionEquality().hash(doseStatuses),
      const DeepCollectionEquality().hash(doseNumbers),
      activeDoseNumber,
      pendingDoseNumber,
      recommendation);

  @override
  String toString() {
    return 'VaccineDetailState(isLoading: $isLoading, error: $error, doseStatuses: $doseStatuses, doseNumbers: $doseNumbers, activeDoseNumber: $activeDoseNumber, pendingDoseNumber: $pendingDoseNumber, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class $VaccineDetailStateCopyWith<$Res> {
  factory $VaccineDetailStateCopyWith(
          VaccineDetailState value, $Res Function(VaccineDetailState) _then) =
      _$VaccineDetailStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      String? error,
      Map<int, DoseStatusInfo> doseStatuses,
      List<int> doseNumbers,
      int? activeDoseNumber,
      int? pendingDoseNumber,
      DoseRecommendationInfo? recommendation});

  $DoseRecommendationInfoCopyWith<$Res>? get recommendation;
}

/// @nodoc
class _$VaccineDetailStateCopyWithImpl<$Res>
    implements $VaccineDetailStateCopyWith<$Res> {
  _$VaccineDetailStateCopyWithImpl(this._self, this._then);

  final VaccineDetailState _self;
  final $Res Function(VaccineDetailState) _then;

  /// Create a copy of VaccineDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? doseStatuses = null,
    Object? doseNumbers = null,
    Object? activeDoseNumber = freezed,
    Object? pendingDoseNumber = freezed,
    Object? recommendation = freezed,
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
      doseStatuses: null == doseStatuses
          ? _self.doseStatuses
          : doseStatuses // ignore: cast_nullable_to_non_nullable
              as Map<int, DoseStatusInfo>,
      doseNumbers: null == doseNumbers
          ? _self.doseNumbers
          : doseNumbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      activeDoseNumber: freezed == activeDoseNumber
          ? _self.activeDoseNumber
          : activeDoseNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingDoseNumber: freezed == pendingDoseNumber
          ? _self.pendingDoseNumber
          : pendingDoseNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as DoseRecommendationInfo?,
    ));
  }

  /// Create a copy of VaccineDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoseRecommendationInfoCopyWith<$Res>? get recommendation {
    if (_self.recommendation == null) {
      return null;
    }

    return $DoseRecommendationInfoCopyWith<$Res>(_self.recommendation!,
        (value) {
      return _then(_self.copyWith(recommendation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [VaccineDetailState].
extension VaccineDetailStatePatterns on VaccineDetailState {
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
    TResult Function(_VaccineDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailState() when $default != null:
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
    TResult Function(_VaccineDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailState():
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
    TResult? Function(_VaccineDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailState() when $default != null:
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
            bool isLoading,
            String? error,
            Map<int, DoseStatusInfo> doseStatuses,
            List<int> doseNumbers,
            int? activeDoseNumber,
            int? pendingDoseNumber,
            DoseRecommendationInfo? recommendation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailState() when $default != null:
        return $default(
            _that.isLoading,
            _that.error,
            _that.doseStatuses,
            _that.doseNumbers,
            _that.activeDoseNumber,
            _that.pendingDoseNumber,
            _that.recommendation);
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
            bool isLoading,
            String? error,
            Map<int, DoseStatusInfo> doseStatuses,
            List<int> doseNumbers,
            int? activeDoseNumber,
            int? pendingDoseNumber,
            DoseRecommendationInfo? recommendation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailState():
        return $default(
            _that.isLoading,
            _that.error,
            _that.doseStatuses,
            _that.doseNumbers,
            _that.activeDoseNumber,
            _that.pendingDoseNumber,
            _that.recommendation);
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
            bool isLoading,
            String? error,
            Map<int, DoseStatusInfo> doseStatuses,
            List<int> doseNumbers,
            int? activeDoseNumber,
            int? pendingDoseNumber,
            DoseRecommendationInfo? recommendation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailState() when $default != null:
        return $default(
            _that.isLoading,
            _that.error,
            _that.doseStatuses,
            _that.doseNumbers,
            _that.activeDoseNumber,
            _that.pendingDoseNumber,
            _that.recommendation);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineDetailState implements VaccineDetailState {
  const _VaccineDetailState(
      {this.isLoading = false,
      this.error,
      final Map<int, DoseStatusInfo> doseStatuses =
          const <int, DoseStatusInfo>{},
      final List<int> doseNumbers = const <int>[],
      this.activeDoseNumber,
      this.pendingDoseNumber,
      this.recommendation})
      : _doseStatuses = doseStatuses,
        _doseNumbers = doseNumbers;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  final Map<int, DoseStatusInfo> _doseStatuses;
  @override
  @JsonKey()
  Map<int, DoseStatusInfo> get doseStatuses {
    if (_doseStatuses is EqualUnmodifiableMapView) return _doseStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_doseStatuses);
  }

  final List<int> _doseNumbers;
  @override
  @JsonKey()
  List<int> get doseNumbers {
    if (_doseNumbers is EqualUnmodifiableListView) return _doseNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doseNumbers);
  }

  @override
  final int? activeDoseNumber;
  @override
  final int? pendingDoseNumber;
  @override
  final DoseRecommendationInfo? recommendation;

  /// Create a copy of VaccineDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineDetailStateCopyWith<_VaccineDetailState> get copyWith =>
      __$VaccineDetailStateCopyWithImpl<_VaccineDetailState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineDetailState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._doseStatuses, _doseStatuses) &&
            const DeepCollectionEquality()
                .equals(other._doseNumbers, _doseNumbers) &&
            (identical(other.activeDoseNumber, activeDoseNumber) ||
                other.activeDoseNumber == activeDoseNumber) &&
            (identical(other.pendingDoseNumber, pendingDoseNumber) ||
                other.pendingDoseNumber == pendingDoseNumber) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      const DeepCollectionEquality().hash(_doseStatuses),
      const DeepCollectionEquality().hash(_doseNumbers),
      activeDoseNumber,
      pendingDoseNumber,
      recommendation);

  @override
  String toString() {
    return 'VaccineDetailState(isLoading: $isLoading, error: $error, doseStatuses: $doseStatuses, doseNumbers: $doseNumbers, activeDoseNumber: $activeDoseNumber, pendingDoseNumber: $pendingDoseNumber, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class _$VaccineDetailStateCopyWith<$Res>
    implements $VaccineDetailStateCopyWith<$Res> {
  factory _$VaccineDetailStateCopyWith(
          _VaccineDetailState value, $Res Function(_VaccineDetailState) _then) =
      __$VaccineDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? error,
      Map<int, DoseStatusInfo> doseStatuses,
      List<int> doseNumbers,
      int? activeDoseNumber,
      int? pendingDoseNumber,
      DoseRecommendationInfo? recommendation});

  @override
  $DoseRecommendationInfoCopyWith<$Res>? get recommendation;
}

/// @nodoc
class __$VaccineDetailStateCopyWithImpl<$Res>
    implements _$VaccineDetailStateCopyWith<$Res> {
  __$VaccineDetailStateCopyWithImpl(this._self, this._then);

  final _VaccineDetailState _self;
  final $Res Function(_VaccineDetailState) _then;

  /// Create a copy of VaccineDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? doseStatuses = null,
    Object? doseNumbers = null,
    Object? activeDoseNumber = freezed,
    Object? pendingDoseNumber = freezed,
    Object? recommendation = freezed,
  }) {
    return _then(_VaccineDetailState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      doseStatuses: null == doseStatuses
          ? _self._doseStatuses
          : doseStatuses // ignore: cast_nullable_to_non_nullable
              as Map<int, DoseStatusInfo>,
      doseNumbers: null == doseNumbers
          ? _self._doseNumbers
          : doseNumbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      activeDoseNumber: freezed == activeDoseNumber
          ? _self.activeDoseNumber
          : activeDoseNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingDoseNumber: freezed == pendingDoseNumber
          ? _self.pendingDoseNumber
          : pendingDoseNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as DoseRecommendationInfo?,
    ));
  }

  /// Create a copy of VaccineDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoseRecommendationInfoCopyWith<$Res>? get recommendation {
    if (_self.recommendation == null) {
      return null;
    }

    return $DoseRecommendationInfoCopyWith<$Res>(_self.recommendation!,
        (value) {
      return _then(_self.copyWith(recommendation: value));
    });
  }
}

/// @nodoc
mixin _$VaccineDetailParams {
  String get vaccineId;
  List<int> get doseNumbers;
  String get householdId;
  String get childId;
  DateTime? get childBirthday;

  /// Create a copy of VaccineDetailParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineDetailParamsCopyWith<VaccineDetailParams> get copyWith =>
      _$VaccineDetailParamsCopyWithImpl<VaccineDetailParams>(
          this as VaccineDetailParams, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineDetailParams &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            const DeepCollectionEquality()
                .equals(other.doseNumbers, doseNumbers) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.childBirthday, childBirthday) ||
                other.childBirthday == childBirthday));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      vaccineId,
      const DeepCollectionEquality().hash(doseNumbers),
      householdId,
      childId,
      childBirthday);

  @override
  String toString() {
    return 'VaccineDetailParams(vaccineId: $vaccineId, doseNumbers: $doseNumbers, householdId: $householdId, childId: $childId, childBirthday: $childBirthday)';
  }
}

/// @nodoc
abstract mixin class $VaccineDetailParamsCopyWith<$Res> {
  factory $VaccineDetailParamsCopyWith(
          VaccineDetailParams value, $Res Function(VaccineDetailParams) _then) =
      _$VaccineDetailParamsCopyWithImpl;
  @useResult
  $Res call(
      {String vaccineId,
      List<int> doseNumbers,
      String householdId,
      String childId,
      DateTime? childBirthday});
}

/// @nodoc
class _$VaccineDetailParamsCopyWithImpl<$Res>
    implements $VaccineDetailParamsCopyWith<$Res> {
  _$VaccineDetailParamsCopyWithImpl(this._self, this._then);

  final VaccineDetailParams _self;
  final $Res Function(VaccineDetailParams) _then;

  /// Create a copy of VaccineDetailParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vaccineId = null,
    Object? doseNumbers = null,
    Object? householdId = null,
    Object? childId = null,
    Object? childBirthday = freezed,
  }) {
    return _then(_self.copyWith(
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      doseNumbers: null == doseNumbers
          ? _self.doseNumbers
          : doseNumbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      householdId: null == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      childBirthday: freezed == childBirthday
          ? _self.childBirthday
          : childBirthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineDetailParams].
extension VaccineDetailParamsPatterns on VaccineDetailParams {
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
    TResult Function(_VaccineDetailParams value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailParams() when $default != null:
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
    TResult Function(_VaccineDetailParams value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailParams():
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
    TResult? Function(_VaccineDetailParams value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailParams() when $default != null:
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
    TResult Function(String vaccineId, List<int> doseNumbers,
            String householdId, String childId, DateTime? childBirthday)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailParams() when $default != null:
        return $default(_that.vaccineId, _that.doseNumbers, _that.householdId,
            _that.childId, _that.childBirthday);
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
    TResult Function(String vaccineId, List<int> doseNumbers,
            String householdId, String childId, DateTime? childBirthday)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailParams():
        return $default(_that.vaccineId, _that.doseNumbers, _that.householdId,
            _that.childId, _that.childBirthday);
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
    TResult? Function(String vaccineId, List<int> doseNumbers,
            String householdId, String childId, DateTime? childBirthday)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetailParams() when $default != null:
        return $default(_that.vaccineId, _that.doseNumbers, _that.householdId,
            _that.childId, _that.childBirthday);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineDetailParams implements VaccineDetailParams {
  const _VaccineDetailParams(
      {required this.vaccineId,
      required final List<int> doseNumbers,
      required this.householdId,
      required this.childId,
      required this.childBirthday})
      : _doseNumbers = doseNumbers;

  @override
  final String vaccineId;
  final List<int> _doseNumbers;
  @override
  List<int> get doseNumbers {
    if (_doseNumbers is EqualUnmodifiableListView) return _doseNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doseNumbers);
  }

  @override
  final String householdId;
  @override
  final String childId;
  @override
  final DateTime? childBirthday;

  /// Create a copy of VaccineDetailParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineDetailParamsCopyWith<_VaccineDetailParams> get copyWith =>
      __$VaccineDetailParamsCopyWithImpl<_VaccineDetailParams>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineDetailParams &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            const DeepCollectionEquality()
                .equals(other._doseNumbers, _doseNumbers) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.childBirthday, childBirthday) ||
                other.childBirthday == childBirthday));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      vaccineId,
      const DeepCollectionEquality().hash(_doseNumbers),
      householdId,
      childId,
      childBirthday);

  @override
  String toString() {
    return 'VaccineDetailParams(vaccineId: $vaccineId, doseNumbers: $doseNumbers, householdId: $householdId, childId: $childId, childBirthday: $childBirthday)';
  }
}

/// @nodoc
abstract mixin class _$VaccineDetailParamsCopyWith<$Res>
    implements $VaccineDetailParamsCopyWith<$Res> {
  factory _$VaccineDetailParamsCopyWith(_VaccineDetailParams value,
          $Res Function(_VaccineDetailParams) _then) =
      __$VaccineDetailParamsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String vaccineId,
      List<int> doseNumbers,
      String householdId,
      String childId,
      DateTime? childBirthday});
}

/// @nodoc
class __$VaccineDetailParamsCopyWithImpl<$Res>
    implements _$VaccineDetailParamsCopyWith<$Res> {
  __$VaccineDetailParamsCopyWithImpl(this._self, this._then);

  final _VaccineDetailParams _self;
  final $Res Function(_VaccineDetailParams) _then;

  /// Create a copy of VaccineDetailParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vaccineId = null,
    Object? doseNumbers = null,
    Object? householdId = null,
    Object? childId = null,
    Object? childBirthday = freezed,
  }) {
    return _then(_VaccineDetailParams(
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      doseNumbers: null == doseNumbers
          ? _self._doseNumbers
          : doseNumbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      householdId: null == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      childBirthday: freezed == childBirthday
          ? _self.childBirthday
          : childBirthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
