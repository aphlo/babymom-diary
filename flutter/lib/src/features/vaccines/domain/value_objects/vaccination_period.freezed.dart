// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccination_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccinationPeriod {
  String get id;
  String get label;
  int get order;

  /// Create a copy of VaccinationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccinationPeriodCopyWith<VaccinationPeriod> get copyWith =>
      _$VaccinationPeriodCopyWithImpl<VaccinationPeriod>(
          this as VaccinationPeriod, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccinationPeriod &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, label, order);

  @override
  String toString() {
    return 'VaccinationPeriod(id: $id, label: $label, order: $order)';
  }
}

/// @nodoc
abstract mixin class $VaccinationPeriodCopyWith<$Res> {
  factory $VaccinationPeriodCopyWith(
          VaccinationPeriod value, $Res Function(VaccinationPeriod) _then) =
      _$VaccinationPeriodCopyWithImpl;
  @useResult
  $Res call({String id, String label, int order});
}

/// @nodoc
class _$VaccinationPeriodCopyWithImpl<$Res>
    implements $VaccinationPeriodCopyWith<$Res> {
  _$VaccinationPeriodCopyWithImpl(this._self, this._then);

  final VaccinationPeriod _self;
  final $Res Function(VaccinationPeriod) _then;

  /// Create a copy of VaccinationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? order = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccinationPeriod].
extension VaccinationPeriodPatterns on VaccinationPeriod {
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
    TResult Function(_VaccinationPeriod value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccinationPeriod() when $default != null:
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
    TResult Function(_VaccinationPeriod value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationPeriod():
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
    TResult? Function(_VaccinationPeriod value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationPeriod() when $default != null:
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
    TResult Function(String id, String label, int order)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccinationPeriod() when $default != null:
        return $default(_that.id, _that.label, _that.order);
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
    TResult Function(String id, String label, int order) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationPeriod():
        return $default(_that.id, _that.label, _that.order);
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
    TResult? Function(String id, String label, int order)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationPeriod() when $default != null:
        return $default(_that.id, _that.label, _that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccinationPeriod implements VaccinationPeriod {
  const _VaccinationPeriod(
      {required this.id, required this.label, required this.order});

  @override
  final String id;
  @override
  final String label;
  @override
  final int order;

  /// Create a copy of VaccinationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccinationPeriodCopyWith<_VaccinationPeriod> get copyWith =>
      __$VaccinationPeriodCopyWithImpl<_VaccinationPeriod>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccinationPeriod &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, label, order);

  @override
  String toString() {
    return 'VaccinationPeriod(id: $id, label: $label, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$VaccinationPeriodCopyWith<$Res>
    implements $VaccinationPeriodCopyWith<$Res> {
  factory _$VaccinationPeriodCopyWith(
          _VaccinationPeriod value, $Res Function(_VaccinationPeriod) _then) =
      __$VaccinationPeriodCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String label, int order});
}

/// @nodoc
class __$VaccinationPeriodCopyWithImpl<$Res>
    implements _$VaccinationPeriodCopyWith<$Res> {
  __$VaccinationPeriodCopyWithImpl(this._self, this._then);

  final _VaccinationPeriod _self;
  final $Res Function(_VaccinationPeriod) _then;

  /// Create a copy of VaccinationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? order = null,
  }) {
    return _then(_VaccinationPeriod(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
