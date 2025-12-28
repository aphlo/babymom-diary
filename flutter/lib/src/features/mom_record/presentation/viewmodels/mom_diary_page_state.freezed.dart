// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mom_diary_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MomDiaryPageState {
  DateTime get focusMonth;
  AsyncValue<MomDiaryMonthlyUiModel> get monthlyDiary;
  String? get householdId;

  /// Create a copy of MomDiaryPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MomDiaryPageStateCopyWith<MomDiaryPageState> get copyWith =>
      _$MomDiaryPageStateCopyWithImpl<MomDiaryPageState>(
          this as MomDiaryPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MomDiaryPageState &&
            (identical(other.focusMonth, focusMonth) ||
                other.focusMonth == focusMonth) &&
            (identical(other.monthlyDiary, monthlyDiary) ||
                other.monthlyDiary == monthlyDiary) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, focusMonth, monthlyDiary, householdId);

  @override
  String toString() {
    return 'MomDiaryPageState(focusMonth: $focusMonth, monthlyDiary: $monthlyDiary, householdId: $householdId)';
  }
}

/// @nodoc
abstract mixin class $MomDiaryPageStateCopyWith<$Res> {
  factory $MomDiaryPageStateCopyWith(
          MomDiaryPageState value, $Res Function(MomDiaryPageState) _then) =
      _$MomDiaryPageStateCopyWithImpl;
  @useResult
  $Res call(
      {DateTime focusMonth,
      AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary,
      String? householdId});
}

/// @nodoc
class _$MomDiaryPageStateCopyWithImpl<$Res>
    implements $MomDiaryPageStateCopyWith<$Res> {
  _$MomDiaryPageStateCopyWithImpl(this._self, this._then);

  final MomDiaryPageState _self;
  final $Res Function(MomDiaryPageState) _then;

  /// Create a copy of MomDiaryPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusMonth = null,
    Object? monthlyDiary = null,
    Object? householdId = freezed,
  }) {
    return _then(_self.copyWith(
      focusMonth: null == focusMonth
          ? _self.focusMonth
          : focusMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      monthlyDiary: null == monthlyDiary
          ? _self.monthlyDiary
          : monthlyDiary // ignore: cast_nullable_to_non_nullable
              as AsyncValue<MomDiaryMonthlyUiModel>,
      householdId: freezed == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MomDiaryPageState].
extension MomDiaryPageStatePatterns on MomDiaryPageState {
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
    TResult Function(_MomDiaryPageState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MomDiaryPageState() when $default != null:
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
    TResult Function(_MomDiaryPageState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryPageState():
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
    TResult? Function(_MomDiaryPageState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryPageState() when $default != null:
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
            AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary,
            String? householdId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MomDiaryPageState() when $default != null:
        return $default(
            _that.focusMonth, _that.monthlyDiary, _that.householdId);
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
            AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary,
            String? householdId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryPageState():
        return $default(
            _that.focusMonth, _that.monthlyDiary, _that.householdId);
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
            AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary,
            String? householdId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryPageState() when $default != null:
        return $default(
            _that.focusMonth, _that.monthlyDiary, _that.householdId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MomDiaryPageState extends MomDiaryPageState {
  const _MomDiaryPageState(
      {required this.focusMonth, required this.monthlyDiary, this.householdId})
      : super._();

  @override
  final DateTime focusMonth;
  @override
  final AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary;
  @override
  final String? householdId;

  /// Create a copy of MomDiaryPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MomDiaryPageStateCopyWith<_MomDiaryPageState> get copyWith =>
      __$MomDiaryPageStateCopyWithImpl<_MomDiaryPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MomDiaryPageState &&
            (identical(other.focusMonth, focusMonth) ||
                other.focusMonth == focusMonth) &&
            (identical(other.monthlyDiary, monthlyDiary) ||
                other.monthlyDiary == monthlyDiary) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, focusMonth, monthlyDiary, householdId);

  @override
  String toString() {
    return 'MomDiaryPageState(focusMonth: $focusMonth, monthlyDiary: $monthlyDiary, householdId: $householdId)';
  }
}

/// @nodoc
abstract mixin class _$MomDiaryPageStateCopyWith<$Res>
    implements $MomDiaryPageStateCopyWith<$Res> {
  factory _$MomDiaryPageStateCopyWith(
          _MomDiaryPageState value, $Res Function(_MomDiaryPageState) _then) =
      __$MomDiaryPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime focusMonth,
      AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary,
      String? householdId});
}

/// @nodoc
class __$MomDiaryPageStateCopyWithImpl<$Res>
    implements _$MomDiaryPageStateCopyWith<$Res> {
  __$MomDiaryPageStateCopyWithImpl(this._self, this._then);

  final _MomDiaryPageState _self;
  final $Res Function(_MomDiaryPageState) _then;

  /// Create a copy of MomDiaryPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? focusMonth = null,
    Object? monthlyDiary = null,
    Object? householdId = freezed,
  }) {
    return _then(_MomDiaryPageState(
      focusMonth: null == focusMonth
          ? _self.focusMonth
          : focusMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      monthlyDiary: null == monthlyDiary
          ? _self.monthlyDiary
          : monthlyDiary // ignore: cast_nullable_to_non_nullable
              as AsyncValue<MomDiaryMonthlyUiModel>,
      householdId: freezed == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
