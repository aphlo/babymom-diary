// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_summary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklySummaryState {
  DateTime get weekStart;

  /// Create a copy of WeeklySummaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeeklySummaryStateCopyWith<WeeklySummaryState> get copyWith =>
      _$WeeklySummaryStateCopyWithImpl<WeeklySummaryState>(
          this as WeeklySummaryState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeeklySummaryState &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, weekStart);

  @override
  String toString() {
    return 'WeeklySummaryState(weekStart: $weekStart)';
  }
}

/// @nodoc
abstract mixin class $WeeklySummaryStateCopyWith<$Res> {
  factory $WeeklySummaryStateCopyWith(
          WeeklySummaryState value, $Res Function(WeeklySummaryState) _then) =
      _$WeeklySummaryStateCopyWithImpl;
  @useResult
  $Res call({DateTime weekStart});
}

/// @nodoc
class _$WeeklySummaryStateCopyWithImpl<$Res>
    implements $WeeklySummaryStateCopyWith<$Res> {
  _$WeeklySummaryStateCopyWithImpl(this._self, this._then);

  final WeeklySummaryState _self;
  final $Res Function(WeeklySummaryState) _then;

  /// Create a copy of WeeklySummaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekStart = null,
  }) {
    return _then(_self.copyWith(
      weekStart: null == weekStart
          ? _self.weekStart
          : weekStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [WeeklySummaryState].
extension WeeklySummaryStatePatterns on WeeklySummaryState {
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
    TResult Function(_WeeklySummaryState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeeklySummaryState() when $default != null:
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
    TResult Function(_WeeklySummaryState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklySummaryState():
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
    TResult? Function(_WeeklySummaryState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklySummaryState() when $default != null:
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
    TResult Function(DateTime weekStart)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeeklySummaryState() when $default != null:
        return $default(_that.weekStart);
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
    TResult Function(DateTime weekStart) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklySummaryState():
        return $default(_that.weekStart);
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
    TResult? Function(DateTime weekStart)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeeklySummaryState() when $default != null:
        return $default(_that.weekStart);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WeeklySummaryState extends WeeklySummaryState {
  const _WeeklySummaryState({required this.weekStart}) : super._();

  @override
  final DateTime weekStart;

  /// Create a copy of WeeklySummaryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeeklySummaryStateCopyWith<_WeeklySummaryState> get copyWith =>
      __$WeeklySummaryStateCopyWithImpl<_WeeklySummaryState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeeklySummaryState &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, weekStart);

  @override
  String toString() {
    return 'WeeklySummaryState(weekStart: $weekStart)';
  }
}

/// @nodoc
abstract mixin class _$WeeklySummaryStateCopyWith<$Res>
    implements $WeeklySummaryStateCopyWith<$Res> {
  factory _$WeeklySummaryStateCopyWith(
          _WeeklySummaryState value, $Res Function(_WeeklySummaryState) _then) =
      __$WeeklySummaryStateCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime weekStart});
}

/// @nodoc
class __$WeeklySummaryStateCopyWithImpl<$Res>
    implements _$WeeklySummaryStateCopyWith<$Res> {
  __$WeeklySummaryStateCopyWithImpl(this._self, this._then);

  final _WeeklySummaryState _self;
  final $Res Function(_WeeklySummaryState) _then;

  /// Create a copy of WeeklySummaryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weekStart = null,
  }) {
    return _then(_WeeklySummaryState(
      weekStart: null == weekStart
          ? _self.weekStart
          : weekStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
