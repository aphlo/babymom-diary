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
mixin _$ReservationGroupMemberDto {
  String get vaccineId;
  String get doseId;

  /// Create a copy of ReservationGroupMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReservationGroupMemberDtoCopyWith<ReservationGroupMemberDto> get copyWith =>
      _$ReservationGroupMemberDtoCopyWithImpl<ReservationGroupMemberDto>(
          this as ReservationGroupMemberDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReservationGroupMemberDto &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.doseId, doseId) || other.doseId == doseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vaccineId, doseId);

  @override
  String toString() {
    return 'ReservationGroupMemberDto(vaccineId: $vaccineId, doseId: $doseId)';
  }
}

/// @nodoc
abstract mixin class $ReservationGroupMemberDtoCopyWith<$Res> {
  factory $ReservationGroupMemberDtoCopyWith(ReservationGroupMemberDto value,
          $Res Function(ReservationGroupMemberDto) _then) =
      _$ReservationGroupMemberDtoCopyWithImpl;
  @useResult
  $Res call({String vaccineId, String doseId});
}

/// @nodoc
class _$ReservationGroupMemberDtoCopyWithImpl<$Res>
    implements $ReservationGroupMemberDtoCopyWith<$Res> {
  _$ReservationGroupMemberDtoCopyWithImpl(this._self, this._then);

  final ReservationGroupMemberDto _self;
  final $Res Function(ReservationGroupMemberDto) _then;

  /// Create a copy of ReservationGroupMemberDto
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

/// Adds pattern-matching-related methods to [ReservationGroupMemberDto].
extension ReservationGroupMemberDtoPatterns on ReservationGroupMemberDto {
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
    TResult Function(_ReservationGroupMemberDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMemberDto() when $default != null:
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
    TResult Function(_ReservationGroupMemberDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMemberDto():
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
    TResult? Function(_ReservationGroupMemberDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupMemberDto() when $default != null:
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
      case _ReservationGroupMemberDto() when $default != null:
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
      case _ReservationGroupMemberDto():
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
      case _ReservationGroupMemberDto() when $default != null:
        return $default(_that.vaccineId, _that.doseId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ReservationGroupMemberDto extends ReservationGroupMemberDto {
  const _ReservationGroupMemberDto(
      {required this.vaccineId, required this.doseId})
      : super._();

  @override
  final String vaccineId;
  @override
  final String doseId;

  /// Create a copy of ReservationGroupMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReservationGroupMemberDtoCopyWith<_ReservationGroupMemberDto>
      get copyWith =>
          __$ReservationGroupMemberDtoCopyWithImpl<_ReservationGroupMemberDto>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReservationGroupMemberDto &&
            (identical(other.vaccineId, vaccineId) ||
                other.vaccineId == vaccineId) &&
            (identical(other.doseId, doseId) || other.doseId == doseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vaccineId, doseId);

  @override
  String toString() {
    return 'ReservationGroupMemberDto(vaccineId: $vaccineId, doseId: $doseId)';
  }
}

/// @nodoc
abstract mixin class _$ReservationGroupMemberDtoCopyWith<$Res>
    implements $ReservationGroupMemberDtoCopyWith<$Res> {
  factory _$ReservationGroupMemberDtoCopyWith(_ReservationGroupMemberDto value,
          $Res Function(_ReservationGroupMemberDto) _then) =
      __$ReservationGroupMemberDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String vaccineId, String doseId});
}

/// @nodoc
class __$ReservationGroupMemberDtoCopyWithImpl<$Res>
    implements _$ReservationGroupMemberDtoCopyWith<$Res> {
  __$ReservationGroupMemberDtoCopyWithImpl(this._self, this._then);

  final _ReservationGroupMemberDto _self;
  final $Res Function(_ReservationGroupMemberDto) _then;

  /// Create a copy of ReservationGroupMemberDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vaccineId = null,
    Object? doseId = null,
  }) {
    return _then(_ReservationGroupMemberDto(
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
mixin _$ReservationGroupDto {
  String get id;
  String get childId;
  DateTime get scheduledDate;
  ReservationGroupStatus get status;
  List<ReservationGroupMemberDto> get members;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of ReservationGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReservationGroupDtoCopyWith<ReservationGroupDto> get copyWith =>
      _$ReservationGroupDtoCopyWithImpl<ReservationGroupDto>(
          this as ReservationGroupDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReservationGroupDto &&
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
    return 'ReservationGroupDto(id: $id, childId: $childId, scheduledDate: $scheduledDate, status: $status, members: $members, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ReservationGroupDtoCopyWith<$Res> {
  factory $ReservationGroupDtoCopyWith(
          ReservationGroupDto value, $Res Function(ReservationGroupDto) _then) =
      _$ReservationGroupDtoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String childId,
      DateTime scheduledDate,
      ReservationGroupStatus status,
      List<ReservationGroupMemberDto> members,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ReservationGroupDtoCopyWithImpl<$Res>
    implements $ReservationGroupDtoCopyWith<$Res> {
  _$ReservationGroupDtoCopyWithImpl(this._self, this._then);

  final ReservationGroupDto _self;
  final $Res Function(ReservationGroupDto) _then;

  /// Create a copy of ReservationGroupDto
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
              as List<ReservationGroupMemberDto>,
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

/// Adds pattern-matching-related methods to [ReservationGroupDto].
extension ReservationGroupDtoPatterns on ReservationGroupDto {
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
    TResult Function(_ReservationGroupDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupDto() when $default != null:
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
    TResult Function(_ReservationGroupDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupDto():
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
    TResult? Function(_ReservationGroupDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupDto() when $default != null:
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
            List<ReservationGroupMemberDto> members,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupDto() when $default != null:
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
            List<ReservationGroupMemberDto> members,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupDto():
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
            List<ReservationGroupMemberDto> members,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReservationGroupDto() when $default != null:
        return $default(_that.id, _that.childId, _that.scheduledDate,
            _that.status, _that.members, _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ReservationGroupDto extends ReservationGroupDto {
  const _ReservationGroupDto(
      {required this.id,
      required this.childId,
      required this.scheduledDate,
      required this.status,
      required final List<ReservationGroupMemberDto> members,
      required this.createdAt,
      required this.updatedAt})
      : _members = members,
        super._();

  @override
  final String id;
  @override
  final String childId;
  @override
  final DateTime scheduledDate;
  @override
  final ReservationGroupStatus status;
  final List<ReservationGroupMemberDto> _members;
  @override
  List<ReservationGroupMemberDto> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of ReservationGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReservationGroupDtoCopyWith<_ReservationGroupDto> get copyWith =>
      __$ReservationGroupDtoCopyWithImpl<_ReservationGroupDto>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReservationGroupDto &&
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
    return 'ReservationGroupDto(id: $id, childId: $childId, scheduledDate: $scheduledDate, status: $status, members: $members, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ReservationGroupDtoCopyWith<$Res>
    implements $ReservationGroupDtoCopyWith<$Res> {
  factory _$ReservationGroupDtoCopyWith(_ReservationGroupDto value,
          $Res Function(_ReservationGroupDto) _then) =
      __$ReservationGroupDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String childId,
      DateTime scheduledDate,
      ReservationGroupStatus status,
      List<ReservationGroupMemberDto> members,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$ReservationGroupDtoCopyWithImpl<$Res>
    implements _$ReservationGroupDtoCopyWith<$Res> {
  __$ReservationGroupDtoCopyWithImpl(this._self, this._then);

  final _ReservationGroupDto _self;
  final $Res Function(_ReservationGroupDto) _then;

  /// Create a copy of ReservationGroupDto
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
    return _then(_ReservationGroupDto(
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
              as List<ReservationGroupMemberDto>,
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
