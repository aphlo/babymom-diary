// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaleInfo {
  /// セールが有効かどうか
  bool get isEnabled;

  /// 月額プランの割引率（%）
  int get monthlyDiscountPercent;

  /// 年額プランの割引率（%）
  int get yearlyDiscountPercent;

  /// セールメッセージ
  String get message;

  /// セール終了日
  DateTime? get endDate;

  /// Create a copy of SaleInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SaleInfoCopyWith<SaleInfo> get copyWith =>
      _$SaleInfoCopyWithImpl<SaleInfo>(this as SaleInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SaleInfo &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.monthlyDiscountPercent, monthlyDiscountPercent) ||
                other.monthlyDiscountPercent == monthlyDiscountPercent) &&
            (identical(other.yearlyDiscountPercent, yearlyDiscountPercent) ||
                other.yearlyDiscountPercent == yearlyDiscountPercent) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled,
      monthlyDiscountPercent, yearlyDiscountPercent, message, endDate);

  @override
  String toString() {
    return 'SaleInfo(isEnabled: $isEnabled, monthlyDiscountPercent: $monthlyDiscountPercent, yearlyDiscountPercent: $yearlyDiscountPercent, message: $message, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class $SaleInfoCopyWith<$Res> {
  factory $SaleInfoCopyWith(SaleInfo value, $Res Function(SaleInfo) _then) =
      _$SaleInfoCopyWithImpl;
  @useResult
  $Res call(
      {bool isEnabled,
      int monthlyDiscountPercent,
      int yearlyDiscountPercent,
      String message,
      DateTime? endDate});
}

/// @nodoc
class _$SaleInfoCopyWithImpl<$Res> implements $SaleInfoCopyWith<$Res> {
  _$SaleInfoCopyWithImpl(this._self, this._then);

  final SaleInfo _self;
  final $Res Function(SaleInfo) _then;

  /// Create a copy of SaleInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? monthlyDiscountPercent = null,
    Object? yearlyDiscountPercent = null,
    Object? message = null,
    Object? endDate = freezed,
  }) {
    return _then(_self.copyWith(
      isEnabled: null == isEnabled
          ? _self.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      monthlyDiscountPercent: null == monthlyDiscountPercent
          ? _self.monthlyDiscountPercent
          : monthlyDiscountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      yearlyDiscountPercent: null == yearlyDiscountPercent
          ? _self.yearlyDiscountPercent
          : yearlyDiscountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SaleInfo].
extension SaleInfoPatterns on SaleInfo {
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
    TResult Function(_SaleInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SaleInfo() when $default != null:
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
    TResult Function(_SaleInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaleInfo():
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
    TResult? Function(_SaleInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaleInfo() when $default != null:
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
    TResult Function(bool isEnabled, int monthlyDiscountPercent,
            int yearlyDiscountPercent, String message, DateTime? endDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SaleInfo() when $default != null:
        return $default(_that.isEnabled, _that.monthlyDiscountPercent,
            _that.yearlyDiscountPercent, _that.message, _that.endDate);
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
    TResult Function(bool isEnabled, int monthlyDiscountPercent,
            int yearlyDiscountPercent, String message, DateTime? endDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaleInfo():
        return $default(_that.isEnabled, _that.monthlyDiscountPercent,
            _that.yearlyDiscountPercent, _that.message, _that.endDate);
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
    TResult? Function(bool isEnabled, int monthlyDiscountPercent,
            int yearlyDiscountPercent, String message, DateTime? endDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaleInfo() when $default != null:
        return $default(_that.isEnabled, _that.monthlyDiscountPercent,
            _that.yearlyDiscountPercent, _that.message, _that.endDate);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SaleInfo implements SaleInfo {
  const _SaleInfo(
      {required this.isEnabled,
      required this.monthlyDiscountPercent,
      required this.yearlyDiscountPercent,
      required this.message,
      this.endDate});

  /// セールが有効かどうか
  @override
  final bool isEnabled;

  /// 月額プランの割引率（%）
  @override
  final int monthlyDiscountPercent;

  /// 年額プランの割引率（%）
  @override
  final int yearlyDiscountPercent;

  /// セールメッセージ
  @override
  final String message;

  /// セール終了日
  @override
  final DateTime? endDate;

  /// Create a copy of SaleInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaleInfoCopyWith<_SaleInfo> get copyWith =>
      __$SaleInfoCopyWithImpl<_SaleInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaleInfo &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.monthlyDiscountPercent, monthlyDiscountPercent) ||
                other.monthlyDiscountPercent == monthlyDiscountPercent) &&
            (identical(other.yearlyDiscountPercent, yearlyDiscountPercent) ||
                other.yearlyDiscountPercent == yearlyDiscountPercent) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled,
      monthlyDiscountPercent, yearlyDiscountPercent, message, endDate);

  @override
  String toString() {
    return 'SaleInfo(isEnabled: $isEnabled, monthlyDiscountPercent: $monthlyDiscountPercent, yearlyDiscountPercent: $yearlyDiscountPercent, message: $message, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class _$SaleInfoCopyWith<$Res>
    implements $SaleInfoCopyWith<$Res> {
  factory _$SaleInfoCopyWith(_SaleInfo value, $Res Function(_SaleInfo) _then) =
      __$SaleInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isEnabled,
      int monthlyDiscountPercent,
      int yearlyDiscountPercent,
      String message,
      DateTime? endDate});
}

/// @nodoc
class __$SaleInfoCopyWithImpl<$Res> implements _$SaleInfoCopyWith<$Res> {
  __$SaleInfoCopyWithImpl(this._self, this._then);

  final _SaleInfo _self;
  final $Res Function(_SaleInfo) _then;

  /// Create a copy of SaleInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isEnabled = null,
    Object? monthlyDiscountPercent = null,
    Object? yearlyDiscountPercent = null,
    Object? message = null,
    Object? endDate = freezed,
  }) {
    return _then(_SaleInfo(
      isEnabled: null == isEnabled
          ? _self.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      monthlyDiscountPercent: null == monthlyDiscountPercent
          ? _self.monthlyDiscountPercent
          : monthlyDiscountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      yearlyDiscountPercent: null == yearlyDiscountPercent
          ? _self.yearlyDiscountPercent
          : yearlyDiscountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
