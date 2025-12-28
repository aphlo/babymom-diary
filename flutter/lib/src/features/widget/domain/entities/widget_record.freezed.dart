// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WidgetRecord {
  String get id;
  RecordType get type;
  DateTime get at;
  double? get amount;
  ExcretionVolume? get excretionVolume;

  /// Create a copy of WidgetRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WidgetRecordCopyWith<WidgetRecord> get copyWith =>
      _$WidgetRecordCopyWithImpl<WidgetRecord>(
          this as WidgetRecord, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WidgetRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.excretionVolume, excretionVolume) ||
                other.excretionVolume == excretionVolume));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, at, amount, excretionVolume);

  @override
  String toString() {
    return 'WidgetRecord(id: $id, type: $type, at: $at, amount: $amount, excretionVolume: $excretionVolume)';
  }
}

/// @nodoc
abstract mixin class $WidgetRecordCopyWith<$Res> {
  factory $WidgetRecordCopyWith(
          WidgetRecord value, $Res Function(WidgetRecord) _then) =
      _$WidgetRecordCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      RecordType type,
      DateTime at,
      double? amount,
      ExcretionVolume? excretionVolume});
}

/// @nodoc
class _$WidgetRecordCopyWithImpl<$Res> implements $WidgetRecordCopyWith<$Res> {
  _$WidgetRecordCopyWithImpl(this._self, this._then);

  final WidgetRecord _self;
  final $Res Function(WidgetRecord) _then;

  /// Create a copy of WidgetRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? at = null,
    Object? amount = freezed,
    Object? excretionVolume = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecordType,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      excretionVolume: freezed == excretionVolume
          ? _self.excretionVolume
          : excretionVolume // ignore: cast_nullable_to_non_nullable
              as ExcretionVolume?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WidgetRecord].
extension WidgetRecordPatterns on WidgetRecord {
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
    TResult Function(_WidgetRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetRecord() when $default != null:
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
    TResult Function(_WidgetRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetRecord():
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
    TResult? Function(_WidgetRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetRecord() when $default != null:
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
    TResult Function(String id, RecordType type, DateTime at, double? amount,
            ExcretionVolume? excretionVolume)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetRecord() when $default != null:
        return $default(_that.id, _that.type, _that.at, _that.amount,
            _that.excretionVolume);
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
    TResult Function(String id, RecordType type, DateTime at, double? amount,
            ExcretionVolume? excretionVolume)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetRecord():
        return $default(_that.id, _that.type, _that.at, _that.amount,
            _that.excretionVolume);
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
    TResult? Function(String id, RecordType type, DateTime at, double? amount,
            ExcretionVolume? excretionVolume)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetRecord() when $default != null:
        return $default(_that.id, _that.type, _that.at, _that.amount,
            _that.excretionVolume);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WidgetRecord extends WidgetRecord {
  const _WidgetRecord(
      {required this.id,
      required this.type,
      required this.at,
      this.amount,
      this.excretionVolume})
      : super._();

  @override
  final String id;
  @override
  final RecordType type;
  @override
  final DateTime at;
  @override
  final double? amount;
  @override
  final ExcretionVolume? excretionVolume;

  /// Create a copy of WidgetRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WidgetRecordCopyWith<_WidgetRecord> get copyWith =>
      __$WidgetRecordCopyWithImpl<_WidgetRecord>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.excretionVolume, excretionVolume) ||
                other.excretionVolume == excretionVolume));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, at, amount, excretionVolume);

  @override
  String toString() {
    return 'WidgetRecord(id: $id, type: $type, at: $at, amount: $amount, excretionVolume: $excretionVolume)';
  }
}

/// @nodoc
abstract mixin class _$WidgetRecordCopyWith<$Res>
    implements $WidgetRecordCopyWith<$Res> {
  factory _$WidgetRecordCopyWith(
          _WidgetRecord value, $Res Function(_WidgetRecord) _then) =
      __$WidgetRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      RecordType type,
      DateTime at,
      double? amount,
      ExcretionVolume? excretionVolume});
}

/// @nodoc
class __$WidgetRecordCopyWithImpl<$Res>
    implements _$WidgetRecordCopyWith<$Res> {
  __$WidgetRecordCopyWithImpl(this._self, this._then);

  final _WidgetRecord _self;
  final $Res Function(_WidgetRecord) _then;

  /// Create a copy of WidgetRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? at = null,
    Object? amount = freezed,
    Object? excretionVolume = freezed,
  }) {
    return _then(_WidgetRecord(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecordType,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      excretionVolume: freezed == excretionVolume
          ? _self.excretionVolume
          : excretionVolume // ignore: cast_nullable_to_non_nullable
              as ExcretionVolume?,
    ));
  }
}

// dart format on
