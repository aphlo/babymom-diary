// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby_food_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BabyFoodDraft {
  /// 既存レコードのID（新規作成の場合はnull）
  String? get existingId;

  /// 記録日時
  DateTime get recordedAt;

  /// 選択された食材リスト
  List<BabyFoodItemDraft> get items;

  /// メモ
  String? get note;

  /// Create a copy of BabyFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodDraftCopyWith<BabyFoodDraft> get copyWith =>
      _$BabyFoodDraftCopyWithImpl<BabyFoodDraft>(
          this as BabyFoodDraft, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodDraft &&
            (identical(other.existingId, existingId) ||
                other.existingId == existingId) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, existingId, recordedAt,
      const DeepCollectionEquality().hash(items), note);

  @override
  String toString() {
    return 'BabyFoodDraft(existingId: $existingId, recordedAt: $recordedAt, items: $items, note: $note)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodDraftCopyWith<$Res> {
  factory $BabyFoodDraftCopyWith(
          BabyFoodDraft value, $Res Function(BabyFoodDraft) _then) =
      _$BabyFoodDraftCopyWithImpl;
  @useResult
  $Res call(
      {String? existingId,
      DateTime recordedAt,
      List<BabyFoodItemDraft> items,
      String? note});
}

/// @nodoc
class _$BabyFoodDraftCopyWithImpl<$Res>
    implements $BabyFoodDraftCopyWith<$Res> {
  _$BabyFoodDraftCopyWithImpl(this._self, this._then);

  final BabyFoodDraft _self;
  final $Res Function(BabyFoodDraft) _then;

  /// Create a copy of BabyFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? existingId = freezed,
    Object? recordedAt = null,
    Object? items = null,
    Object? note = freezed,
  }) {
    return _then(_self.copyWith(
      existingId: freezed == existingId
          ? _self.existingId
          : existingId // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedAt: null == recordedAt
          ? _self.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BabyFoodItemDraft>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BabyFoodDraft].
extension BabyFoodDraftPatterns on BabyFoodDraft {
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
    TResult Function(_BabyFoodDraft value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodDraft() when $default != null:
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
    TResult Function(_BabyFoodDraft value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodDraft():
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
    TResult? Function(_BabyFoodDraft value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodDraft() when $default != null:
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
    TResult Function(String? existingId, DateTime recordedAt,
            List<BabyFoodItemDraft> items, String? note)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodDraft() when $default != null:
        return $default(
            _that.existingId, _that.recordedAt, _that.items, _that.note);
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
    TResult Function(String? existingId, DateTime recordedAt,
            List<BabyFoodItemDraft> items, String? note)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodDraft():
        return $default(
            _that.existingId, _that.recordedAt, _that.items, _that.note);
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
    TResult? Function(String? existingId, DateTime recordedAt,
            List<BabyFoodItemDraft> items, String? note)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodDraft() when $default != null:
        return $default(
            _that.existingId, _that.recordedAt, _that.items, _that.note);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BabyFoodDraft extends BabyFoodDraft {
  const _BabyFoodDraft(
      {this.existingId,
      required this.recordedAt,
      required final List<BabyFoodItemDraft> items,
      this.note})
      : _items = items,
        super._();

  /// 既存レコードのID（新規作成の場合はnull）
  @override
  final String? existingId;

  /// 記録日時
  @override
  final DateTime recordedAt;

  /// 選択された食材リスト
  final List<BabyFoodItemDraft> _items;

  /// 選択された食材リスト
  @override
  List<BabyFoodItemDraft> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// メモ
  @override
  final String? note;

  /// Create a copy of BabyFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodDraftCopyWith<_BabyFoodDraft> get copyWith =>
      __$BabyFoodDraftCopyWithImpl<_BabyFoodDraft>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodDraft &&
            (identical(other.existingId, existingId) ||
                other.existingId == existingId) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, existingId, recordedAt,
      const DeepCollectionEquality().hash(_items), note);

  @override
  String toString() {
    return 'BabyFoodDraft(existingId: $existingId, recordedAt: $recordedAt, items: $items, note: $note)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodDraftCopyWith<$Res>
    implements $BabyFoodDraftCopyWith<$Res> {
  factory _$BabyFoodDraftCopyWith(
          _BabyFoodDraft value, $Res Function(_BabyFoodDraft) _then) =
      __$BabyFoodDraftCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? existingId,
      DateTime recordedAt,
      List<BabyFoodItemDraft> items,
      String? note});
}

/// @nodoc
class __$BabyFoodDraftCopyWithImpl<$Res>
    implements _$BabyFoodDraftCopyWith<$Res> {
  __$BabyFoodDraftCopyWithImpl(this._self, this._then);

  final _BabyFoodDraft _self;
  final $Res Function(_BabyFoodDraft) _then;

  /// Create a copy of BabyFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? existingId = freezed,
    Object? recordedAt = null,
    Object? items = null,
    Object? note = freezed,
  }) {
    return _then(_BabyFoodDraft(
      existingId: freezed == existingId
          ? _self.existingId
          : existingId // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedAt: null == recordedAt
          ? _self.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BabyFoodItemDraft>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$BabyFoodItemDraft {
  String get ingredientId;
  String get ingredientName;
  FoodCategory get category;
  double? get amount;
  AmountUnit? get unit;
  BabyFoodReaction? get reaction;
  bool? get hasAllergy;
  String? get memo;

  /// Create a copy of BabyFoodItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodItemDraftCopyWith<BabyFoodItemDraft> get copyWith =>
      _$BabyFoodItemDraftCopyWithImpl<BabyFoodItemDraft>(
          this as BabyFoodItemDraft, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodItemDraft &&
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
    return 'BabyFoodItemDraft(ingredientId: $ingredientId, ingredientName: $ingredientName, category: $category, amount: $amount, unit: $unit, reaction: $reaction, hasAllergy: $hasAllergy, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodItemDraftCopyWith<$Res> {
  factory $BabyFoodItemDraftCopyWith(
          BabyFoodItemDraft value, $Res Function(BabyFoodItemDraft) _then) =
      _$BabyFoodItemDraftCopyWithImpl;
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
class _$BabyFoodItemDraftCopyWithImpl<$Res>
    implements $BabyFoodItemDraftCopyWith<$Res> {
  _$BabyFoodItemDraftCopyWithImpl(this._self, this._then);

  final BabyFoodItemDraft _self;
  final $Res Function(BabyFoodItemDraft) _then;

  /// Create a copy of BabyFoodItemDraft
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

/// Adds pattern-matching-related methods to [BabyFoodItemDraft].
extension BabyFoodItemDraftPatterns on BabyFoodItemDraft {
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
    TResult Function(_BabyFoodItemDraft value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDraft() when $default != null:
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
    TResult Function(_BabyFoodItemDraft value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDraft():
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
    TResult? Function(_BabyFoodItemDraft value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDraft() when $default != null:
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
      case _BabyFoodItemDraft() when $default != null:
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
      case _BabyFoodItemDraft():
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
      case _BabyFoodItemDraft() when $default != null:
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

class _BabyFoodItemDraft extends BabyFoodItemDraft {
  const _BabyFoodItemDraft(
      {required this.ingredientId,
      required this.ingredientName,
      required this.category,
      this.amount,
      this.unit,
      this.reaction,
      this.hasAllergy,
      this.memo})
      : super._();

  @override
  final String ingredientId;
  @override
  final String ingredientName;
  @override
  final FoodCategory category;
  @override
  final double? amount;
  @override
  final AmountUnit? unit;
  @override
  final BabyFoodReaction? reaction;
  @override
  final bool? hasAllergy;
  @override
  final String? memo;

  /// Create a copy of BabyFoodItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodItemDraftCopyWith<_BabyFoodItemDraft> get copyWith =>
      __$BabyFoodItemDraftCopyWithImpl<_BabyFoodItemDraft>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodItemDraft &&
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
    return 'BabyFoodItemDraft(ingredientId: $ingredientId, ingredientName: $ingredientName, category: $category, amount: $amount, unit: $unit, reaction: $reaction, hasAllergy: $hasAllergy, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodItemDraftCopyWith<$Res>
    implements $BabyFoodItemDraftCopyWith<$Res> {
  factory _$BabyFoodItemDraftCopyWith(
          _BabyFoodItemDraft value, $Res Function(_BabyFoodItemDraft) _then) =
      __$BabyFoodItemDraftCopyWithImpl;
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
class __$BabyFoodItemDraftCopyWithImpl<$Res>
    implements _$BabyFoodItemDraftCopyWith<$Res> {
  __$BabyFoodItemDraftCopyWithImpl(this._self, this._then);

  final _BabyFoodItemDraft _self;
  final $Res Function(_BabyFoodItemDraft) _then;

  /// Create a copy of BabyFoodItemDraft
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
    return _then(_BabyFoodItemDraft(
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
