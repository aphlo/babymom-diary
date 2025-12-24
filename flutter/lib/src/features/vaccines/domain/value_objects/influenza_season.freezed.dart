// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'influenza_season.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InfluenzaSeasonDefinition {
  int get index;
  String get periodId;
  int get firstDoseNumber;
  int get secondDoseNumber;

  /// Create a copy of InfluenzaSeasonDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InfluenzaSeasonDefinitionCopyWith<InfluenzaSeasonDefinition> get copyWith =>
      _$InfluenzaSeasonDefinitionCopyWithImpl<InfluenzaSeasonDefinition>(
          this as InfluenzaSeasonDefinition, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InfluenzaSeasonDefinition &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.periodId, periodId) ||
                other.periodId == periodId) &&
            (identical(other.firstDoseNumber, firstDoseNumber) ||
                other.firstDoseNumber == firstDoseNumber) &&
            (identical(other.secondDoseNumber, secondDoseNumber) ||
                other.secondDoseNumber == secondDoseNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, index, periodId, firstDoseNumber, secondDoseNumber);

  @override
  String toString() {
    return 'InfluenzaSeasonDefinition(index: $index, periodId: $periodId, firstDoseNumber: $firstDoseNumber, secondDoseNumber: $secondDoseNumber)';
  }
}

/// @nodoc
abstract mixin class $InfluenzaSeasonDefinitionCopyWith<$Res> {
  factory $InfluenzaSeasonDefinitionCopyWith(InfluenzaSeasonDefinition value,
          $Res Function(InfluenzaSeasonDefinition) _then) =
      _$InfluenzaSeasonDefinitionCopyWithImpl;
  @useResult
  $Res call(
      {int index, String periodId, int firstDoseNumber, int secondDoseNumber});
}

/// @nodoc
class _$InfluenzaSeasonDefinitionCopyWithImpl<$Res>
    implements $InfluenzaSeasonDefinitionCopyWith<$Res> {
  _$InfluenzaSeasonDefinitionCopyWithImpl(this._self, this._then);

  final InfluenzaSeasonDefinition _self;
  final $Res Function(InfluenzaSeasonDefinition) _then;

  /// Create a copy of InfluenzaSeasonDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? periodId = null,
    Object? firstDoseNumber = null,
    Object? secondDoseNumber = null,
  }) {
    return _then(_self.copyWith(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      periodId: null == periodId
          ? _self.periodId
          : periodId // ignore: cast_nullable_to_non_nullable
              as String,
      firstDoseNumber: null == firstDoseNumber
          ? _self.firstDoseNumber
          : firstDoseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      secondDoseNumber: null == secondDoseNumber
          ? _self.secondDoseNumber
          : secondDoseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [InfluenzaSeasonDefinition].
extension InfluenzaSeasonDefinitionPatterns on InfluenzaSeasonDefinition {
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
    TResult Function(_InfluenzaSeasonDefinition value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonDefinition() when $default != null:
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
    TResult Function(_InfluenzaSeasonDefinition value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonDefinition():
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
    TResult? Function(_InfluenzaSeasonDefinition value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonDefinition() when $default != null:
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
    TResult Function(int index, String periodId, int firstDoseNumber,
            int secondDoseNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonDefinition() when $default != null:
        return $default(_that.index, _that.periodId, _that.firstDoseNumber,
            _that.secondDoseNumber);
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
    TResult Function(int index, String periodId, int firstDoseNumber,
            int secondDoseNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonDefinition():
        return $default(_that.index, _that.periodId, _that.firstDoseNumber,
            _that.secondDoseNumber);
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
    TResult? Function(int index, String periodId, int firstDoseNumber,
            int secondDoseNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonDefinition() when $default != null:
        return $default(_that.index, _that.periodId, _that.firstDoseNumber,
            _that.secondDoseNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _InfluenzaSeasonDefinition extends InfluenzaSeasonDefinition {
  const _InfluenzaSeasonDefinition(
      {required this.index,
      required this.periodId,
      required this.firstDoseNumber,
      required this.secondDoseNumber})
      : super._();

  @override
  final int index;
  @override
  final String periodId;
  @override
  final int firstDoseNumber;
  @override
  final int secondDoseNumber;

  /// Create a copy of InfluenzaSeasonDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InfluenzaSeasonDefinitionCopyWith<_InfluenzaSeasonDefinition>
      get copyWith =>
          __$InfluenzaSeasonDefinitionCopyWithImpl<_InfluenzaSeasonDefinition>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InfluenzaSeasonDefinition &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.periodId, periodId) ||
                other.periodId == periodId) &&
            (identical(other.firstDoseNumber, firstDoseNumber) ||
                other.firstDoseNumber == firstDoseNumber) &&
            (identical(other.secondDoseNumber, secondDoseNumber) ||
                other.secondDoseNumber == secondDoseNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, index, periodId, firstDoseNumber, secondDoseNumber);

  @override
  String toString() {
    return 'InfluenzaSeasonDefinition(index: $index, periodId: $periodId, firstDoseNumber: $firstDoseNumber, secondDoseNumber: $secondDoseNumber)';
  }
}

/// @nodoc
abstract mixin class _$InfluenzaSeasonDefinitionCopyWith<$Res>
    implements $InfluenzaSeasonDefinitionCopyWith<$Res> {
  factory _$InfluenzaSeasonDefinitionCopyWith(_InfluenzaSeasonDefinition value,
          $Res Function(_InfluenzaSeasonDefinition) _then) =
      __$InfluenzaSeasonDefinitionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int index, String periodId, int firstDoseNumber, int secondDoseNumber});
}

/// @nodoc
class __$InfluenzaSeasonDefinitionCopyWithImpl<$Res>
    implements _$InfluenzaSeasonDefinitionCopyWith<$Res> {
  __$InfluenzaSeasonDefinitionCopyWithImpl(this._self, this._then);

  final _InfluenzaSeasonDefinition _self;
  final $Res Function(_InfluenzaSeasonDefinition) _then;

  /// Create a copy of InfluenzaSeasonDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
    Object? periodId = null,
    Object? firstDoseNumber = null,
    Object? secondDoseNumber = null,
  }) {
    return _then(_InfluenzaSeasonDefinition(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      periodId: null == periodId
          ? _self.periodId
          : periodId // ignore: cast_nullable_to_non_nullable
              as String,
      firstDoseNumber: null == firstDoseNumber
          ? _self.firstDoseNumber
          : firstDoseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      secondDoseNumber: null == secondDoseNumber
          ? _self.secondDoseNumber
          : secondDoseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$InfluenzaSeasonSchedule {
  InfluenzaSeasonDefinition get definition;
  DateTime? get seasonStart;

  /// Create a copy of InfluenzaSeasonSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InfluenzaSeasonScheduleCopyWith<InfluenzaSeasonSchedule> get copyWith =>
      _$InfluenzaSeasonScheduleCopyWithImpl<InfluenzaSeasonSchedule>(
          this as InfluenzaSeasonSchedule, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InfluenzaSeasonSchedule &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.seasonStart, seasonStart) ||
                other.seasonStart == seasonStart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, definition, seasonStart);

  @override
  String toString() {
    return 'InfluenzaSeasonSchedule(definition: $definition, seasonStart: $seasonStart)';
  }
}

/// @nodoc
abstract mixin class $InfluenzaSeasonScheduleCopyWith<$Res> {
  factory $InfluenzaSeasonScheduleCopyWith(InfluenzaSeasonSchedule value,
          $Res Function(InfluenzaSeasonSchedule) _then) =
      _$InfluenzaSeasonScheduleCopyWithImpl;
  @useResult
  $Res call({InfluenzaSeasonDefinition definition, DateTime? seasonStart});

  $InfluenzaSeasonDefinitionCopyWith<$Res> get definition;
}

/// @nodoc
class _$InfluenzaSeasonScheduleCopyWithImpl<$Res>
    implements $InfluenzaSeasonScheduleCopyWith<$Res> {
  _$InfluenzaSeasonScheduleCopyWithImpl(this._self, this._then);

  final InfluenzaSeasonSchedule _self;
  final $Res Function(InfluenzaSeasonSchedule) _then;

  /// Create a copy of InfluenzaSeasonSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? definition = null,
    Object? seasonStart = freezed,
  }) {
    return _then(_self.copyWith(
      definition: null == definition
          ? _self.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as InfluenzaSeasonDefinition,
      seasonStart: freezed == seasonStart
          ? _self.seasonStart
          : seasonStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of InfluenzaSeasonSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InfluenzaSeasonDefinitionCopyWith<$Res> get definition {
    return $InfluenzaSeasonDefinitionCopyWith<$Res>(_self.definition, (value) {
      return _then(_self.copyWith(definition: value));
    });
  }
}

/// Adds pattern-matching-related methods to [InfluenzaSeasonSchedule].
extension InfluenzaSeasonSchedulePatterns on InfluenzaSeasonSchedule {
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
    TResult Function(_InfluenzaSeasonSchedule value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonSchedule() when $default != null:
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
    TResult Function(_InfluenzaSeasonSchedule value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonSchedule():
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
    TResult? Function(_InfluenzaSeasonSchedule value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonSchedule() when $default != null:
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
            InfluenzaSeasonDefinition definition, DateTime? seasonStart)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonSchedule() when $default != null:
        return $default(_that.definition, _that.seasonStart);
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
            InfluenzaSeasonDefinition definition, DateTime? seasonStart)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonSchedule():
        return $default(_that.definition, _that.seasonStart);
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
            InfluenzaSeasonDefinition definition, DateTime? seasonStart)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InfluenzaSeasonSchedule() when $default != null:
        return $default(_that.definition, _that.seasonStart);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _InfluenzaSeasonSchedule extends InfluenzaSeasonSchedule {
  const _InfluenzaSeasonSchedule({required this.definition, this.seasonStart})
      : super._();

  @override
  final InfluenzaSeasonDefinition definition;
  @override
  final DateTime? seasonStart;

  /// Create a copy of InfluenzaSeasonSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InfluenzaSeasonScheduleCopyWith<_InfluenzaSeasonSchedule> get copyWith =>
      __$InfluenzaSeasonScheduleCopyWithImpl<_InfluenzaSeasonSchedule>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InfluenzaSeasonSchedule &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.seasonStart, seasonStart) ||
                other.seasonStart == seasonStart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, definition, seasonStart);

  @override
  String toString() {
    return 'InfluenzaSeasonSchedule(definition: $definition, seasonStart: $seasonStart)';
  }
}

/// @nodoc
abstract mixin class _$InfluenzaSeasonScheduleCopyWith<$Res>
    implements $InfluenzaSeasonScheduleCopyWith<$Res> {
  factory _$InfluenzaSeasonScheduleCopyWith(_InfluenzaSeasonSchedule value,
          $Res Function(_InfluenzaSeasonSchedule) _then) =
      __$InfluenzaSeasonScheduleCopyWithImpl;
  @override
  @useResult
  $Res call({InfluenzaSeasonDefinition definition, DateTime? seasonStart});

  @override
  $InfluenzaSeasonDefinitionCopyWith<$Res> get definition;
}

/// @nodoc
class __$InfluenzaSeasonScheduleCopyWithImpl<$Res>
    implements _$InfluenzaSeasonScheduleCopyWith<$Res> {
  __$InfluenzaSeasonScheduleCopyWithImpl(this._self, this._then);

  final _InfluenzaSeasonSchedule _self;
  final $Res Function(_InfluenzaSeasonSchedule) _then;

  /// Create a copy of InfluenzaSeasonSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? definition = null,
    Object? seasonStart = freezed,
  }) {
    return _then(_InfluenzaSeasonSchedule(
      definition: null == definition
          ? _self.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as InfluenzaSeasonDefinition,
      seasonStart: freezed == seasonStart
          ? _self.seasonStart
          : seasonStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of InfluenzaSeasonSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InfluenzaSeasonDefinitionCopyWith<$Res> get definition {
    return $InfluenzaSeasonDefinitionCopyWith<$Res>(_self.definition, (value) {
      return _then(_self.copyWith(definition: value));
    });
  }
}

// dart format on
