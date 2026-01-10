// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby_food_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BabyFoodRecord {
  /// 記録ID
  String get id;

  /// 記録日時
  DateTime get recordedAt;

  /// 食べた食材リスト
  List<BabyFoodItem> get items;

  /// メモ（任意）
  String? get note;

  /// 作成日時
  DateTime get createdAt;

  /// 更新日時
  DateTime get updatedAt;

  /// Create a copy of BabyFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodRecordCopyWith<BabyFoodRecord> get copyWith =>
      _$BabyFoodRecordCopyWithImpl<BabyFoodRecord>(
          this as BabyFoodRecord, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodRecord &&
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
    return 'BabyFoodRecord(id: $id, recordedAt: $recordedAt, items: $items, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodRecordCopyWith<$Res> {
  factory $BabyFoodRecordCopyWith(
          BabyFoodRecord value, $Res Function(BabyFoodRecord) _then) =
      _$BabyFoodRecordCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime recordedAt,
      List<BabyFoodItem> items,
      String? note,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$BabyFoodRecordCopyWithImpl<$Res>
    implements $BabyFoodRecordCopyWith<$Res> {
  _$BabyFoodRecordCopyWithImpl(this._self, this._then);

  final BabyFoodRecord _self;
  final $Res Function(BabyFoodRecord) _then;

  /// Create a copy of BabyFoodRecord
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
              as List<BabyFoodItem>,
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

/// Adds pattern-matching-related methods to [BabyFoodRecord].
extension BabyFoodRecordPatterns on BabyFoodRecord {
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
    TResult Function(_BabyFoodRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecord() when $default != null:
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
    TResult Function(_BabyFoodRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecord():
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
    TResult? Function(_BabyFoodRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecord() when $default != null:
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
    TResult Function(String id, DateTime recordedAt, List<BabyFoodItem> items,
            String? note, DateTime createdAt, DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecord() when $default != null:
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
    TResult Function(String id, DateTime recordedAt, List<BabyFoodItem> items,
            String? note, DateTime createdAt, DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecord():
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
    TResult? Function(String id, DateTime recordedAt, List<BabyFoodItem> items,
            String? note, DateTime createdAt, DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodRecord() when $default != null:
        return $default(_that.id, _that.recordedAt, _that.items, _that.note,
            _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BabyFoodRecord extends BabyFoodRecord {
  const _BabyFoodRecord(
      {required this.id,
      required this.recordedAt,
      required final List<BabyFoodItem> items,
      this.note,
      required this.createdAt,
      required this.updatedAt})
      : _items = items,
        super._();

  /// 記録ID
  @override
  final String id;

  /// 記録日時
  @override
  final DateTime recordedAt;

  /// 食べた食材リスト
  final List<BabyFoodItem> _items;

  /// 食べた食材リスト
  @override
  List<BabyFoodItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// メモ（任意）
  @override
  final String? note;

  /// 作成日時
  @override
  final DateTime createdAt;

  /// 更新日時
  @override
  final DateTime updatedAt;

  /// Create a copy of BabyFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodRecordCopyWith<_BabyFoodRecord> get copyWith =>
      __$BabyFoodRecordCopyWithImpl<_BabyFoodRecord>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodRecord &&
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
    return 'BabyFoodRecord(id: $id, recordedAt: $recordedAt, items: $items, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodRecordCopyWith<$Res>
    implements $BabyFoodRecordCopyWith<$Res> {
  factory _$BabyFoodRecordCopyWith(
          _BabyFoodRecord value, $Res Function(_BabyFoodRecord) _then) =
      __$BabyFoodRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime recordedAt,
      List<BabyFoodItem> items,
      String? note,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$BabyFoodRecordCopyWithImpl<$Res>
    implements _$BabyFoodRecordCopyWith<$Res> {
  __$BabyFoodRecordCopyWithImpl(this._self, this._then);

  final _BabyFoodRecord _self;
  final $Res Function(_BabyFoodRecord) _then;

  /// Create a copy of BabyFoodRecord
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
    return _then(_BabyFoodRecord(
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
              as List<BabyFoodItem>,
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
