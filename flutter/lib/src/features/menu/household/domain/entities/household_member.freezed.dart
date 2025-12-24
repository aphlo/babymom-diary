// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HouseholdMember {
  String get uid;
  String get displayName;
  String get role; // 'admin' or 'member'
  DateTime get joinedAt;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HouseholdMemberCopyWith<HouseholdMember> get copyWith =>
      _$HouseholdMemberCopyWithImpl<HouseholdMember>(
          this as HouseholdMember, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HouseholdMember &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, displayName, role, joinedAt);

  @override
  String toString() {
    return 'HouseholdMember(uid: $uid, displayName: $displayName, role: $role, joinedAt: $joinedAt)';
  }
}

/// @nodoc
abstract mixin class $HouseholdMemberCopyWith<$Res> {
  factory $HouseholdMemberCopyWith(
          HouseholdMember value, $Res Function(HouseholdMember) _then) =
      _$HouseholdMemberCopyWithImpl;
  @useResult
  $Res call({String uid, String displayName, String role, DateTime joinedAt});
}

/// @nodoc
class _$HouseholdMemberCopyWithImpl<$Res>
    implements $HouseholdMemberCopyWith<$Res> {
  _$HouseholdMemberCopyWithImpl(this._self, this._then);

  final HouseholdMember _self;
  final $Res Function(HouseholdMember) _then;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? displayName = null,
    Object? role = null,
    Object? joinedAt = null,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [HouseholdMember].
extension HouseholdMemberPatterns on HouseholdMember {
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
    TResult Function(_HouseholdMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HouseholdMember() when $default != null:
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
    TResult Function(_HouseholdMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HouseholdMember():
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
    TResult? Function(_HouseholdMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HouseholdMember() when $default != null:
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
            String uid, String displayName, String role, DateTime joinedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HouseholdMember() when $default != null:
        return $default(
            _that.uid, _that.displayName, _that.role, _that.joinedAt);
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
            String uid, String displayName, String role, DateTime joinedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HouseholdMember():
        return $default(
            _that.uid, _that.displayName, _that.role, _that.joinedAt);
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
            String uid, String displayName, String role, DateTime joinedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HouseholdMember() when $default != null:
        return $default(
            _that.uid, _that.displayName, _that.role, _that.joinedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HouseholdMember extends HouseholdMember {
  const _HouseholdMember(
      {required this.uid,
      required this.displayName,
      required this.role,
      required this.joinedAt})
      : super._();

  @override
  final String uid;
  @override
  final String displayName;
  @override
  final String role;
// 'admin' or 'member'
  @override
  final DateTime joinedAt;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HouseholdMemberCopyWith<_HouseholdMember> get copyWith =>
      __$HouseholdMemberCopyWithImpl<_HouseholdMember>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HouseholdMember &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, displayName, role, joinedAt);

  @override
  String toString() {
    return 'HouseholdMember(uid: $uid, displayName: $displayName, role: $role, joinedAt: $joinedAt)';
  }
}

/// @nodoc
abstract mixin class _$HouseholdMemberCopyWith<$Res>
    implements $HouseholdMemberCopyWith<$Res> {
  factory _$HouseholdMemberCopyWith(
          _HouseholdMember value, $Res Function(_HouseholdMember) _then) =
      __$HouseholdMemberCopyWithImpl;
  @override
  @useResult
  $Res call({String uid, String displayName, String role, DateTime joinedAt});
}

/// @nodoc
class __$HouseholdMemberCopyWithImpl<$Res>
    implements _$HouseholdMemberCopyWith<$Res> {
  __$HouseholdMemberCopyWithImpl(this._self, this._then);

  final _HouseholdMember _self;
  final $Res Function(_HouseholdMember) _then;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? displayName = null,
    Object? role = null,
    Object? joinedAt = null,
  }) {
    return _then(_HouseholdMember(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
