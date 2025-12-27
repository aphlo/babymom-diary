// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildSummary {
  String get id;
  String get name;
  DateTime get birthday;
  DateTime? get dueDate;
  Gender get gender;
  ChildIcon get icon;

  /// Create a copy of ChildSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChildSummaryCopyWith<ChildSummary> get copyWith =>
      _$ChildSummaryCopyWithImpl<ChildSummary>(
          this as ChildSummary, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChildSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, birthday, dueDate, gender, icon);

  @override
  String toString() {
    return 'ChildSummary(id: $id, name: $name, birthday: $birthday, dueDate: $dueDate, gender: $gender, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class $ChildSummaryCopyWith<$Res> {
  factory $ChildSummaryCopyWith(
          ChildSummary value, $Res Function(ChildSummary) _then) =
      _$ChildSummaryCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime birthday,
      DateTime? dueDate,
      Gender gender,
      ChildIcon icon});
}

/// @nodoc
class _$ChildSummaryCopyWithImpl<$Res> implements $ChildSummaryCopyWith<$Res> {
  _$ChildSummaryCopyWithImpl(this._self, this._then);

  final ChildSummary _self;
  final $Res Function(ChildSummary) _then;

  /// Create a copy of ChildSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? birthday = null,
    Object? dueDate = freezed,
    Object? gender = null,
    Object? icon = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as ChildIcon,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChildSummary].
extension ChildSummaryPatterns on ChildSummary {
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
    TResult Function(_ChildSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChildSummary() when $default != null:
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
    TResult Function(_ChildSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChildSummary():
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
    TResult? Function(_ChildSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChildSummary() when $default != null:
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
    TResult Function(String id, String name, DateTime birthday,
            DateTime? dueDate, Gender gender, ChildIcon icon)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChildSummary() when $default != null:
        return $default(_that.id, _that.name, _that.birthday, _that.dueDate,
            _that.gender, _that.icon);
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
    TResult Function(String id, String name, DateTime birthday,
            DateTime? dueDate, Gender gender, ChildIcon icon)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChildSummary():
        return $default(_that.id, _that.name, _that.birthday, _that.dueDate,
            _that.gender, _that.icon);
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
    TResult? Function(String id, String name, DateTime birthday,
            DateTime? dueDate, Gender gender, ChildIcon icon)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChildSummary() when $default != null:
        return $default(_that.id, _that.name, _that.birthday, _that.dueDate,
            _that.gender, _that.icon);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ChildSummary extends ChildSummary {
  const _ChildSummary(
      {required this.id,
      required this.name,
      required this.birthday,
      this.dueDate,
      required this.gender,
      required this.icon})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime birthday;
  @override
  final DateTime? dueDate;
  @override
  final Gender gender;
  @override
  final ChildIcon icon;

  /// Create a copy of ChildSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChildSummaryCopyWith<_ChildSummary> get copyWith =>
      __$ChildSummaryCopyWithImpl<_ChildSummary>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChildSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, birthday, dueDate, gender, icon);

  @override
  String toString() {
    return 'ChildSummary(id: $id, name: $name, birthday: $birthday, dueDate: $dueDate, gender: $gender, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class _$ChildSummaryCopyWith<$Res>
    implements $ChildSummaryCopyWith<$Res> {
  factory _$ChildSummaryCopyWith(
          _ChildSummary value, $Res Function(_ChildSummary) _then) =
      __$ChildSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime birthday,
      DateTime? dueDate,
      Gender gender,
      ChildIcon icon});
}

/// @nodoc
class __$ChildSummaryCopyWithImpl<$Res>
    implements _$ChildSummaryCopyWith<$Res> {
  __$ChildSummaryCopyWithImpl(this._self, this._then);

  final _ChildSummary _self;
  final $Res Function(_ChildSummary) _then;

  /// Create a copy of ChildSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? birthday = null,
    Object? dueDate = freezed,
    Object? gender = null,
    Object? icon = null,
  }) {
    return _then(_ChildSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as ChildIcon,
    ));
  }
}

// dart format on
