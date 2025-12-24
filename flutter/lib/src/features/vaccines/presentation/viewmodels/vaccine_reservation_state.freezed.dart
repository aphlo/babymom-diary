// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_reservation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineReservationState {
  bool get isLoading;
  String? get error;
  bool get isDuplicateError;
  VaccineInfo? get primaryVaccine;
  int? get primaryDoseNumber;
  DateTime? get scheduledDate;
  List<VaccinationRecord> get availableVaccines;
  List<VaccinationRecord> get selectedAdditionalVaccines;
  bool get isAccordionExpanded;
  bool get isSubmitting;
  VaccineRecordType get recordType;

  /// Create a copy of VaccineReservationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineReservationStateCopyWith<VaccineReservationState> get copyWith =>
      _$VaccineReservationStateCopyWithImpl<VaccineReservationState>(
          this as VaccineReservationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineReservationState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isDuplicateError, isDuplicateError) ||
                other.isDuplicateError == isDuplicateError) &&
            (identical(other.primaryVaccine, primaryVaccine) ||
                other.primaryVaccine == primaryVaccine) &&
            (identical(other.primaryDoseNumber, primaryDoseNumber) ||
                other.primaryDoseNumber == primaryDoseNumber) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            const DeepCollectionEquality()
                .equals(other.availableVaccines, availableVaccines) &&
            const DeepCollectionEquality().equals(
                other.selectedAdditionalVaccines, selectedAdditionalVaccines) &&
            (identical(other.isAccordionExpanded, isAccordionExpanded) ||
                other.isAccordionExpanded == isAccordionExpanded) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.recordType, recordType) ||
                other.recordType == recordType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      isDuplicateError,
      primaryVaccine,
      primaryDoseNumber,
      scheduledDate,
      const DeepCollectionEquality().hash(availableVaccines),
      const DeepCollectionEquality().hash(selectedAdditionalVaccines),
      isAccordionExpanded,
      isSubmitting,
      recordType);

  @override
  String toString() {
    return 'VaccineReservationState(isLoading: $isLoading, error: $error, isDuplicateError: $isDuplicateError, primaryVaccine: $primaryVaccine, primaryDoseNumber: $primaryDoseNumber, scheduledDate: $scheduledDate, availableVaccines: $availableVaccines, selectedAdditionalVaccines: $selectedAdditionalVaccines, isAccordionExpanded: $isAccordionExpanded, isSubmitting: $isSubmitting, recordType: $recordType)';
  }
}

/// @nodoc
abstract mixin class $VaccineReservationStateCopyWith<$Res> {
  factory $VaccineReservationStateCopyWith(VaccineReservationState value,
          $Res Function(VaccineReservationState) _then) =
      _$VaccineReservationStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      String? error,
      bool isDuplicateError,
      VaccineInfo? primaryVaccine,
      int? primaryDoseNumber,
      DateTime? scheduledDate,
      List<VaccinationRecord> availableVaccines,
      List<VaccinationRecord> selectedAdditionalVaccines,
      bool isAccordionExpanded,
      bool isSubmitting,
      VaccineRecordType recordType});
}

/// @nodoc
class _$VaccineReservationStateCopyWithImpl<$Res>
    implements $VaccineReservationStateCopyWith<$Res> {
  _$VaccineReservationStateCopyWithImpl(this._self, this._then);

  final VaccineReservationState _self;
  final $Res Function(VaccineReservationState) _then;

  /// Create a copy of VaccineReservationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? isDuplicateError = null,
    Object? primaryVaccine = freezed,
    Object? primaryDoseNumber = freezed,
    Object? scheduledDate = freezed,
    Object? availableVaccines = null,
    Object? selectedAdditionalVaccines = null,
    Object? isAccordionExpanded = null,
    Object? isSubmitting = null,
    Object? recordType = null,
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
      isDuplicateError: null == isDuplicateError
          ? _self.isDuplicateError
          : isDuplicateError // ignore: cast_nullable_to_non_nullable
              as bool,
      primaryVaccine: freezed == primaryVaccine
          ? _self.primaryVaccine
          : primaryVaccine // ignore: cast_nullable_to_non_nullable
              as VaccineInfo?,
      primaryDoseNumber: freezed == primaryDoseNumber
          ? _self.primaryDoseNumber
          : primaryDoseNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      scheduledDate: freezed == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      availableVaccines: null == availableVaccines
          ? _self.availableVaccines
          : availableVaccines // ignore: cast_nullable_to_non_nullable
              as List<VaccinationRecord>,
      selectedAdditionalVaccines: null == selectedAdditionalVaccines
          ? _self.selectedAdditionalVaccines
          : selectedAdditionalVaccines // ignore: cast_nullable_to_non_nullable
              as List<VaccinationRecord>,
      isAccordionExpanded: null == isAccordionExpanded
          ? _self.isAccordionExpanded
          : isAccordionExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      recordType: null == recordType
          ? _self.recordType
          : recordType // ignore: cast_nullable_to_non_nullable
              as VaccineRecordType,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineReservationState].
extension VaccineReservationStatePatterns on VaccineReservationState {
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
    TResult Function(_VaccineReservationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationState() when $default != null:
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
    TResult Function(_VaccineReservationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationState():
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
    TResult? Function(_VaccineReservationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationState() when $default != null:
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
            bool isDuplicateError,
            VaccineInfo? primaryVaccine,
            int? primaryDoseNumber,
            DateTime? scheduledDate,
            List<VaccinationRecord> availableVaccines,
            List<VaccinationRecord> selectedAdditionalVaccines,
            bool isAccordionExpanded,
            bool isSubmitting,
            VaccineRecordType recordType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationState() when $default != null:
        return $default(
            _that.isLoading,
            _that.error,
            _that.isDuplicateError,
            _that.primaryVaccine,
            _that.primaryDoseNumber,
            _that.scheduledDate,
            _that.availableVaccines,
            _that.selectedAdditionalVaccines,
            _that.isAccordionExpanded,
            _that.isSubmitting,
            _that.recordType);
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
            bool isDuplicateError,
            VaccineInfo? primaryVaccine,
            int? primaryDoseNumber,
            DateTime? scheduledDate,
            List<VaccinationRecord> availableVaccines,
            List<VaccinationRecord> selectedAdditionalVaccines,
            bool isAccordionExpanded,
            bool isSubmitting,
            VaccineRecordType recordType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationState():
        return $default(
            _that.isLoading,
            _that.error,
            _that.isDuplicateError,
            _that.primaryVaccine,
            _that.primaryDoseNumber,
            _that.scheduledDate,
            _that.availableVaccines,
            _that.selectedAdditionalVaccines,
            _that.isAccordionExpanded,
            _that.isSubmitting,
            _that.recordType);
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
            bool isDuplicateError,
            VaccineInfo? primaryVaccine,
            int? primaryDoseNumber,
            DateTime? scheduledDate,
            List<VaccinationRecord> availableVaccines,
            List<VaccinationRecord> selectedAdditionalVaccines,
            bool isAccordionExpanded,
            bool isSubmitting,
            VaccineRecordType recordType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationState() when $default != null:
        return $default(
            _that.isLoading,
            _that.error,
            _that.isDuplicateError,
            _that.primaryVaccine,
            _that.primaryDoseNumber,
            _that.scheduledDate,
            _that.availableVaccines,
            _that.selectedAdditionalVaccines,
            _that.isAccordionExpanded,
            _that.isSubmitting,
            _that.recordType);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineReservationState extends VaccineReservationState {
  const _VaccineReservationState(
      {this.isLoading = false,
      this.error,
      this.isDuplicateError = false,
      this.primaryVaccine,
      this.primaryDoseNumber,
      this.scheduledDate,
      final List<VaccinationRecord> availableVaccines =
          const <VaccinationRecord>[],
      final List<VaccinationRecord> selectedAdditionalVaccines =
          const <VaccinationRecord>[],
      this.isAccordionExpanded = false,
      this.isSubmitting = false,
      this.recordType = VaccineRecordType.scheduled})
      : _availableVaccines = availableVaccines,
        _selectedAdditionalVaccines = selectedAdditionalVaccines,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isDuplicateError;
  @override
  final VaccineInfo? primaryVaccine;
  @override
  final int? primaryDoseNumber;
  @override
  final DateTime? scheduledDate;
  final List<VaccinationRecord> _availableVaccines;
  @override
  @JsonKey()
  List<VaccinationRecord> get availableVaccines {
    if (_availableVaccines is EqualUnmodifiableListView)
      return _availableVaccines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableVaccines);
  }

  final List<VaccinationRecord> _selectedAdditionalVaccines;
  @override
  @JsonKey()
  List<VaccinationRecord> get selectedAdditionalVaccines {
    if (_selectedAdditionalVaccines is EqualUnmodifiableListView)
      return _selectedAdditionalVaccines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAdditionalVaccines);
  }

  @override
  @JsonKey()
  final bool isAccordionExpanded;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final VaccineRecordType recordType;

  /// Create a copy of VaccineReservationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineReservationStateCopyWith<_VaccineReservationState> get copyWith =>
      __$VaccineReservationStateCopyWithImpl<_VaccineReservationState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineReservationState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isDuplicateError, isDuplicateError) ||
                other.isDuplicateError == isDuplicateError) &&
            (identical(other.primaryVaccine, primaryVaccine) ||
                other.primaryVaccine == primaryVaccine) &&
            (identical(other.primaryDoseNumber, primaryDoseNumber) ||
                other.primaryDoseNumber == primaryDoseNumber) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            const DeepCollectionEquality()
                .equals(other._availableVaccines, _availableVaccines) &&
            const DeepCollectionEquality().equals(
                other._selectedAdditionalVaccines,
                _selectedAdditionalVaccines) &&
            (identical(other.isAccordionExpanded, isAccordionExpanded) ||
                other.isAccordionExpanded == isAccordionExpanded) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.recordType, recordType) ||
                other.recordType == recordType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      isDuplicateError,
      primaryVaccine,
      primaryDoseNumber,
      scheduledDate,
      const DeepCollectionEquality().hash(_availableVaccines),
      const DeepCollectionEquality().hash(_selectedAdditionalVaccines),
      isAccordionExpanded,
      isSubmitting,
      recordType);

  @override
  String toString() {
    return 'VaccineReservationState(isLoading: $isLoading, error: $error, isDuplicateError: $isDuplicateError, primaryVaccine: $primaryVaccine, primaryDoseNumber: $primaryDoseNumber, scheduledDate: $scheduledDate, availableVaccines: $availableVaccines, selectedAdditionalVaccines: $selectedAdditionalVaccines, isAccordionExpanded: $isAccordionExpanded, isSubmitting: $isSubmitting, recordType: $recordType)';
  }
}

/// @nodoc
abstract mixin class _$VaccineReservationStateCopyWith<$Res>
    implements $VaccineReservationStateCopyWith<$Res> {
  factory _$VaccineReservationStateCopyWith(_VaccineReservationState value,
          $Res Function(_VaccineReservationState) _then) =
      __$VaccineReservationStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? error,
      bool isDuplicateError,
      VaccineInfo? primaryVaccine,
      int? primaryDoseNumber,
      DateTime? scheduledDate,
      List<VaccinationRecord> availableVaccines,
      List<VaccinationRecord> selectedAdditionalVaccines,
      bool isAccordionExpanded,
      bool isSubmitting,
      VaccineRecordType recordType});
}

/// @nodoc
class __$VaccineReservationStateCopyWithImpl<$Res>
    implements _$VaccineReservationStateCopyWith<$Res> {
  __$VaccineReservationStateCopyWithImpl(this._self, this._then);

  final _VaccineReservationState _self;
  final $Res Function(_VaccineReservationState) _then;

  /// Create a copy of VaccineReservationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? isDuplicateError = null,
    Object? primaryVaccine = freezed,
    Object? primaryDoseNumber = freezed,
    Object? scheduledDate = freezed,
    Object? availableVaccines = null,
    Object? selectedAdditionalVaccines = null,
    Object? isAccordionExpanded = null,
    Object? isSubmitting = null,
    Object? recordType = null,
  }) {
    return _then(_VaccineReservationState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isDuplicateError: null == isDuplicateError
          ? _self.isDuplicateError
          : isDuplicateError // ignore: cast_nullable_to_non_nullable
              as bool,
      primaryVaccine: freezed == primaryVaccine
          ? _self.primaryVaccine
          : primaryVaccine // ignore: cast_nullable_to_non_nullable
              as VaccineInfo?,
      primaryDoseNumber: freezed == primaryDoseNumber
          ? _self.primaryDoseNumber
          : primaryDoseNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      scheduledDate: freezed == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      availableVaccines: null == availableVaccines
          ? _self._availableVaccines
          : availableVaccines // ignore: cast_nullable_to_non_nullable
              as List<VaccinationRecord>,
      selectedAdditionalVaccines: null == selectedAdditionalVaccines
          ? _self._selectedAdditionalVaccines
          : selectedAdditionalVaccines // ignore: cast_nullable_to_non_nullable
              as List<VaccinationRecord>,
      isAccordionExpanded: null == isAccordionExpanded
          ? _self.isAccordionExpanded
          : isAccordionExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      recordType: null == recordType
          ? _self.recordType
          : recordType // ignore: cast_nullable_to_non_nullable
              as VaccineRecordType,
    ));
  }
}

/// @nodoc
mixin _$VaccineReservationParams {
  VaccineInfo get vaccine;
  int get doseNumber;

  /// Create a copy of VaccineReservationParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineReservationParamsCopyWith<VaccineReservationParams> get copyWith =>
      _$VaccineReservationParamsCopyWithImpl<VaccineReservationParams>(
          this as VaccineReservationParams, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineReservationParams &&
            (identical(other.vaccine, vaccine) || other.vaccine == vaccine) &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vaccine, doseNumber);

  @override
  String toString() {
    return 'VaccineReservationParams(vaccine: $vaccine, doseNumber: $doseNumber)';
  }
}

/// @nodoc
abstract mixin class $VaccineReservationParamsCopyWith<$Res> {
  factory $VaccineReservationParamsCopyWith(VaccineReservationParams value,
          $Res Function(VaccineReservationParams) _then) =
      _$VaccineReservationParamsCopyWithImpl;
  @useResult
  $Res call({VaccineInfo vaccine, int doseNumber});
}

/// @nodoc
class _$VaccineReservationParamsCopyWithImpl<$Res>
    implements $VaccineReservationParamsCopyWith<$Res> {
  _$VaccineReservationParamsCopyWithImpl(this._self, this._then);

  final VaccineReservationParams _self;
  final $Res Function(VaccineReservationParams) _then;

  /// Create a copy of VaccineReservationParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vaccine = null,
    Object? doseNumber = null,
  }) {
    return _then(_self.copyWith(
      vaccine: null == vaccine
          ? _self.vaccine
          : vaccine // ignore: cast_nullable_to_non_nullable
              as VaccineInfo,
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineReservationParams].
extension VaccineReservationParamsPatterns on VaccineReservationParams {
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
    TResult Function(_VaccineReservationParams value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationParams() when $default != null:
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
    TResult Function(_VaccineReservationParams value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationParams():
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
    TResult? Function(_VaccineReservationParams value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationParams() when $default != null:
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
    TResult Function(VaccineInfo vaccine, int doseNumber)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationParams() when $default != null:
        return $default(_that.vaccine, _that.doseNumber);
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
    TResult Function(VaccineInfo vaccine, int doseNumber) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationParams():
        return $default(_that.vaccine, _that.doseNumber);
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
    TResult? Function(VaccineInfo vaccine, int doseNumber)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineReservationParams() when $default != null:
        return $default(_that.vaccine, _that.doseNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineReservationParams implements VaccineReservationParams {
  const _VaccineReservationParams(
      {required this.vaccine, required this.doseNumber});

  @override
  final VaccineInfo vaccine;
  @override
  final int doseNumber;

  /// Create a copy of VaccineReservationParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineReservationParamsCopyWith<_VaccineReservationParams> get copyWith =>
      __$VaccineReservationParamsCopyWithImpl<_VaccineReservationParams>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineReservationParams &&
            (identical(other.vaccine, vaccine) || other.vaccine == vaccine) &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vaccine, doseNumber);

  @override
  String toString() {
    return 'VaccineReservationParams(vaccine: $vaccine, doseNumber: $doseNumber)';
  }
}

/// @nodoc
abstract mixin class _$VaccineReservationParamsCopyWith<$Res>
    implements $VaccineReservationParamsCopyWith<$Res> {
  factory _$VaccineReservationParamsCopyWith(_VaccineReservationParams value,
          $Res Function(_VaccineReservationParams) _then) =
      __$VaccineReservationParamsCopyWithImpl;
  @override
  @useResult
  $Res call({VaccineInfo vaccine, int doseNumber});
}

/// @nodoc
class __$VaccineReservationParamsCopyWithImpl<$Res>
    implements _$VaccineReservationParamsCopyWith<$Res> {
  __$VaccineReservationParamsCopyWithImpl(this._self, this._then);

  final _VaccineReservationParams _self;
  final $Res Function(_VaccineReservationParams) _then;

  /// Create a copy of VaccineReservationParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vaccine = null,
    Object? doseNumber = null,
  }) {
    return _then(_VaccineReservationParams(
      vaccine: null == vaccine
          ? _self.vaccine
          : vaccine // ignore: cast_nullable_to_non_nullable
              as VaccineInfo,
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
