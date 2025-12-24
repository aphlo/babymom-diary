// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccination_recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccinationRecommendation {
  int get doseNumber;
  RecommendationSource get source;
  DateTime? get startDate;
  DateTime? get endDate;
  List<String> get labels;

  /// Create a copy of VaccinationRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccinationRecommendationCopyWith<VaccinationRecommendation> get copyWith =>
      _$VaccinationRecommendationCopyWithImpl<VaccinationRecommendation>(
          this as VaccinationRecommendation, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccinationRecommendation &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other.labels, labels));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doseNumber, source, startDate,
      endDate, const DeepCollectionEquality().hash(labels));

  @override
  String toString() {
    return 'VaccinationRecommendation(doseNumber: $doseNumber, source: $source, startDate: $startDate, endDate: $endDate, labels: $labels)';
  }
}

/// @nodoc
abstract mixin class $VaccinationRecommendationCopyWith<$Res> {
  factory $VaccinationRecommendationCopyWith(VaccinationRecommendation value,
          $Res Function(VaccinationRecommendation) _then) =
      _$VaccinationRecommendationCopyWithImpl;
  @useResult
  $Res call(
      {int doseNumber,
      RecommendationSource source,
      DateTime? startDate,
      DateTime? endDate,
      List<String> labels});
}

/// @nodoc
class _$VaccinationRecommendationCopyWithImpl<$Res>
    implements $VaccinationRecommendationCopyWith<$Res> {
  _$VaccinationRecommendationCopyWithImpl(this._self, this._then);

  final VaccinationRecommendation _self;
  final $Res Function(VaccinationRecommendation) _then;

  /// Create a copy of VaccinationRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doseNumber = null,
    Object? source = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? labels = null,
  }) {
    return _then(_self.copyWith(
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as RecommendationSource,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      labels: null == labels
          ? _self.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccinationRecommendation].
extension VaccinationRecommendationPatterns on VaccinationRecommendation {
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
    TResult Function(_VaccinationRecommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccinationRecommendation() when $default != null:
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
    TResult Function(_VaccinationRecommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationRecommendation():
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
    TResult? Function(_VaccinationRecommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationRecommendation() when $default != null:
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
    TResult Function(int doseNumber, RecommendationSource source,
            DateTime? startDate, DateTime? endDate, List<String> labels)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccinationRecommendation() when $default != null:
        return $default(_that.doseNumber, _that.source, _that.startDate,
            _that.endDate, _that.labels);
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
    TResult Function(int doseNumber, RecommendationSource source,
            DateTime? startDate, DateTime? endDate, List<String> labels)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationRecommendation():
        return $default(_that.doseNumber, _that.source, _that.startDate,
            _that.endDate, _that.labels);
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
    TResult? Function(int doseNumber, RecommendationSource source,
            DateTime? startDate, DateTime? endDate, List<String> labels)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationRecommendation() when $default != null:
        return $default(_that.doseNumber, _that.source, _that.startDate,
            _that.endDate, _that.labels);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccinationRecommendation implements VaccinationRecommendation {
  const _VaccinationRecommendation(
      {required this.doseNumber,
      required this.source,
      this.startDate,
      this.endDate,
      final List<String> labels = const <String>[]})
      : _labels = labels;

  @override
  final int doseNumber;
  @override
  final RecommendationSource source;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  final List<String> _labels;
  @override
  @JsonKey()
  List<String> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  /// Create a copy of VaccinationRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccinationRecommendationCopyWith<_VaccinationRecommendation>
      get copyWith =>
          __$VaccinationRecommendationCopyWithImpl<_VaccinationRecommendation>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccinationRecommendation &&
            (identical(other.doseNumber, doseNumber) ||
                other.doseNumber == doseNumber) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._labels, _labels));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doseNumber, source, startDate,
      endDate, const DeepCollectionEquality().hash(_labels));

  @override
  String toString() {
    return 'VaccinationRecommendation(doseNumber: $doseNumber, source: $source, startDate: $startDate, endDate: $endDate, labels: $labels)';
  }
}

/// @nodoc
abstract mixin class _$VaccinationRecommendationCopyWith<$Res>
    implements $VaccinationRecommendationCopyWith<$Res> {
  factory _$VaccinationRecommendationCopyWith(_VaccinationRecommendation value,
          $Res Function(_VaccinationRecommendation) _then) =
      __$VaccinationRecommendationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int doseNumber,
      RecommendationSource source,
      DateTime? startDate,
      DateTime? endDate,
      List<String> labels});
}

/// @nodoc
class __$VaccinationRecommendationCopyWithImpl<$Res>
    implements _$VaccinationRecommendationCopyWith<$Res> {
  __$VaccinationRecommendationCopyWithImpl(this._self, this._then);

  final _VaccinationRecommendation _self;
  final $Res Function(_VaccinationRecommendation) _then;

  /// Create a copy of VaccinationRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? doseNumber = null,
    Object? source = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? labels = null,
  }) {
    return _then(_VaccinationRecommendation(
      doseNumber: null == doseNumber
          ? _self.doseNumber
          : doseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as RecommendationSource,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      labels: null == labels
          ? _self._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
