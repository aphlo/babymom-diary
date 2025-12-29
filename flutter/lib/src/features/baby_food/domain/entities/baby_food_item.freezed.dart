// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby_food_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BabyFoodItem {
  /// 食材のID（プリセット食材の場合は食材名、カスタム食材の場合はUUID）
  String get ingredientId;

  /// 食材名
  String get ingredientName;

  /// 食材カテゴリ
  FoodCategory get category;

  /// 食べた量（任意）
  double? get amount;

  /// 量の単位（任意）
  AmountUnit? get unit;

  /// 子供の反応（任意）
  BabyFoodReaction? get reaction;

  /// アレルギー反応があったか（任意）
  bool? get hasAllergy;

  /// メモ（任意、最大100文字）
  String? get memo;

  /// Create a copy of BabyFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodItemCopyWith<BabyFoodItem> get copyWith =>
      _$BabyFoodItemCopyWithImpl<BabyFoodItem>(
          this as BabyFoodItem, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodItem &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.ingredientName, ingredientName) ||
                other.ingredientName == ingredientName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.hasAllergy, hasAllergy) ||
                other.hasAllergy == hasAllergy) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ingredientId, ingredientName,
      category, amount, unit, reaction, hasAllergy, memo);

  @override
  String toString() {
    return 'BabyFoodItem(ingredientId: $ingredientId, ingredientName: $ingredientName, category: $category, amount: $amount, unit: $unit, reaction: $reaction, hasAllergy: $hasAllergy, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodItemCopyWith<$Res> {
  factory $BabyFoodItemCopyWith(
          BabyFoodItem value, $Res Function(BabyFoodItem) _then) =
      _$BabyFoodItemCopyWithImpl;
  @useResult
  $Res call(
      {String ingredientId,
      String ingredientName,
      FoodCategory category,
      double? amount,
      AmountUnit? unit,
      BabyFoodReaction? reaction,
      bool? hasAllergy,
      String? memo});
}

/// @nodoc
class _$BabyFoodItemCopyWithImpl<$Res> implements $BabyFoodItemCopyWith<$Res> {
  _$BabyFoodItemCopyWithImpl(this._self, this._then);

  final BabyFoodItem _self;
  final $Res Function(BabyFoodItem) _then;

  /// Create a copy of BabyFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredientId = null,
    Object? ingredientName = null,
    Object? category = null,
    Object? amount = freezed,
    Object? unit = freezed,
    Object? reaction = freezed,
    Object? hasAllergy = freezed,
    Object? memo = freezed,
  }) {
    return _then(_self.copyWith(
      ingredientId: null == ingredientId
          ? _self.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as String,
      ingredientName: null == ingredientName
          ? _self.ingredientName
          : ingredientName // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as FoodCategory,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as AmountUnit?,
      reaction: freezed == reaction
          ? _self.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as BabyFoodReaction?,
      hasAllergy: freezed == hasAllergy
          ? _self.hasAllergy
          : hasAllergy // ignore: cast_nullable_to_non_nullable
              as bool?,
      memo: freezed == memo
          ? _self.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BabyFoodItem].
extension BabyFoodItemPatterns on BabyFoodItem {
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
    TResult Function(_BabyFoodItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItem() when $default != null:
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
    TResult Function(_BabyFoodItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItem():
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
    TResult? Function(_BabyFoodItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItem() when $default != null:
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
            String ingredientId,
            String ingredientName,
            FoodCategory category,
            double? amount,
            AmountUnit? unit,
            BabyFoodReaction? reaction,
            bool? hasAllergy,
            String? memo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItem() when $default != null:
        return $default(
            _that.ingredientId,
            _that.ingredientName,
            _that.category,
            _that.amount,
            _that.unit,
            _that.reaction,
            _that.hasAllergy,
            _that.memo);
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
            String ingredientId,
            String ingredientName,
            FoodCategory category,
            double? amount,
            AmountUnit? unit,
            BabyFoodReaction? reaction,
            bool? hasAllergy,
            String? memo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItem():
        return $default(
            _that.ingredientId,
            _that.ingredientName,
            _that.category,
            _that.amount,
            _that.unit,
            _that.reaction,
            _that.hasAllergy,
            _that.memo);
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
            String ingredientId,
            String ingredientName,
            FoodCategory category,
            double? amount,
            AmountUnit? unit,
            BabyFoodReaction? reaction,
            bool? hasAllergy,
            String? memo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItem() when $default != null:
        return $default(
            _that.ingredientId,
            _that.ingredientName,
            _that.category,
            _that.amount,
            _that.unit,
            _that.reaction,
            _that.hasAllergy,
            _that.memo);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BabyFoodItem extends BabyFoodItem {
  const _BabyFoodItem(
      {required this.ingredientId,
      required this.ingredientName,
      required this.category,
      this.amount,
      this.unit,
      this.reaction,
      this.hasAllergy,
      this.memo})
      : super._();

  /// 食材のID（プリセット食材の場合は食材名、カスタム食材の場合はUUID）
  @override
  final String ingredientId;

  /// 食材名
  @override
  final String ingredientName;

  /// 食材カテゴリ
  @override
  final FoodCategory category;

  /// 食べた量（任意）
  @override
  final double? amount;

  /// 量の単位（任意）
  @override
  final AmountUnit? unit;

  /// 子供の反応（任意）
  @override
  final BabyFoodReaction? reaction;

  /// アレルギー反応があったか（任意）
  @override
  final bool? hasAllergy;

  /// メモ（任意、最大100文字）
  @override
  final String? memo;

  /// Create a copy of BabyFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodItemCopyWith<_BabyFoodItem> get copyWith =>
      __$BabyFoodItemCopyWithImpl<_BabyFoodItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodItem &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.ingredientName, ingredientName) ||
                other.ingredientName == ingredientName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.hasAllergy, hasAllergy) ||
                other.hasAllergy == hasAllergy) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ingredientId, ingredientName,
      category, amount, unit, reaction, hasAllergy, memo);

  @override
  String toString() {
    return 'BabyFoodItem(ingredientId: $ingredientId, ingredientName: $ingredientName, category: $category, amount: $amount, unit: $unit, reaction: $reaction, hasAllergy: $hasAllergy, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodItemCopyWith<$Res>
    implements $BabyFoodItemCopyWith<$Res> {
  factory _$BabyFoodItemCopyWith(
          _BabyFoodItem value, $Res Function(_BabyFoodItem) _then) =
      __$BabyFoodItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String ingredientId,
      String ingredientName,
      FoodCategory category,
      double? amount,
      AmountUnit? unit,
      BabyFoodReaction? reaction,
      bool? hasAllergy,
      String? memo});
}

/// @nodoc
class __$BabyFoodItemCopyWithImpl<$Res>
    implements _$BabyFoodItemCopyWith<$Res> {
  __$BabyFoodItemCopyWithImpl(this._self, this._then);

  final _BabyFoodItem _self;
  final $Res Function(_BabyFoodItem) _then;

  /// Create a copy of BabyFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ingredientId = null,
    Object? ingredientName = null,
    Object? category = null,
    Object? amount = freezed,
    Object? unit = freezed,
    Object? reaction = freezed,
    Object? hasAllergy = freezed,
    Object? memo = freezed,
  }) {
    return _then(_BabyFoodItem(
      ingredientId: null == ingredientId
          ? _self.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as String,
      ingredientName: null == ingredientName
          ? _self.ingredientName
          : ingredientName // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as FoodCategory,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as AmountUnit?,
      reaction: freezed == reaction
          ? _self.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as BabyFoodReaction?,
      hasAllergy: freezed == hasAllergy
          ? _self.hasAllergy
          : hasAllergy // ignore: cast_nullable_to_non_nullable
              as bool?,
      memo: freezed == memo
          ? _self.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
