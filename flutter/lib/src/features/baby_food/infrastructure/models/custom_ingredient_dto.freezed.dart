// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_ingredient_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomIngredientDto {
  String get id;
  String get name;
  String get categoryId;
  DateTime get createdAt;

  /// Create a copy of CustomIngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomIngredientDtoCopyWith<CustomIngredientDto> get copyWith =>
      _$CustomIngredientDtoCopyWithImpl<CustomIngredientDto>(
          this as CustomIngredientDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomIngredientDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, categoryId, createdAt);

  @override
  String toString() {
    return 'CustomIngredientDto(id: $id, name: $name, categoryId: $categoryId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $CustomIngredientDtoCopyWith<$Res> {
  factory $CustomIngredientDtoCopyWith(
          CustomIngredientDto value, $Res Function(CustomIngredientDto) _then) =
      _$CustomIngredientDtoCopyWithImpl;
  @useResult
  $Res call({String id, String name, String categoryId, DateTime createdAt});
}

/// @nodoc
class _$CustomIngredientDtoCopyWithImpl<$Res>
    implements $CustomIngredientDtoCopyWith<$Res> {
  _$CustomIngredientDtoCopyWithImpl(this._self, this._then);

  final CustomIngredientDto _self;
  final $Res Function(CustomIngredientDto) _then;

  /// Create a copy of CustomIngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryId = null,
    Object? createdAt = null,
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
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomIngredientDto].
extension CustomIngredientDtoPatterns on CustomIngredientDto {
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
    TResult Function(_CustomIngredientDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomIngredientDto() when $default != null:
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
    TResult Function(_CustomIngredientDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredientDto():
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
    TResult? Function(_CustomIngredientDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredientDto() when $default != null:
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
            String id, String name, String categoryId, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomIngredientDto() when $default != null:
        return $default(
            _that.id, _that.name, _that.categoryId, _that.createdAt);
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
            String id, String name, String categoryId, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredientDto():
        return $default(
            _that.id, _that.name, _that.categoryId, _that.createdAt);
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
            String id, String name, String categoryId, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredientDto() when $default != null:
        return $default(
            _that.id, _that.name, _that.categoryId, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CustomIngredientDto extends CustomIngredientDto {
  const _CustomIngredientDto(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.createdAt})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String categoryId;
  @override
  final DateTime createdAt;

  /// Create a copy of CustomIngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomIngredientDtoCopyWith<_CustomIngredientDto> get copyWith =>
      __$CustomIngredientDtoCopyWithImpl<_CustomIngredientDto>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomIngredientDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, categoryId, createdAt);

  @override
  String toString() {
    return 'CustomIngredientDto(id: $id, name: $name, categoryId: $categoryId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$CustomIngredientDtoCopyWith<$Res>
    implements $CustomIngredientDtoCopyWith<$Res> {
  factory _$CustomIngredientDtoCopyWith(_CustomIngredientDto value,
          $Res Function(_CustomIngredientDto) _then) =
      __$CustomIngredientDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String categoryId, DateTime createdAt});
}

/// @nodoc
class __$CustomIngredientDtoCopyWithImpl<$Res>
    implements _$CustomIngredientDtoCopyWith<$Res> {
  __$CustomIngredientDtoCopyWithImpl(this._self, this._then);

  final _CustomIngredientDto _self;
  final $Res Function(_CustomIngredientDto) _then;

  /// Create a copy of CustomIngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryId = null,
    Object? createdAt = null,
  }) {
    return _then(_CustomIngredientDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
