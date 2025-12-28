// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_ingredient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomIngredient {
  /// カスタム食材のID（UUID）
  String get id;

  /// 食材名
  String get name;

  /// 所属カテゴリ
  FoodCategory get category;

  /// 作成日時
  DateTime get createdAt;

  /// Create a copy of CustomIngredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomIngredientCopyWith<CustomIngredient> get copyWith =>
      _$CustomIngredientCopyWithImpl<CustomIngredient>(
          this as CustomIngredient, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomIngredient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, category, createdAt);

  @override
  String toString() {
    return 'CustomIngredient(id: $id, name: $name, category: $category, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $CustomIngredientCopyWith<$Res> {
  factory $CustomIngredientCopyWith(
          CustomIngredient value, $Res Function(CustomIngredient) _then) =
      _$CustomIngredientCopyWithImpl;
  @useResult
  $Res call(
      {String id, String name, FoodCategory category, DateTime createdAt});
}

/// @nodoc
class _$CustomIngredientCopyWithImpl<$Res>
    implements $CustomIngredientCopyWith<$Res> {
  _$CustomIngredientCopyWithImpl(this._self, this._then);

  final CustomIngredient _self;
  final $Res Function(CustomIngredient) _then;

  /// Create a copy of CustomIngredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
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
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as FoodCategory,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomIngredient].
extension CustomIngredientPatterns on CustomIngredient {
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
    TResult Function(_CustomIngredient value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomIngredient() when $default != null:
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
    TResult Function(_CustomIngredient value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredient():
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
    TResult? Function(_CustomIngredient value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredient() when $default != null:
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
            String id, String name, FoodCategory category, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomIngredient() when $default != null:
        return $default(_that.id, _that.name, _that.category, _that.createdAt);
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
            String id, String name, FoodCategory category, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredient():
        return $default(_that.id, _that.name, _that.category, _that.createdAt);
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
            String id, String name, FoodCategory category, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomIngredient() when $default != null:
        return $default(_that.id, _that.name, _that.category, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CustomIngredient extends CustomIngredient {
  const _CustomIngredient(
      {required this.id,
      required this.name,
      required this.category,
      required this.createdAt})
      : super._();

  /// カスタム食材のID（UUID）
  @override
  final String id;

  /// 食材名
  @override
  final String name;

  /// 所属カテゴリ
  @override
  final FoodCategory category;

  /// 作成日時
  @override
  final DateTime createdAt;

  /// Create a copy of CustomIngredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomIngredientCopyWith<_CustomIngredient> get copyWith =>
      __$CustomIngredientCopyWithImpl<_CustomIngredient>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomIngredient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, category, createdAt);

  @override
  String toString() {
    return 'CustomIngredient(id: $id, name: $name, category: $category, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$CustomIngredientCopyWith<$Res>
    implements $CustomIngredientCopyWith<$Res> {
  factory _$CustomIngredientCopyWith(
          _CustomIngredient value, $Res Function(_CustomIngredient) _then) =
      __$CustomIngredientCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String name, FoodCategory category, DateTime createdAt});
}

/// @nodoc
class __$CustomIngredientCopyWithImpl<$Res>
    implements _$CustomIngredientCopyWith<$Res> {
  __$CustomIngredientCopyWithImpl(this._self, this._then);

  final _CustomIngredient _self;
  final $Res Function(_CustomIngredient) _then;

  /// Create a copy of CustomIngredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? createdAt = null,
  }) {
    return _then(_CustomIngredient(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as FoodCategory,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
