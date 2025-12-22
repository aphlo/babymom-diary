// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mom_record_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MomRecordPageState {
  DateTime get focusMonth;
  AsyncValue<MomMonthlyRecordUiModel> get monthlyRecords;
  int get selectedTabIndex;
  String? get householdId;

  /// Create a copy of MomRecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MomRecordPageStateCopyWith<MomRecordPageState> get copyWith =>
      _$MomRecordPageStateCopyWithImpl<MomRecordPageState>(
          this as MomRecordPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MomRecordPageState &&
            (identical(other.focusMonth, focusMonth) ||
                other.focusMonth == focusMonth) &&
            (identical(other.monthlyRecords, monthlyRecords) ||
                other.monthlyRecords == monthlyRecords) &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, focusMonth, monthlyRecords, selectedTabIndex, householdId);

  @override
  String toString() {
    return 'MomRecordPageState(focusMonth: $focusMonth, monthlyRecords: $monthlyRecords, selectedTabIndex: $selectedTabIndex, householdId: $householdId)';
  }
}

/// @nodoc
abstract mixin class $MomRecordPageStateCopyWith<$Res> {
  factory $MomRecordPageStateCopyWith(
          MomRecordPageState value, $Res Function(MomRecordPageState) _then) =
      _$MomRecordPageStateCopyWithImpl;
  @useResult
  $Res call(
      {DateTime focusMonth,
      AsyncValue<MomMonthlyRecordUiModel> monthlyRecords,
      int selectedTabIndex,
      String? householdId});
}

/// @nodoc
class _$MomRecordPageStateCopyWithImpl<$Res>
    implements $MomRecordPageStateCopyWith<$Res> {
  _$MomRecordPageStateCopyWithImpl(this._self, this._then);

  final MomRecordPageState _self;
  final $Res Function(MomRecordPageState) _then;

  /// Create a copy of MomRecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusMonth = null,
    Object? monthlyRecords = null,
    Object? selectedTabIndex = null,
    Object? householdId = freezed,
  }) {
    return _then(_self.copyWith(
      focusMonth: null == focusMonth
          ? _self.focusMonth
          : focusMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      monthlyRecords: null == monthlyRecords
          ? _self.monthlyRecords
          : monthlyRecords // ignore: cast_nullable_to_non_nullable
              as AsyncValue<MomMonthlyRecordUiModel>,
      selectedTabIndex: null == selectedTabIndex
          ? _self.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      householdId: freezed == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MomRecordPageState].
extension MomRecordPageStatePatterns on MomRecordPageState {
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
    TResult Function(_MomRecordPageState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MomRecordPageState() when $default != null:
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
    TResult Function(_MomRecordPageState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomRecordPageState():
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
    TResult? Function(_MomRecordPageState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomRecordPageState() when $default != null:
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
            DateTime focusMonth,
            AsyncValue<MomMonthlyRecordUiModel> monthlyRecords,
            int selectedTabIndex,
            String? householdId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MomRecordPageState() when $default != null:
        return $default(_that.focusMonth, _that.monthlyRecords,
            _that.selectedTabIndex, _that.householdId);
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
            DateTime focusMonth,
            AsyncValue<MomMonthlyRecordUiModel> monthlyRecords,
            int selectedTabIndex,
            String? householdId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomRecordPageState():
        return $default(_that.focusMonth, _that.monthlyRecords,
            _that.selectedTabIndex, _that.householdId);
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
            DateTime focusMonth,
            AsyncValue<MomMonthlyRecordUiModel> monthlyRecords,
            int selectedTabIndex,
            String? householdId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomRecordPageState() when $default != null:
        return $default(_that.focusMonth, _that.monthlyRecords,
            _that.selectedTabIndex, _that.householdId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MomRecordPageState extends MomRecordPageState {
  const _MomRecordPageState(
      {required this.focusMonth,
      required this.monthlyRecords,
      required this.selectedTabIndex,
      this.householdId})
      : super._();

  @override
  final DateTime focusMonth;
  @override
  final AsyncValue<MomMonthlyRecordUiModel> monthlyRecords;
  @override
  final int selectedTabIndex;
  @override
  final String? householdId;

  /// Create a copy of MomRecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MomRecordPageStateCopyWith<_MomRecordPageState> get copyWith =>
      __$MomRecordPageStateCopyWithImpl<_MomRecordPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MomRecordPageState &&
            (identical(other.focusMonth, focusMonth) ||
                other.focusMonth == focusMonth) &&
            (identical(other.monthlyRecords, monthlyRecords) ||
                other.monthlyRecords == monthlyRecords) &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, focusMonth, monthlyRecords, selectedTabIndex, householdId);

  @override
  String toString() {
    return 'MomRecordPageState(focusMonth: $focusMonth, monthlyRecords: $monthlyRecords, selectedTabIndex: $selectedTabIndex, householdId: $householdId)';
  }
}

/// @nodoc
abstract mixin class _$MomRecordPageStateCopyWith<$Res>
    implements $MomRecordPageStateCopyWith<$Res> {
  factory _$MomRecordPageStateCopyWith(
          _MomRecordPageState value, $Res Function(_MomRecordPageState) _then) =
      __$MomRecordPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime focusMonth,
      AsyncValue<MomMonthlyRecordUiModel> monthlyRecords,
      int selectedTabIndex,
      String? householdId});
}

/// @nodoc
class __$MomRecordPageStateCopyWithImpl<$Res>
    implements _$MomRecordPageStateCopyWith<$Res> {
  __$MomRecordPageStateCopyWithImpl(this._self, this._then);

  final _MomRecordPageState _self;
  final $Res Function(_MomRecordPageState) _then;

  /// Create a copy of MomRecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? focusMonth = null,
    Object? monthlyRecords = null,
    Object? selectedTabIndex = null,
    Object? householdId = freezed,
  }) {
    return _then(_MomRecordPageState(
      focusMonth: null == focusMonth
          ? _self.focusMonth
          : focusMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      monthlyRecords: null == monthlyRecords
          ? _self.monthlyRecords
          : monthlyRecords // ignore: cast_nullable_to_non_nullable
              as AsyncValue<MomMonthlyRecordUiModel>,
      selectedTabIndex: null == selectedTabIndex
          ? _self.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      householdId: freezed == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
