// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'concurrent_vaccines_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConcurrentVaccineMember {
  String get vaccineId;
  String get vaccineName;
  String get doseId;
  int get doseNumber;

  /// Create a copy of ConcurrentVaccineMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConcurrentVaccineMemberCopyWith<ConcurrentVaccineMember> get copyWith =>
      _$ConcurrentVaccineMemberCopyWithImpl<ConcurrentVaccineMember>(
          this as ConcurrentVaccineMember, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConcurrentVaccineMember &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.vaccineName, vaccineName) ||
                other.vaccineName == vaccineName) &&
            (identical(other.doseId, doseId) || other.doseId == doseId) &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, vaccineId, vaccineName, doseId, doseNumber);

  @override
  String toString() {
    return 'ConcurrentVaccineMember(vaccineId: $vaccineId, vaccineName: $vaccineName, doseId: $doseId, doseNumber: $doseNumber)';
  }
}

/// @nodoc
abstract mixin class $ConcurrentVaccineMemberCopyWith<$Res> {
  factory $ConcurrentVaccineMemberCopyWith(ConcurrentVaccineMember value,
          $Res Function(ConcurrentVaccineMember) _then) =
      _$ConcurrentVaccineMemberCopyWithImpl;
  @useResult
  $Res call(
      {String vaccineId, String vaccineName, String doseId, int doseNumber});
}

/// @nodoc
class _$ConcurrentVaccineMemberCopyWithImpl<$Res>
    implements $ConcurrentVaccineMemberCopyWith<$Res> {
  _$ConcurrentVaccineMemberCopyWithImpl(this._self, this._then);

  final ConcurrentVaccineMember _self;
  final $Res Function(ConcurrentVaccineMember) _then;

  /// Create a copy of ConcurrentVaccineMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vaccineId = null,
    Object? vaccineName = null,
    Object? doseId = null,
    Object? doseNumber = null,
  }) {
    return _then(_self.copyWith(
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineName: null == vaccineName
          ? _self.vaccineName
          : vaccineName // ignore: cast_nullable_to_non_nullable
              as String,
      doseId: null == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String,
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConcurrentVaccineMember].
extension ConcurrentVaccineMemberPatterns on ConcurrentVaccineMember {
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
    TResult Function(_ConcurrentVaccineMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccineMember() when $default != null:
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
    TResult Function(_ConcurrentVaccineMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccineMember():
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
    TResult? Function(_ConcurrentVaccineMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccineMember() when $default != null:
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
    TResult Function(String vaccineId, String vaccineName, String doseId,
            int doseNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccineMember() when $default != null:
        return $default(
            _that.vaccineId, _that.vaccineName, _that.doseId, _that.doseNumber);
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
            String vaccineId, String vaccineName, String doseId, int doseNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccineMember():
        return $default(
            _that.vaccineId, _that.vaccineName, _that.doseId, _that.doseNumber);
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
    TResult? Function(String vaccineId, String vaccineName, String doseId,
            int doseNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccineMember() when $default != null:
        return $default(
            _that.vaccineId, _that.vaccineName, _that.doseId, _that.doseNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConcurrentVaccineMember implements ConcurrentVaccineMember {
  const _ConcurrentVaccineMember(
      {required this.vaccineId,
      required this.vaccineName,
      required this.doseId,
      required this.doseNumber});

  @override
  final String vaccineId;
  @override
  final String vaccineName;
  @override
  final String doseId;
  @override
  final int doseNumber;

  /// Create a copy of ConcurrentVaccineMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConcurrentVaccineMemberCopyWith<_ConcurrentVaccineMember> get copyWith =>
      __$ConcurrentVaccineMemberCopyWithImpl<_ConcurrentVaccineMember>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConcurrentVaccineMember &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.vaccineName, vaccineName) ||
                other.vaccineName == vaccineName) &&
            (identical(other.doseId, doseId) || other.doseId == doseId) &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, vaccineId, vaccineName, doseId, doseNumber);

  @override
  String toString() {
    return 'ConcurrentVaccineMember(vaccineId: $vaccineId, vaccineName: $vaccineName, doseId: $doseId, doseNumber: $doseNumber)';
  }
}

/// @nodoc
abstract mixin class _$ConcurrentVaccineMemberCopyWith<$Res>
    implements $ConcurrentVaccineMemberCopyWith<$Res> {
  factory _$ConcurrentVaccineMemberCopyWith(_ConcurrentVaccineMember value,
          $Res Function(_ConcurrentVaccineMember) _then) =
      __$ConcurrentVaccineMemberCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String vaccineId, String vaccineName, String doseId, int doseNumber});
}

/// @nodoc
class __$ConcurrentVaccineMemberCopyWithImpl<$Res>
    implements _$ConcurrentVaccineMemberCopyWith<$Res> {
  __$ConcurrentVaccineMemberCopyWithImpl(this._self, this._then);

  final _ConcurrentVaccineMember _self;
  final $Res Function(_ConcurrentVaccineMember) _then;

  /// Create a copy of ConcurrentVaccineMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vaccineId = null,
    Object? vaccineName = null,
    Object? doseId = null,
    Object? doseNumber = null,
  }) {
    return _then(_ConcurrentVaccineMember(
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineName: null == vaccineName
          ? _self.vaccineName
          : vaccineName // ignore: cast_nullable_to_non_nullable
              as String,
      doseId: null == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String,
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ConcurrentVaccinesState {
  bool get isLoading;
  String? get error;
  List<ConcurrentVaccineMember> get members;

  /// Create a copy of ConcurrentVaccinesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConcurrentVaccinesStateCopyWith<ConcurrentVaccinesState> get copyWith =>
      _$ConcurrentVaccinesStateCopyWithImpl<ConcurrentVaccinesState>(
          this as ConcurrentVaccinesState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConcurrentVaccinesState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other.members, members));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error,
      const DeepCollectionEquality().hash(members));

  @override
  String toString() {
    return 'ConcurrentVaccinesState(isLoading: $isLoading, error: $error, members: $members)';
  }
}

/// @nodoc
abstract mixin class $ConcurrentVaccinesStateCopyWith<$Res> {
  factory $ConcurrentVaccinesStateCopyWith(ConcurrentVaccinesState value,
          $Res Function(ConcurrentVaccinesState) _then) =
      _$ConcurrentVaccinesStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading, String? error, List<ConcurrentVaccineMember> members});
}

/// @nodoc
class _$ConcurrentVaccinesStateCopyWithImpl<$Res>
    implements $ConcurrentVaccinesStateCopyWith<$Res> {
  _$ConcurrentVaccinesStateCopyWithImpl(this._self, this._then);

  final ConcurrentVaccinesState _self;
  final $Res Function(ConcurrentVaccinesState) _then;

  /// Create a copy of ConcurrentVaccinesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? members = null,
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
      members: null == members
          ? _self.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ConcurrentVaccineMember>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConcurrentVaccinesState].
extension ConcurrentVaccinesStatePatterns on ConcurrentVaccinesState {
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
    TResult Function(_ConcurrentVaccinesState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesState() when $default != null:
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
    TResult Function(_ConcurrentVaccinesState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesState():
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
    TResult? Function(_ConcurrentVaccinesState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesState() when $default != null:
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
    TResult Function(bool isLoading, String? error,
            List<ConcurrentVaccineMember> members)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.members);
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
    TResult Function(bool isLoading, String? error,
            List<ConcurrentVaccineMember> members)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesState():
        return $default(_that.isLoading, _that.error, _that.members);
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
    TResult? Function(bool isLoading, String? error,
            List<ConcurrentVaccineMember> members)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.members);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConcurrentVaccinesState implements ConcurrentVaccinesState {
  const _ConcurrentVaccinesState(
      {this.isLoading = false,
      this.error,
      final List<ConcurrentVaccineMember> members =
          const <ConcurrentVaccineMember>[]})
      : _members = members;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  final List<ConcurrentVaccineMember> _members;
  @override
  @JsonKey()
  List<ConcurrentVaccineMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Create a copy of ConcurrentVaccinesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConcurrentVaccinesStateCopyWith<_ConcurrentVaccinesState> get copyWith =>
      __$ConcurrentVaccinesStateCopyWithImpl<_ConcurrentVaccinesState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConcurrentVaccinesState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error,
      const DeepCollectionEquality().hash(_members));

  @override
  String toString() {
    return 'ConcurrentVaccinesState(isLoading: $isLoading, error: $error, members: $members)';
  }
}

/// @nodoc
abstract mixin class _$ConcurrentVaccinesStateCopyWith<$Res>
    implements $ConcurrentVaccinesStateCopyWith<$Res> {
  factory _$ConcurrentVaccinesStateCopyWith(_ConcurrentVaccinesState value,
          $Res Function(_ConcurrentVaccinesState) _then) =
      __$ConcurrentVaccinesStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading, String? error, List<ConcurrentVaccineMember> members});
}

/// @nodoc
class __$ConcurrentVaccinesStateCopyWithImpl<$Res>
    implements _$ConcurrentVaccinesStateCopyWith<$Res> {
  __$ConcurrentVaccinesStateCopyWithImpl(this._self, this._then);

  final _ConcurrentVaccinesState _self;
  final $Res Function(_ConcurrentVaccinesState) _then;

  /// Create a copy of ConcurrentVaccinesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? members = null,
  }) {
    return _then(_ConcurrentVaccinesState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      members: null == members
          ? _self._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ConcurrentVaccineMember>,
    ));
  }
}

/// @nodoc
mixin _$ConcurrentVaccinesParams {
  String get householdId;
  String get childId;
  String get reservationGroupId;
  String get currentVaccineId;
  String get currentDoseId;

  /// Create a copy of ConcurrentVaccinesParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConcurrentVaccinesParamsCopyWith<ConcurrentVaccinesParams> get copyWith =>
      _$ConcurrentVaccinesParamsCopyWithImpl<ConcurrentVaccinesParams>(
          this as ConcurrentVaccinesParams, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConcurrentVaccinesParams &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId) &&
            (identical(other.currentVaccineId, currentVaccineId) ||
                other.currentVaccineId == currentVaccineId) &&
            (identical(other.currentDoseId, currentDoseId) ||
                other.currentDoseId == currentDoseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, householdId, childId,
      reservationGroupId, currentVaccineId, currentDoseId);

  @override
  String toString() {
    return 'ConcurrentVaccinesParams(householdId: $householdId, childId: $childId, reservationGroupId: $reservationGroupId, currentVaccineId: $currentVaccineId, currentDoseId: $currentDoseId)';
  }
}

/// @nodoc
abstract mixin class $ConcurrentVaccinesParamsCopyWith<$Res> {
  factory $ConcurrentVaccinesParamsCopyWith(ConcurrentVaccinesParams value,
          $Res Function(ConcurrentVaccinesParams) _then) =
      _$ConcurrentVaccinesParamsCopyWithImpl;
  @useResult
  $Res call(
      {String householdId,
      String childId,
      String reservationGroupId,
      String currentVaccineId,
      String currentDoseId});
}

/// @nodoc
class _$ConcurrentVaccinesParamsCopyWithImpl<$Res>
    implements $ConcurrentVaccinesParamsCopyWith<$Res> {
  _$ConcurrentVaccinesParamsCopyWithImpl(this._self, this._then);

  final ConcurrentVaccinesParams _self;
  final $Res Function(ConcurrentVaccinesParams) _then;

  /// Create a copy of ConcurrentVaccinesParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = null,
    Object? childId = null,
    Object? reservationGroupId = null,
    Object? currentVaccineId = null,
    Object? currentDoseId = null,
  }) {
    return _then(_self.copyWith(
      householdId: null == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      reservationGroupId: null == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String,
      currentVaccineId: null == currentVaccineId
          ? _self.currentVaccineId
          : currentVaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      currentDoseId: null == currentDoseId
          ? _self.currentDoseId
          : currentDoseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConcurrentVaccinesParams].
extension ConcurrentVaccinesParamsPatterns on ConcurrentVaccinesParams {
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
    TResult Function(_ConcurrentVaccinesParams value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesParams() when $default != null:
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
    TResult Function(_ConcurrentVaccinesParams value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesParams():
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
    TResult? Function(_ConcurrentVaccinesParams value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesParams() when $default != null:
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
            String householdId,
            String childId,
            String reservationGroupId,
            String currentVaccineId,
            String currentDoseId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesParams() when $default != null:
        return $default(
            _that.householdId,
            _that.childId,
            _that.reservationGroupId,
            _that.currentVaccineId,
            _that.currentDoseId);
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
            String householdId,
            String childId,
            String reservationGroupId,
            String currentVaccineId,
            String currentDoseId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesParams():
        return $default(
            _that.householdId,
            _that.childId,
            _that.reservationGroupId,
            _that.currentVaccineId,
            _that.currentDoseId);
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
            String householdId,
            String childId,
            String reservationGroupId,
            String currentVaccineId,
            String currentDoseId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcurrentVaccinesParams() when $default != null:
        return $default(
            _that.householdId,
            _that.childId,
            _that.reservationGroupId,
            _that.currentVaccineId,
            _that.currentDoseId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConcurrentVaccinesParams implements ConcurrentVaccinesParams {
  const _ConcurrentVaccinesParams(
      {required this.householdId,
      required this.childId,
      required this.reservationGroupId,
      required this.currentVaccineId,
      required this.currentDoseId});

  @override
  final String householdId;
  @override
  final String childId;
  @override
  final String reservationGroupId;
  @override
  final String currentVaccineId;
  @override
  final String currentDoseId;

  /// Create a copy of ConcurrentVaccinesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConcurrentVaccinesParamsCopyWith<_ConcurrentVaccinesParams> get copyWith =>
      __$ConcurrentVaccinesParamsCopyWithImpl<_ConcurrentVaccinesParams>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConcurrentVaccinesParams &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.reservationGroupId, reservationGroupId) ||
                other.reservationGroupId == reservationGroupId) &&
            (identical(other.currentVaccineId, currentVaccineId) ||
                other.currentVaccineId == currentVaccineId) &&
            (identical(other.currentDoseId, currentDoseId) ||
                other.currentDoseId == currentDoseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, householdId, childId,
      reservationGroupId, currentVaccineId, currentDoseId);

  @override
  String toString() {
    return 'ConcurrentVaccinesParams(householdId: $householdId, childId: $childId, reservationGroupId: $reservationGroupId, currentVaccineId: $currentVaccineId, currentDoseId: $currentDoseId)';
  }
}

/// @nodoc
abstract mixin class _$ConcurrentVaccinesParamsCopyWith<$Res>
    implements $ConcurrentVaccinesParamsCopyWith<$Res> {
  factory _$ConcurrentVaccinesParamsCopyWith(_ConcurrentVaccinesParams value,
          $Res Function(_ConcurrentVaccinesParams) _then) =
      __$ConcurrentVaccinesParamsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String householdId,
      String childId,
      String reservationGroupId,
      String currentVaccineId,
      String currentDoseId});
}

/// @nodoc
class __$ConcurrentVaccinesParamsCopyWithImpl<$Res>
    implements _$ConcurrentVaccinesParamsCopyWith<$Res> {
  __$ConcurrentVaccinesParamsCopyWithImpl(this._self, this._then);

  final _ConcurrentVaccinesParams _self;
  final $Res Function(_ConcurrentVaccinesParams) _then;

  /// Create a copy of ConcurrentVaccinesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? householdId = null,
    Object? childId = null,
    Object? reservationGroupId = null,
    Object? currentVaccineId = null,
    Object? currentDoseId = null,
  }) {
    return _then(_ConcurrentVaccinesParams(
      householdId: null == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      reservationGroupId: null == reservationGroupId
          ? _self.reservationGroupId
          : reservationGroupId // ignore: cast_nullable_to_non_nullable
              as String,
      currentVaccineId: null == currentVaccineId
          ? _self.currentVaccineId
          : currentVaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      currentDoseId: null == currentDoseId
          ? _self.currentDoseId
          : currentDoseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
