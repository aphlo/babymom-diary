// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby_food_record_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BabyFoodItemDto {
  String get ingredientId;
  String get ingredientName;
  String get categoryId;
  double? get amount;
  String? get unit;
  String? get reaction;
  bool? get hasAllergy;
  String? get memo;

  /// Create a copy of BabyFoodItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodItemDtoCopyWith<BabyFoodItemDto> get copyWith =>
      _$BabyFoodItemDtoCopyWithImpl<BabyFoodItemDto>(
          this as BabyFoodItemDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodItemDto &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.ingredientName, ingredientName) ||
                other.ingredientName == ingredientName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
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
      categoryId, amount, unit, reaction, hasAllergy, memo);

  @override
  String toString() {
    return 'BabyFoodItemDto(ingredientId: $ingredientId, ingredientName: $ingredientName, categoryId: $categoryId, amount: $amount, unit: $unit, reaction: $reaction, hasAllergy: $hasAllergy, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodItemDtoCopyWith<$Res> {
  factory $BabyFoodItemDtoCopyWith(
          BabyFoodItemDto value, $Res Function(BabyFoodItemDto) _then) =
      _$BabyFoodItemDtoCopyWithImpl;
  @useResult
  $Res call(
      {String ingredientId,
      String ingredientName,
      String categoryId,
      double? amount,
      String? unit,
      String? reaction,
      bool? hasAllergy,
      String? memo});
}

/// @nodoc
class _$BabyFoodItemDtoCopyWithImpl<$Res>
    implements $BabyFoodItemDtoCopyWith<$Res> {
  _$BabyFoodItemDtoCopyWithImpl(this._self, this._then);

  final BabyFoodItemDto _self;
  final $Res Function(BabyFoodItemDto) _then;

  /// Create a copy of BabyFoodItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredientId = null,
    Object? ingredientName = null,
    Object? categoryId = null,
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
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      reaction: freezed == reaction
          ? _self.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String?,
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

/// Adds pattern-matching-related methods to [BabyFoodItemDto].
extension BabyFoodItemDtoPatterns on BabyFoodItemDto {
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
    TResult Function(_BabyFoodItemDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDto() when $default != null:
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
    TResult Function(_BabyFoodItemDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDto():
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
    TResult? Function(_BabyFoodItemDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDto() when $default != null:
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
            String categoryId,
            double? amount,
            String? unit,
            String? reaction,
            bool? hasAllergy,
            String? memo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDto() when $default != null:
        return $default(
            _that.ingredientId,
            _that.ingredientName,
            _that.categoryId,
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
            String categoryId,
            double? amount,
            String? unit,
            String? reaction,
            bool? hasAllergy,
            String? memo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDto():
        return $default(
            _that.ingredientId,
            _that.ingredientName,
            _that.categoryId,
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
            String categoryId,
            double? amount,
            String? unit,
            String? reaction,
            bool? hasAllergy,
            String? memo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodItemDto() when $default != null:
        return $default(
            _that.ingredientId,
            _that.ingredientName,
            _that.categoryId,
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

class _BabyFoodItemDto extends BabyFoodItemDto {
  const _BabyFoodItemDto(
      {required this.ingredientId,
      required this.ingredientName,
      required this.categoryId,
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
  final String categoryId;
  @override
  final double? amount;
  @override
  final String? unit;
  @override
  final String? reaction;
  @override
  final bool? hasAllergy;
  @override
  final String? memo;

  /// Create a copy of BabyFoodItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodItemDtoCopyWith<_BabyFoodItemDto> get copyWith =>
      __$BabyFoodItemDtoCopyWithImpl<_BabyFoodItemDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodItemDto &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.ingredientName, ingredientName) ||
                other.ingredientName == ingredientName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
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
      categoryId, amount, unit, reaction, hasAllergy, memo);

  @override
  String toString() {
    return 'BabyFoodItemDto(ingredientId: $ingredientId, ingredientName: $ingredientName, categoryId: $categoryId, amount: $amount, unit: $unit, reaction: $reaction, hasAllergy: $hasAllergy, memo: $memo)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodItemDtoCopyWith<$Res>
    implements $BabyFoodItemDtoCopyWith<$Res> {
  factory _$BabyFoodItemDtoCopyWith(
          _BabyFoodItemDto value, $Res Function(_BabyFoodItemDto) _then) =
      __$BabyFoodItemDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String ingredientId,
      String ingredientName,
      String categoryId,
      double? amount,
      String? unit,
      String? reaction,
      bool? hasAllergy,
      String? memo});
}

/// @nodoc
class __$BabyFoodItemDtoCopyWithImpl<$Res>
    implements _$BabyFoodItemDtoCopyWith<$Res> {
  __$BabyFoodItemDtoCopyWithImpl(this._self, this._then);

  final _BabyFoodItemDto _self;
  final $Res Function(_BabyFoodItemDto) _then;

  /// Create a copy of BabyFoodItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ingredientId = null,
    Object? ingredientName = null,
    Object? categoryId = null,
    Object? amount = freezed,
    Object? unit = freezed,
    Object? reaction = freezed,
    Object? hasAllergy = freezed,
    Object? memo = freezed,
  }) {
    return _then(_BabyFoodItemDto(
      ingredientId: null == ingredientId
          ? _self.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as String,
      ingredientName: null == ingredientName
          ? _self.ingredientName
          : ingredientName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      reaction: freezed == reaction
          ? _self.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String?,
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

/// @nodoc
mixin _$BabyFoodRecordDto {
  String get id;
  DateTime get recordedAt;
  List<BabyFoodItemDto> get items;
  String? get note;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of BabyFoodRecordDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodRecordDtoCopyWith<BabyFoodRecordDto> get copyWith =>
      _$BabyFoodRecordDtoCopyWithImpl<BabyFoodRecordDto>(
          this as BabyFoodRecordDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodRecordDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, recordedAt,
      const DeepCollectionEquality().hash(items), note, createdAt, updatedAt);

  @override
  String toString() {
    return 'BabyFoodRecordDto(id: $id, recordedAt: $recordedAt, items: $items, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodRecordDtoCopyWith<$Res> {
  factory $BabyFoodRecordDtoCopyWith(
          BabyFoodRecordDto value, $Res Function(BabyFoodRecordDto) _then) =
      _$BabyFoodRecordDtoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime recordedAt,
      List<BabyFoodItemDto> items,
      String? note,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$BabyFoodRecordDtoCopyWithImpl<$Res>
    implements $BabyFoodRecordDtoCopyWith<$Res> {
  _$BabyFoodRecordDtoCopyWithImpl(this._self, this._then);

  final BabyFoodRecordDto _self;
  final $Res Function(BabyFoodRecordDto) _then;

  /// Create a copy of BabyFoodRecordDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordedAt = null,
    Object? items = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: null == recordedAt
          ? _self.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BabyFoodItemDto>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [BabyFoodRecordDto].
extension BabyFoodRecordDtoPatterns on BabyFoodRecordDto {
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
    TResult Function(_BabyFoodRecordDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecordDto() when $default != null:
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
    TResult Function(_BabyFoodRecordDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecordDto():
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
    TResult? Function(_BabyFoodRecordDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecordDto() when $default != null:
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
            String id,
            DateTime recordedAt,
            List<BabyFoodItemDto> items,
            String? note,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecordDto() when $default != null:
        return $default(_that.id, _that.recordedAt, _that.items, _that.note,
            _that.createdAt, _that.updatedAt);
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
            String id,
            DateTime recordedAt,
            List<BabyFoodItemDto> items,
            String? note,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecordDto():
        return $default(_that.id, _that.recordedAt, _that.items, _that.note,
            _that.createdAt, _that.updatedAt);
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
            String id,
            DateTime recordedAt,
            List<BabyFoodItemDto> items,
            String? note,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecordDto() when $default != null:
        return $default(_that.id, _that.recordedAt, _that.items, _that.note,
            _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BabyFoodRecordDto extends BabyFoodRecordDto {
  const _BabyFoodRecordDto(
      {required this.id,
      required this.recordedAt,
      required final List<BabyFoodItemDto> items,
      this.note,
      required this.createdAt,
      required this.updatedAt})
      : _items = items,
        super._();

  @override
  final String id;
  @override
  final DateTime recordedAt;
  final List<BabyFoodItemDto> _items;
  @override
  List<BabyFoodItemDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? note;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of BabyFoodRecordDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodRecordDtoCopyWith<_BabyFoodRecordDto> get copyWith =>
      __$BabyFoodRecordDtoCopyWithImpl<_BabyFoodRecordDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodRecordDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, recordedAt,
      const DeepCollectionEquality().hash(_items), note, createdAt, updatedAt);

  @override
  String toString() {
    return 'BabyFoodRecordDto(id: $id, recordedAt: $recordedAt, items: $items, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodRecordDtoCopyWith<$Res>
    implements $BabyFoodRecordDtoCopyWith<$Res> {
  factory _$BabyFoodRecordDtoCopyWith(
          _BabyFoodRecordDto value, $Res Function(_BabyFoodRecordDto) _then) =
      __$BabyFoodRecordDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime recordedAt,
      List<BabyFoodItemDto> items,
      String? note,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$BabyFoodRecordDtoCopyWithImpl<$Res>
    implements _$BabyFoodRecordDtoCopyWith<$Res> {
  __$BabyFoodRecordDtoCopyWithImpl(this._self, this._then);

  final _BabyFoodRecordDto _self;
  final $Res Function(_BabyFoodRecordDto) _then;

  /// Create a copy of BabyFoodRecordDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? recordedAt = null,
    Object? items = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_BabyFoodRecordDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: null == recordedAt
          ? _self.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BabyFoodItemDto>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
