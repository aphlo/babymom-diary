// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionStatus {
  /// サブスクリプションがアクティブかどうか
  bool get isActive;

  /// 広告非表示のEntitlementを持っているかどうか
  bool get hasAdFreeEntitlement;

  /// サブスクリプションの有効期限
  DateTime? get expirationDate;

  /// 購入した商品ID
  String? get productId;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubscriptionStatusCopyWith<SubscriptionStatus> get copyWith =>
      _$SubscriptionStatusCopyWithImpl<SubscriptionStatus>(
          this as SubscriptionStatus, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubscriptionStatus &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.hasAdFreeEntitlement, hasAdFreeEntitlement) ||
                other.hasAdFreeEntitlement == hasAdFreeEntitlement) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isActive, hasAdFreeEntitlement, expirationDate, productId);

  @override
  String toString() {
    return 'SubscriptionStatus(isActive: $isActive, hasAdFreeEntitlement: $hasAdFreeEntitlement, expirationDate: $expirationDate, productId: $productId)';
  }
}

/// @nodoc
abstract mixin class $SubscriptionStatusCopyWith<$Res> {
  factory $SubscriptionStatusCopyWith(
          SubscriptionStatus value, $Res Function(SubscriptionStatus) _then) =
      _$SubscriptionStatusCopyWithImpl;
  @useResult
  $Res call(
      {bool isActive,
      bool hasAdFreeEntitlement,
      DateTime? expirationDate,
      String? productId});
}

/// @nodoc
class _$SubscriptionStatusCopyWithImpl<$Res>
    implements $SubscriptionStatusCopyWith<$Res> {
  _$SubscriptionStatusCopyWithImpl(this._self, this._then);

  final SubscriptionStatus _self;
  final $Res Function(SubscriptionStatus) _then;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? hasAdFreeEntitlement = null,
    Object? expirationDate = freezed,
    Object? productId = freezed,
  }) {
    return _then(_self.copyWith(
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAdFreeEntitlement: null == hasAdFreeEntitlement
          ? _self.hasAdFreeEntitlement
          : hasAdFreeEntitlement // ignore: cast_nullable_to_non_nullable
              as bool,
      expirationDate: freezed == expirationDate
          ? _self.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      productId: freezed == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubscriptionStatus].
extension SubscriptionStatusPatterns on SubscriptionStatus {
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
    TResult Function(_SubscriptionStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubscriptionStatus() when $default != null:
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
    TResult Function(_SubscriptionStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionStatus():
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
    TResult? Function(_SubscriptionStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionStatus() when $default != null:
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
    TResult Function(bool isActive, bool hasAdFreeEntitlement,
            DateTime? expirationDate, String? productId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubscriptionStatus() when $default != null:
        return $default(_that.isActive, _that.hasAdFreeEntitlement,
            _that.expirationDate, _that.productId);
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
    TResult Function(bool isActive, bool hasAdFreeEntitlement,
            DateTime? expirationDate, String? productId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionStatus():
        return $default(_that.isActive, _that.hasAdFreeEntitlement,
            _that.expirationDate, _that.productId);
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
    TResult? Function(bool isActive, bool hasAdFreeEntitlement,
            DateTime? expirationDate, String? productId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionStatus() when $default != null:
        return $default(_that.isActive, _that.hasAdFreeEntitlement,
            _that.expirationDate, _that.productId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SubscriptionStatus implements SubscriptionStatus {
  const _SubscriptionStatus(
      {required this.isActive,
      required this.hasAdFreeEntitlement,
      this.expirationDate,
      this.productId});

  /// サブスクリプションがアクティブかどうか
  @override
  final bool isActive;

  /// 広告非表示のEntitlementを持っているかどうか
  @override
  final bool hasAdFreeEntitlement;

  /// サブスクリプションの有効期限
  @override
  final DateTime? expirationDate;

  /// 購入した商品ID
  @override
  final String? productId;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubscriptionStatusCopyWith<_SubscriptionStatus> get copyWith =>
      __$SubscriptionStatusCopyWithImpl<_SubscriptionStatus>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubscriptionStatus &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.hasAdFreeEntitlement, hasAdFreeEntitlement) ||
                other.hasAdFreeEntitlement == hasAdFreeEntitlement) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isActive, hasAdFreeEntitlement, expirationDate, productId);

  @override
  String toString() {
    return 'SubscriptionStatus(isActive: $isActive, hasAdFreeEntitlement: $hasAdFreeEntitlement, expirationDate: $expirationDate, productId: $productId)';
  }
}

/// @nodoc
abstract mixin class _$SubscriptionStatusCopyWith<$Res>
    implements $SubscriptionStatusCopyWith<$Res> {
  factory _$SubscriptionStatusCopyWith(
          _SubscriptionStatus value, $Res Function(_SubscriptionStatus) _then) =
      __$SubscriptionStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isActive,
      bool hasAdFreeEntitlement,
      DateTime? expirationDate,
      String? productId});
}

/// @nodoc
class __$SubscriptionStatusCopyWithImpl<$Res>
    implements _$SubscriptionStatusCopyWith<$Res> {
  __$SubscriptionStatusCopyWithImpl(this._self, this._then);

  final _SubscriptionStatus _self;
  final $Res Function(_SubscriptionStatus) _then;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isActive = null,
    Object? hasAdFreeEntitlement = null,
    Object? expirationDate = freezed,
    Object? productId = freezed,
  }) {
    return _then(_SubscriptionStatus(
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAdFreeEntitlement: null == hasAdFreeEntitlement
          ? _self.hasAdFreeEntitlement
          : hasAdFreeEntitlement // ignore: cast_nullable_to_non_nullable
              as bool,
      expirationDate: freezed == expirationDate
          ? _self.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      productId: freezed == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
