// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationGroupMember {
  String get vaccineId;
  String get doseId;

  /// Create a copy of ReservationGroupMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReservationGroupMemberCopyWith<ReservationGroupMember> get copyWith =>
      _$ReservationGroupMemberCopyWithImpl<ReservationGroupMember>(
          this as ReservationGroupMember, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReservationGroupMember &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.doseId, doseId) || other.doseId == doseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vaccineId, doseId);

  @override
  String toString() {
    return 'ReservationGroupMember(vaccineId: $vaccineId, doseId: $doseId)';
  }
}

/// @nodoc
abstract mixin class $ReservationGroupMemberCopyWith<$Res> {
  factory $ReservationGroupMemberCopyWith(ReservationGroupMember value,
          $Res Function(ReservationGroupMember) _then) =
      _$ReservationGroupMemberCopyWithImpl;
  @useResult
  $Res call({String vaccineId, String doseId});
}

/// @nodoc
class _$ReservationGroupMemberCopyWithImpl<$Res>
    implements $ReservationGroupMemberCopyWith<$Res> {
  _$ReservationGroupMemberCopyWithImpl(this._self, this._then);

  final ReservationGroupMember _self;
  final $Res Function(ReservationGroupMember) _then;

  /// Create a copy of ReservationGroupMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vaccineId = null,
    Object? doseId = null,
  }) {
    return _then(_self.copyWith(
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      doseId: null == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReservationGroupMember].
extension ReservationGroupMemberPatterns on ReservationGroupMember {
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
    TResult Function(_ReservationGroupMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMember() when $default != null:
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
    TResult Function(_ReservationGroupMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMember():
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
    TResult? Function(_ReservationGroupMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMember() when $default != null:
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
    TResult Function(String vaccineId, String doseId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMember() when $default != null:
        return $default(_that.vaccineId, _that.doseId);
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
    TResult Function(String vaccineId, String doseId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMember():
        return $default(_that.vaccineId, _that.doseId);
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
    TResult? Function(String vaccineId, String doseId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMember() when $default != null:
        return $default(_that.vaccineId, _that.doseId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ReservationGroupMember implements ReservationGroupMember {
  const _ReservationGroupMember(
      {required this.vaccineId, required this.doseId});

  @override
  final String vaccineId;
  @override
  final String doseId;

  /// Create a copy of ReservationGroupMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReservationGroupMemberCopyWith<_ReservationGroupMember> get copyWith =>
      __$ReservationGroupMemberCopyWithImpl<_ReservationGroupMember>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReservationGroupMember &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.doseId, doseId) || other.doseId == doseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vaccineId, doseId);

  @override
  String toString() {
    return 'ReservationGroupMember(vaccineId: $vaccineId, doseId: $doseId)';
  }
}

/// @nodoc
abstract mixin class _$ReservationGroupMemberCopyWith<$Res>
    implements $ReservationGroupMemberCopyWith<$Res> {
  factory _$ReservationGroupMemberCopyWith(_ReservationGroupMember value,
          $Res Function(_ReservationGroupMember) _then) =
      __$ReservationGroupMemberCopyWithImpl;
  @override
  @useResult
  $Res call({String vaccineId, String doseId});
}

/// @nodoc
class __$ReservationGroupMemberCopyWithImpl<$Res>
    implements _$ReservationGroupMemberCopyWith<$Res> {
  __$ReservationGroupMemberCopyWithImpl(this._self, this._then);

  final _ReservationGroupMember _self;
  final $Res Function(_ReservationGroupMember) _then;

  /// Create a copy of ReservationGroupMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vaccineId = null,
    Object? doseId = null,
  }) {
    return _then(_ReservationGroupMember(
      vaccineId: null == vaccineId
          ? _self.vaccineId
          : vaccineId // ignore: cast_nullable_to_non_nullable
              as String,
      doseId: null == doseId
          ? _self.doseId
          : doseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$VaccinationReservationGroup {
  String get id;
  String get childId;
  DateTime get scheduledDate;
  ReservationGroupStatus get status;
  List<ReservationGroupMember> get members;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of VaccinationReservationGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccinationReservationGroupCopyWith<VaccinationReservationGroup>
      get copyWith => _$VaccinationReservationGroupCopyWithImpl<
              VaccinationReservationGroup>(
          this as VaccinationReservationGroup, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccinationReservationGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.members, members) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      childId,
      scheduledDate,
      status,
      const DeepCollectionEquality().hash(members),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'VaccinationReservationGroup(id: $id, childId: $childId, scheduledDate: $scheduledDate, status: $status, members: $members, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $VaccinationReservationGroupCopyWith<$Res> {
  factory $VaccinationReservationGroupCopyWith(
          VaccinationReservationGroup value,
          $Res Function(VaccinationReservationGroup) _then) =
      _$VaccinationReservationGroupCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String childId,
      DateTime scheduledDate,
      ReservationGroupStatus status,
      List<ReservationGroupMember> members,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$VaccinationReservationGroupCopyWithImpl<$Res>
    implements $VaccinationReservationGroupCopyWith<$Res> {
  _$VaccinationReservationGroupCopyWithImpl(this._self, this._then);

  final VaccinationReservationGroup _self;
  final $Res Function(VaccinationReservationGroup) _then;

  /// Create a copy of VaccinationReservationGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? scheduledDate = null,
    Object? status = null,
    Object? members = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: null == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationGroupStatus,
      members: null == members
          ? _self.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ReservationGroupMember>,
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

/// Adds pattern-matching-related methods to [VaccinationReservationGroup].
extension VaccinationReservationGroupPatterns on VaccinationReservationGroup {
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
    TResult Function(_VaccinationReservationGroup value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccinationReservationGroup() when $default != null:
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
    TResult Function(_VaccinationReservationGroup value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationReservationGroup():
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
    TResult? Function(_VaccinationReservationGroup value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationReservationGroup() when $default != null:
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
            String childId,
            DateTime scheduledDate,
            ReservationGroupStatus status,
            List<ReservationGroupMember> members,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccinationReservationGroup() when $default != null:
        return $default(_that.id, _that.childId, _that.scheduledDate,
            _that.status, _that.members, _that.createdAt, _that.updatedAt);
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
            String childId,
            DateTime scheduledDate,
            ReservationGroupStatus status,
            List<ReservationGroupMember> members,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationReservationGroup():
        return $default(_that.id, _that.childId, _that.scheduledDate,
            _that.status, _that.members, _that.createdAt, _that.updatedAt);
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
            String childId,
            DateTime scheduledDate,
            ReservationGroupStatus status,
            List<ReservationGroupMember> members,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccinationReservationGroup() when $default != null:
        return $default(_that.id, _that.childId, _that.scheduledDate,
            _that.status, _that.members, _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccinationReservationGroup implements VaccinationReservationGroup {
  const _VaccinationReservationGroup(
      {required this.id,
      required this.childId,
      required this.scheduledDate,
      required this.status,
      required final List<ReservationGroupMember> members,
      required this.createdAt,
      required this.updatedAt})
      : _members = members;

  @override
  final String id;
  @override
  final String childId;
  @override
  final DateTime scheduledDate;
  @override
  final ReservationGroupStatus status;
  final List<ReservationGroupMember> _members;
  @override
  List<ReservationGroupMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of VaccinationReservationGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccinationReservationGroupCopyWith<_VaccinationReservationGroup>
      get copyWith => __$VaccinationReservationGroupCopyWithImpl<
          _VaccinationReservationGroup>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccinationReservationGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      childId,
      scheduledDate,
      status,
      const DeepCollectionEquality().hash(_members),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'VaccinationReservationGroup(id: $id, childId: $childId, scheduledDate: $scheduledDate, status: $status, members: $members, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$VaccinationReservationGroupCopyWith<$Res>
    implements $VaccinationReservationGroupCopyWith<$Res> {
  factory _$VaccinationReservationGroupCopyWith(
          _VaccinationReservationGroup value,
          $Res Function(_VaccinationReservationGroup) _then) =
      __$VaccinationReservationGroupCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String childId,
      DateTime scheduledDate,
      ReservationGroupStatus status,
      List<ReservationGroupMember> members,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$VaccinationReservationGroupCopyWithImpl<$Res>
    implements _$VaccinationReservationGroupCopyWith<$Res> {
  __$VaccinationReservationGroupCopyWithImpl(this._self, this._then);

  final _VaccinationReservationGroup _self;
  final $Res Function(_VaccinationReservationGroup) _then;

  /// Create a copy of VaccinationReservationGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? scheduledDate = null,
    Object? status = null,
    Object? members = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_VaccinationReservationGroup(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: null == scheduledDate
          ? _self.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationGroupStatus,
      members: null == members
          ? _self._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ReservationGroupMember>,
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
