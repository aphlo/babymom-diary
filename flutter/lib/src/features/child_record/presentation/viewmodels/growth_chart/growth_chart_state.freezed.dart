// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'growth_chart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GrowthChartState {
  AgeRange get selectedAgeRange;
  AsyncValue<GrowthChartData> get chartData;
  ChildSummary? get childSummary;
  bool get isLoadingChild;

  /// Create a copy of GrowthChartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GrowthChartStateCopyWith<GrowthChartState> get copyWith =>
      _$GrowthChartStateCopyWithImpl<GrowthChartState>(
          this as GrowthChartState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GrowthChartState &&
            (identical(other.selectedAgeRange, selectedAgeRange) ||
                other.selectedAgeRange == selectedAgeRange) &&
            (identical(other.chartData, chartData) ||
                other.chartData == chartData) &&
            (identical(other.childSummary, childSummary) ||
                other.childSummary == childSummary) &&
            (identical(other.isLoadingChild, isLoadingChild) ||
                other.isLoadingChild == isLoadingChild));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedAgeRange, chartData, childSummary, isLoadingChild);

  @override
  String toString() {
    return 'GrowthChartState(selectedAgeRange: $selectedAgeRange, chartData: $chartData, childSummary: $childSummary, isLoadingChild: $isLoadingChild)';
  }
}

/// @nodoc
abstract mixin class $GrowthChartStateCopyWith<$Res> {
  factory $GrowthChartStateCopyWith(
          GrowthChartState value, $Res Function(GrowthChartState) _then) =
      _$GrowthChartStateCopyWithImpl;
  @useResult
  $Res call(
      {AgeRange selectedAgeRange,
      AsyncValue<GrowthChartData> chartData,
      ChildSummary? childSummary,
      bool isLoadingChild});

  $ChildSummaryCopyWith<$Res>? get childSummary;
}

/// @nodoc
class _$GrowthChartStateCopyWithImpl<$Res>
    implements $GrowthChartStateCopyWith<$Res> {
  _$GrowthChartStateCopyWithImpl(this._self, this._then);

  final GrowthChartState _self;
  final $Res Function(GrowthChartState) _then;

  /// Create a copy of GrowthChartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedAgeRange = null,
    Object? chartData = null,
    Object? childSummary = freezed,
    Object? isLoadingChild = null,
  }) {
    return _then(_self.copyWith(
      selectedAgeRange: null == selectedAgeRange
          ? _self.selectedAgeRange
          : selectedAgeRange // ignore: cast_nullable_to_non_nullable
              as AgeRange,
      chartData: null == chartData
          ? _self.chartData
          : chartData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<GrowthChartData>,
      childSummary: freezed == childSummary
          ? _self.childSummary
          : childSummary // ignore: cast_nullable_to_non_nullable
              as ChildSummary?,
      isLoadingChild: null == isLoadingChild
          ? _self.isLoadingChild
          : isLoadingChild // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of GrowthChartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChildSummaryCopyWith<$Res>? get childSummary {
    if (_self.childSummary == null) {
      return null;
    }

    return $ChildSummaryCopyWith<$Res>(_self.childSummary!, (value) {
      return _then(_self.copyWith(childSummary: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GrowthChartState].
extension GrowthChartStatePatterns on GrowthChartState {
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
    TResult Function(_GrowthChartState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GrowthChartState() when $default != null:
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
    TResult Function(_GrowthChartState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GrowthChartState():
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
    TResult? Function(_GrowthChartState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GrowthChartState() when $default != null:
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
            AgeRange selectedAgeRange,
            AsyncValue<GrowthChartData> chartData,
            ChildSummary? childSummary,
            bool isLoadingChild)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GrowthChartState() when $default != null:
        return $default(_that.selectedAgeRange, _that.chartData,
            _that.childSummary, _that.isLoadingChild);
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
            AgeRange selectedAgeRange,
            AsyncValue<GrowthChartData> chartData,
            ChildSummary? childSummary,
            bool isLoadingChild)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GrowthChartState():
        return $default(_that.selectedAgeRange, _that.chartData,
            _that.childSummary, _that.isLoadingChild);
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
            AgeRange selectedAgeRange,
            AsyncValue<GrowthChartData> chartData,
            ChildSummary? childSummary,
            bool isLoadingChild)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GrowthChartState() when $default != null:
        return $default(_that.selectedAgeRange, _that.chartData,
            _that.childSummary, _that.isLoadingChild);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GrowthChartState extends GrowthChartState {
  const _GrowthChartState(
      {required this.selectedAgeRange,
      required this.chartData,
      this.childSummary,
      this.isLoadingChild = true})
      : super._();

  @override
  final AgeRange selectedAgeRange;
  @override
  final AsyncValue<GrowthChartData> chartData;
  @override
  final ChildSummary? childSummary;
  @override
  @JsonKey()
  final bool isLoadingChild;

  /// Create a copy of GrowthChartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GrowthChartStateCopyWith<_GrowthChartState> get copyWith =>
      __$GrowthChartStateCopyWithImpl<_GrowthChartState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GrowthChartState &&
            (identical(other.selectedAgeRange, selectedAgeRange) ||
                other.selectedAgeRange == selectedAgeRange) &&
            (identical(other.chartData, chartData) ||
                other.chartData == chartData) &&
            (identical(other.childSummary, childSummary) ||
                other.childSummary == childSummary) &&
            (identical(other.isLoadingChild, isLoadingChild) ||
                other.isLoadingChild == isLoadingChild));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedAgeRange, chartData, childSummary, isLoadingChild);

  @override
  String toString() {
    return 'GrowthChartState(selectedAgeRange: $selectedAgeRange, chartData: $chartData, childSummary: $childSummary, isLoadingChild: $isLoadingChild)';
  }
}

/// @nodoc
abstract mixin class _$GrowthChartStateCopyWith<$Res>
    implements $GrowthChartStateCopyWith<$Res> {
  factory _$GrowthChartStateCopyWith(
          _GrowthChartState value, $Res Function(_GrowthChartState) _then) =
      __$GrowthChartStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {AgeRange selectedAgeRange,
      AsyncValue<GrowthChartData> chartData,
      ChildSummary? childSummary,
      bool isLoadingChild});

  @override
  $ChildSummaryCopyWith<$Res>? get childSummary;
}

/// @nodoc
class __$GrowthChartStateCopyWithImpl<$Res>
    implements _$GrowthChartStateCopyWith<$Res> {
  __$GrowthChartStateCopyWithImpl(this._self, this._then);

  final _GrowthChartState _self;
  final $Res Function(_GrowthChartState) _then;

  /// Create a copy of GrowthChartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedAgeRange = null,
    Object? chartData = null,
    Object? childSummary = freezed,
    Object? isLoadingChild = null,
  }) {
    return _then(_GrowthChartState(
      selectedAgeRange: null == selectedAgeRange
          ? _self.selectedAgeRange
          : selectedAgeRange // ignore: cast_nullable_to_non_nullable
              as AgeRange,
      chartData: null == chartData
          ? _self.chartData
          : chartData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<GrowthChartData>,
      childSummary: freezed == childSummary
          ? _self.childSummary
          : childSummary // ignore: cast_nullable_to_non_nullable
              as ChildSummary?,
      isLoadingChild: null == isLoadingChild
          ? _self.isLoadingChild
          : isLoadingChild // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of GrowthChartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChildSummaryCopyWith<$Res>? get childSummary {
    if (_self.childSummary == null) {
      return null;
    }

    return $ChildSummaryCopyWith<$Res>(_self.childSummary!, (value) {
      return _then(_self.copyWith(childSummary: value));
    });
  }
}

// dart format on
