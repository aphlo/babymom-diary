// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecordSlotRequest {
  DateTime get date;
  int get hour;
  RecordType get type;
  List<RecordItemModel> get records;

  /// Create a copy of RecordSlotRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordSlotRequestCopyWith<RecordSlotRequest> get copyWith =>
      _$RecordSlotRequestCopyWithImpl<RecordSlotRequest>(
          this as RecordSlotRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordSlotRequest &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.records, records));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, hour, type,
      const DeepCollectionEquality().hash(records));

  @override
  String toString() {
    return 'RecordSlotRequest(date: $date, hour: $hour, type: $type, records: $records)';
  }
}

/// @nodoc
abstract mixin class $RecordSlotRequestCopyWith<$Res> {
  factory $RecordSlotRequestCopyWith(
          RecordSlotRequest value, $Res Function(RecordSlotRequest) _then) =
      _$RecordSlotRequestCopyWithImpl;
  @useResult
  $Res call(
      {DateTime date,
      int hour,
      RecordType type,
      List<RecordItemModel> records});
}

/// @nodoc
class _$RecordSlotRequestCopyWithImpl<$Res>
    implements $RecordSlotRequestCopyWith<$Res> {
  _$RecordSlotRequestCopyWithImpl(this._self, this._then);

  final RecordSlotRequest _self;
  final $Res Function(RecordSlotRequest) _then;

  /// Create a copy of RecordSlotRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? hour = null,
    Object? type = null,
    Object? records = null,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hour: null == hour
          ? _self.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecordType,
      records: null == records
          ? _self.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<RecordItemModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecordSlotRequest].
extension RecordSlotRequestPatterns on RecordSlotRequest {
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
    TResult Function(_RecordSlotRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordSlotRequest() when $default != null:
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
    TResult Function(_RecordSlotRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordSlotRequest():
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
    TResult? Function(_RecordSlotRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordSlotRequest() when $default != null:
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
    TResult Function(DateTime date, int hour, RecordType type,
            List<RecordItemModel> records)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordSlotRequest() when $default != null:
        return $default(_that.date, _that.hour, _that.type, _that.records);
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
    TResult Function(DateTime date, int hour, RecordType type,
            List<RecordItemModel> records)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordSlotRequest():
        return $default(_that.date, _that.hour, _that.type, _that.records);
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
    TResult? Function(DateTime date, int hour, RecordType type,
            List<RecordItemModel> records)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordSlotRequest() when $default != null:
        return $default(_that.date, _that.hour, _that.type, _that.records);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecordSlotRequest implements RecordSlotRequest {
  const _RecordSlotRequest(
      {required this.date,
      required this.hour,
      required this.type,
      required final List<RecordItemModel> records})
      : _records = records;

  @override
  final DateTime date;
  @override
  final int hour;
  @override
  final RecordType type;
  final List<RecordItemModel> _records;
  @override
  List<RecordItemModel> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  /// Create a copy of RecordSlotRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecordSlotRequestCopyWith<_RecordSlotRequest> get copyWith =>
      __$RecordSlotRequestCopyWithImpl<_RecordSlotRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordSlotRequest &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, hour, type,
      const DeepCollectionEquality().hash(_records));

  @override
  String toString() {
    return 'RecordSlotRequest(date: $date, hour: $hour, type: $type, records: $records)';
  }
}

/// @nodoc
abstract mixin class _$RecordSlotRequestCopyWith<$Res>
    implements $RecordSlotRequestCopyWith<$Res> {
  factory _$RecordSlotRequestCopyWith(
          _RecordSlotRequest value, $Res Function(_RecordSlotRequest) _then) =
      __$RecordSlotRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int hour,
      RecordType type,
      List<RecordItemModel> records});
}

/// @nodoc
class __$RecordSlotRequestCopyWithImpl<$Res>
    implements _$RecordSlotRequestCopyWith<$Res> {
  __$RecordSlotRequestCopyWithImpl(this._self, this._then);

  final _RecordSlotRequest _self;
  final $Res Function(_RecordSlotRequest) _then;

  /// Create a copy of RecordSlotRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? hour = null,
    Object? type = null,
    Object? records = null,
  }) {
    return _then(_RecordSlotRequest(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hour: null == hour
          ? _self.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecordType,
      records: null == records
          ? _self._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<RecordItemModel>,
    ));
  }
}

/// @nodoc
mixin _$RecordEditorRequest {
  RecordDraft get draft;
  bool get isNew;

  /// Create a copy of RecordEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordEditorRequestCopyWith<RecordEditorRequest> get copyWith =>
      _$RecordEditorRequestCopyWithImpl<RecordEditorRequest>(
          this as RecordEditorRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordEditorRequest &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType, draft, isNew);

  @override
  String toString() {
    return 'RecordEditorRequest(draft: $draft, isNew: $isNew)';
  }
}

/// @nodoc
abstract mixin class $RecordEditorRequestCopyWith<$Res> {
  factory $RecordEditorRequestCopyWith(
          RecordEditorRequest value, $Res Function(RecordEditorRequest) _then) =
      _$RecordEditorRequestCopyWithImpl;
  @useResult
  $Res call({RecordDraft draft, bool isNew});
}

/// @nodoc
class _$RecordEditorRequestCopyWithImpl<$Res>
    implements $RecordEditorRequestCopyWith<$Res> {
  _$RecordEditorRequestCopyWithImpl(this._self, this._then);

  final RecordEditorRequest _self;
  final $Res Function(RecordEditorRequest) _then;

  /// Create a copy of RecordEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? isNew = null,
  }) {
    return _then(_self.copyWith(
      draft: null == draft
          ? _self.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as RecordDraft,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecordEditorRequest].
extension RecordEditorRequestPatterns on RecordEditorRequest {
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
    TResult Function(_RecordEditorRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordEditorRequest() when $default != null:
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
    TResult Function(_RecordEditorRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEditorRequest():
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
    TResult? Function(_RecordEditorRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEditorRequest() when $default != null:
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
    TResult Function(RecordDraft draft, bool isNew)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordEditorRequest() when $default != null:
        return $default(_that.draft, _that.isNew);
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
    TResult Function(RecordDraft draft, bool isNew) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEditorRequest():
        return $default(_that.draft, _that.isNew);
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
    TResult? Function(RecordDraft draft, bool isNew)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEditorRequest() when $default != null:
        return $default(_that.draft, _that.isNew);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecordEditorRequest implements RecordEditorRequest {
  const _RecordEditorRequest({required this.draft, required this.isNew});

  @override
  final RecordDraft draft;
  @override
  final bool isNew;

  /// Create a copy of RecordEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecordEditorRequestCopyWith<_RecordEditorRequest> get copyWith =>
      __$RecordEditorRequestCopyWithImpl<_RecordEditorRequest>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordEditorRequest &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType, draft, isNew);

  @override
  String toString() {
    return 'RecordEditorRequest(draft: $draft, isNew: $isNew)';
  }
}

/// @nodoc
abstract mixin class _$RecordEditorRequestCopyWith<$Res>
    implements $RecordEditorRequestCopyWith<$Res> {
  factory _$RecordEditorRequestCopyWith(_RecordEditorRequest value,
          $Res Function(_RecordEditorRequest) _then) =
      __$RecordEditorRequestCopyWithImpl;
  @override
  @useResult
  $Res call({RecordDraft draft, bool isNew});
}

/// @nodoc
class __$RecordEditorRequestCopyWithImpl<$Res>
    implements _$RecordEditorRequestCopyWith<$Res> {
  __$RecordEditorRequestCopyWithImpl(this._self, this._then);

  final _RecordEditorRequest _self;
  final $Res Function(_RecordEditorRequest) _then;

  /// Create a copy of RecordEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? draft = null,
    Object? isNew = null,
  }) {
    return _then(_RecordEditorRequest(
      draft: null == draft
          ? _self.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as RecordDraft,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$BabyFoodEditorRequest {
  DateTime get initialDateTime;

  /// Create a copy of BabyFoodEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodEditorRequestCopyWith<BabyFoodEditorRequest> get copyWith =>
      _$BabyFoodEditorRequestCopyWithImpl<BabyFoodEditorRequest>(
          this as BabyFoodEditorRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodEditorRequest &&
            (identical(other.initialDateTime, initialDateTime) ||
                other.initialDateTime == initialDateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialDateTime);

  @override
  String toString() {
    return 'BabyFoodEditorRequest(initialDateTime: $initialDateTime)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodEditorRequestCopyWith<$Res> {
  factory $BabyFoodEditorRequestCopyWith(BabyFoodEditorRequest value,
          $Res Function(BabyFoodEditorRequest) _then) =
      _$BabyFoodEditorRequestCopyWithImpl;
  @useResult
  $Res call({DateTime initialDateTime});
}

/// @nodoc
class _$BabyFoodEditorRequestCopyWithImpl<$Res>
    implements $BabyFoodEditorRequestCopyWith<$Res> {
  _$BabyFoodEditorRequestCopyWithImpl(this._self, this._then);

  final BabyFoodEditorRequest _self;
  final $Res Function(BabyFoodEditorRequest) _then;

  /// Create a copy of BabyFoodEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialDateTime = null,
  }) {
    return _then(_self.copyWith(
      initialDateTime: null == initialDateTime
          ? _self.initialDateTime
          : initialDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [BabyFoodEditorRequest].
extension BabyFoodEditorRequestPatterns on BabyFoodEditorRequest {
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
    TResult Function(_BabyFoodEditorRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodEditorRequest() when $default != null:
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
    TResult Function(_BabyFoodEditorRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodEditorRequest():
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
    TResult? Function(_BabyFoodEditorRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodEditorRequest() when $default != null:
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
    TResult Function(DateTime initialDateTime)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodEditorRequest() when $default != null:
        return $default(_that.initialDateTime);
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
    TResult Function(DateTime initialDateTime) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodEditorRequest():
        return $default(_that.initialDateTime);
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
    TResult? Function(DateTime initialDateTime)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodEditorRequest() when $default != null:
        return $default(_that.initialDateTime);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BabyFoodEditorRequest implements BabyFoodEditorRequest {
  const _BabyFoodEditorRequest({required this.initialDateTime});

  @override
  final DateTime initialDateTime;

  /// Create a copy of BabyFoodEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodEditorRequestCopyWith<_BabyFoodEditorRequest> get copyWith =>
      __$BabyFoodEditorRequestCopyWithImpl<_BabyFoodEditorRequest>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodEditorRequest &&
            (identical(other.initialDateTime, initialDateTime) ||
                other.initialDateTime == initialDateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialDateTime);

  @override
  String toString() {
    return 'BabyFoodEditorRequest(initialDateTime: $initialDateTime)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodEditorRequestCopyWith<$Res>
    implements $BabyFoodEditorRequestCopyWith<$Res> {
  factory _$BabyFoodEditorRequestCopyWith(_BabyFoodEditorRequest value,
          $Res Function(_BabyFoodEditorRequest) _then) =
      __$BabyFoodEditorRequestCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime initialDateTime});
}

/// @nodoc
class __$BabyFoodEditorRequestCopyWithImpl<$Res>
    implements _$BabyFoodEditorRequestCopyWith<$Res> {
  __$BabyFoodEditorRequestCopyWithImpl(this._self, this._then);

  final _BabyFoodEditorRequest _self;
  final $Res Function(_BabyFoodEditorRequest) _then;

  /// Create a copy of BabyFoodEditorRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? initialDateTime = null,
  }) {
    return _then(_BabyFoodEditorRequest(
      initialDateTime: null == initialDateTime
          ? _self.initialDateTime
          : initialDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$RecordUiEvent {
  String? get message;
  RecordSlotRequest? get openSlot;
  RecordEditorRequest? get openEditor;
  BabyFoodEditorRequest? get openBabyFoodEditor;

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordUiEventCopyWith<RecordUiEvent> get copyWith =>
      _$RecordUiEventCopyWithImpl<RecordUiEvent>(
          this as RecordUiEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordUiEvent &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.openSlot, openSlot) ||
                other.openSlot == openSlot) &&
            (identical(other.openEditor, openEditor) ||
                other.openEditor == openEditor) &&
            (identical(other.openBabyFoodEditor, openBabyFoodEditor) ||
                other.openBabyFoodEditor == openBabyFoodEditor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, openSlot, openEditor, openBabyFoodEditor);

  @override
  String toString() {
    return 'RecordUiEvent(message: $message, openSlot: $openSlot, openEditor: $openEditor, openBabyFoodEditor: $openBabyFoodEditor)';
  }
}

/// @nodoc
abstract mixin class $RecordUiEventCopyWith<$Res> {
  factory $RecordUiEventCopyWith(
          RecordUiEvent value, $Res Function(RecordUiEvent) _then) =
      _$RecordUiEventCopyWithImpl;
  @useResult
  $Res call(
      {String? message,
      RecordSlotRequest? openSlot,
      RecordEditorRequest? openEditor,
      BabyFoodEditorRequest? openBabyFoodEditor});

  $RecordSlotRequestCopyWith<$Res>? get openSlot;
  $RecordEditorRequestCopyWith<$Res>? get openEditor;
  $BabyFoodEditorRequestCopyWith<$Res>? get openBabyFoodEditor;
}

/// @nodoc
class _$RecordUiEventCopyWithImpl<$Res>
    implements $RecordUiEventCopyWith<$Res> {
  _$RecordUiEventCopyWithImpl(this._self, this._then);

  final RecordUiEvent _self;
  final $Res Function(RecordUiEvent) _then;

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? openSlot = freezed,
    Object? openEditor = freezed,
    Object? openBabyFoodEditor = freezed,
  }) {
    return _then(_self.copyWith(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      openSlot: freezed == openSlot
          ? _self.openSlot
          : openSlot // ignore: cast_nullable_to_non_nullable
              as RecordSlotRequest?,
      openEditor: freezed == openEditor
          ? _self.openEditor
          : openEditor // ignore: cast_nullable_to_non_nullable
              as RecordEditorRequest?,
      openBabyFoodEditor: freezed == openBabyFoodEditor
          ? _self.openBabyFoodEditor
          : openBabyFoodEditor // ignore: cast_nullable_to_non_nullable
              as BabyFoodEditorRequest?,
    ));
  }

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordSlotRequestCopyWith<$Res>? get openSlot {
    if (_self.openSlot == null) {
      return null;
    }

    return $RecordSlotRequestCopyWith<$Res>(_self.openSlot!, (value) {
      return _then(_self.copyWith(openSlot: value));
    });
  }

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEditorRequestCopyWith<$Res>? get openEditor {
    if (_self.openEditor == null) {
      return null;
    }

    return $RecordEditorRequestCopyWith<$Res>(_self.openEditor!, (value) {
      return _then(_self.copyWith(openEditor: value));
    });
  }

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BabyFoodEditorRequestCopyWith<$Res>? get openBabyFoodEditor {
    if (_self.openBabyFoodEditor == null) {
      return null;
    }

    return $BabyFoodEditorRequestCopyWith<$Res>(_self.openBabyFoodEditor!,
        (value) {
      return _then(_self.copyWith(openBabyFoodEditor: value));
    });
  }
}

/// Adds pattern-matching-related methods to [RecordUiEvent].
extension RecordUiEventPatterns on RecordUiEvent {
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
    TResult Function(_RecordUiEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordUiEvent() when $default != null:
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
    TResult Function(_RecordUiEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordUiEvent():
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
    TResult? Function(_RecordUiEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordUiEvent() when $default != null:
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
            String? message,
            RecordSlotRequest? openSlot,
            RecordEditorRequest? openEditor,
            BabyFoodEditorRequest? openBabyFoodEditor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordUiEvent() when $default != null:
        return $default(_that.message, _that.openSlot, _that.openEditor,
            _that.openBabyFoodEditor);
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
            String? message,
            RecordSlotRequest? openSlot,
            RecordEditorRequest? openEditor,
            BabyFoodEditorRequest? openBabyFoodEditor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordUiEvent():
        return $default(_that.message, _that.openSlot, _that.openEditor,
            _that.openBabyFoodEditor);
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
            String? message,
            RecordSlotRequest? openSlot,
            RecordEditorRequest? openEditor,
            BabyFoodEditorRequest? openBabyFoodEditor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordUiEvent() when $default != null:
        return $default(_that.message, _that.openSlot, _that.openEditor,
            _that.openBabyFoodEditor);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecordUiEvent implements RecordUiEvent {
  const _RecordUiEvent(
      {this.message, this.openSlot, this.openEditor, this.openBabyFoodEditor});

  @override
  final String? message;
  @override
  final RecordSlotRequest? openSlot;
  @override
  final RecordEditorRequest? openEditor;
  @override
  final BabyFoodEditorRequest? openBabyFoodEditor;

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecordUiEventCopyWith<_RecordUiEvent> get copyWith =>
      __$RecordUiEventCopyWithImpl<_RecordUiEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordUiEvent &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.openSlot, openSlot) ||
                other.openSlot == openSlot) &&
            (identical(other.openEditor, openEditor) ||
                other.openEditor == openEditor) &&
            (identical(other.openBabyFoodEditor, openBabyFoodEditor) ||
                other.openBabyFoodEditor == openBabyFoodEditor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, openSlot, openEditor, openBabyFoodEditor);

  @override
  String toString() {
    return 'RecordUiEvent(message: $message, openSlot: $openSlot, openEditor: $openEditor, openBabyFoodEditor: $openBabyFoodEditor)';
  }
}

/// @nodoc
abstract mixin class _$RecordUiEventCopyWith<$Res>
    implements $RecordUiEventCopyWith<$Res> {
  factory _$RecordUiEventCopyWith(
          _RecordUiEvent value, $Res Function(_RecordUiEvent) _then) =
      __$RecordUiEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? message,
      RecordSlotRequest? openSlot,
      RecordEditorRequest? openEditor,
      BabyFoodEditorRequest? openBabyFoodEditor});

  @override
  $RecordSlotRequestCopyWith<$Res>? get openSlot;
  @override
  $RecordEditorRequestCopyWith<$Res>? get openEditor;
  @override
  $BabyFoodEditorRequestCopyWith<$Res>? get openBabyFoodEditor;
}

/// @nodoc
class __$RecordUiEventCopyWithImpl<$Res>
    implements _$RecordUiEventCopyWith<$Res> {
  __$RecordUiEventCopyWithImpl(this._self, this._then);

  final _RecordUiEvent _self;
  final $Res Function(_RecordUiEvent) _then;

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
    Object? openSlot = freezed,
    Object? openEditor = freezed,
    Object? openBabyFoodEditor = freezed,
  }) {
    return _then(_RecordUiEvent(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      openSlot: freezed == openSlot
          ? _self.openSlot
          : openSlot // ignore: cast_nullable_to_non_nullable
              as RecordSlotRequest?,
      openEditor: freezed == openEditor
          ? _self.openEditor
          : openEditor // ignore: cast_nullable_to_non_nullable
              as RecordEditorRequest?,
      openBabyFoodEditor: freezed == openBabyFoodEditor
          ? _self.openBabyFoodEditor
          : openBabyFoodEditor // ignore: cast_nullable_to_non_nullable
              as BabyFoodEditorRequest?,
    ));
  }

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordSlotRequestCopyWith<$Res>? get openSlot {
    if (_self.openSlot == null) {
      return null;
    }

    return $RecordSlotRequestCopyWith<$Res>(_self.openSlot!, (value) {
      return _then(_self.copyWith(openSlot: value));
    });
  }

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEditorRequestCopyWith<$Res>? get openEditor {
    if (_self.openEditor == null) {
      return null;
    }

    return $RecordEditorRequestCopyWith<$Res>(_self.openEditor!, (value) {
      return _then(_self.copyWith(openEditor: value));
    });
  }

  /// Create a copy of RecordUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BabyFoodEditorRequestCopyWith<$Res>? get openBabyFoodEditor {
    if (_self.openBabyFoodEditor == null) {
      return null;
    }

    return $BabyFoodEditorRequestCopyWith<$Res>(_self.openBabyFoodEditor!,
        (value) {
      return _then(_self.copyWith(openBabyFoodEditor: value));
    });
  }
}

/// @nodoc
mixin _$RecordPageState {
  DateTime get selectedDate;
  int get selectedTabIndex;
  bool get isProcessing;
  RecordUiEvent? get pendingUiEvent;
  RecordDraft? get activeDraft;

  /// Create a copy of RecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordPageStateCopyWith<RecordPageState> get copyWith =>
      _$RecordPageStateCopyWithImpl<RecordPageState>(
          this as RecordPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordPageState &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent) &&
            (identical(other.activeDraft, activeDraft) ||
                other.activeDraft == activeDraft));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, selectedTabIndex,
      isProcessing, pendingUiEvent, activeDraft);

  @override
  String toString() {
    return 'RecordPageState(selectedDate: $selectedDate, selectedTabIndex: $selectedTabIndex, isProcessing: $isProcessing, pendingUiEvent: $pendingUiEvent, activeDraft: $activeDraft)';
  }
}

/// @nodoc
abstract mixin class $RecordPageStateCopyWith<$Res> {
  factory $RecordPageStateCopyWith(
          RecordPageState value, $Res Function(RecordPageState) _then) =
      _$RecordPageStateCopyWithImpl;
  @useResult
  $Res call(
      {DateTime selectedDate,
      int selectedTabIndex,
      bool isProcessing,
      RecordUiEvent? pendingUiEvent,
      RecordDraft? activeDraft});

  $RecordUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class _$RecordPageStateCopyWithImpl<$Res>
    implements $RecordPageStateCopyWith<$Res> {
  _$RecordPageStateCopyWithImpl(this._self, this._then);

  final RecordPageState _self;
  final $Res Function(RecordPageState) _then;

  /// Create a copy of RecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? selectedTabIndex = null,
    Object? isProcessing = null,
    Object? pendingUiEvent = freezed,
    Object? activeDraft = freezed,
  }) {
    return _then(_self.copyWith(
      selectedDate: null == selectedDate
          ? _self.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedTabIndex: null == selectedTabIndex
          ? _self.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as RecordUiEvent?,
      activeDraft: freezed == activeDraft
          ? _self.activeDraft
          : activeDraft // ignore: cast_nullable_to_non_nullable
              as RecordDraft?,
    ));
  }

  /// Create a copy of RecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $RecordUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [RecordPageState].
extension RecordPageStatePatterns on RecordPageState {
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
    TResult Function(_RecordPageState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordPageState() when $default != null:
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
    TResult Function(_RecordPageState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordPageState():
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
    TResult? Function(_RecordPageState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordPageState() when $default != null:
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
            DateTime selectedDate,
            int selectedTabIndex,
            bool isProcessing,
            RecordUiEvent? pendingUiEvent,
            RecordDraft? activeDraft)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordPageState() when $default != null:
        return $default(_that.selectedDate, _that.selectedTabIndex,
            _that.isProcessing, _that.pendingUiEvent, _that.activeDraft);
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
            DateTime selectedDate,
            int selectedTabIndex,
            bool isProcessing,
            RecordUiEvent? pendingUiEvent,
            RecordDraft? activeDraft)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordPageState():
        return $default(_that.selectedDate, _that.selectedTabIndex,
            _that.isProcessing, _that.pendingUiEvent, _that.activeDraft);
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
            DateTime selectedDate,
            int selectedTabIndex,
            bool isProcessing,
            RecordUiEvent? pendingUiEvent,
            RecordDraft? activeDraft)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordPageState() when $default != null:
        return $default(_that.selectedDate, _that.selectedTabIndex,
            _that.isProcessing, _that.pendingUiEvent, _that.activeDraft);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecordPageState implements RecordPageState {
  const _RecordPageState(
      {required this.selectedDate,
      required this.selectedTabIndex,
      this.isProcessing = false,
      this.pendingUiEvent,
      this.activeDraft});

  @override
  final DateTime selectedDate;
  @override
  final int selectedTabIndex;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final RecordUiEvent? pendingUiEvent;
  @override
  final RecordDraft? activeDraft;

  /// Create a copy of RecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecordPageStateCopyWith<_RecordPageState> get copyWith =>
      __$RecordPageStateCopyWithImpl<_RecordPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordPageState &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent) &&
            (identical(other.activeDraft, activeDraft) ||
                other.activeDraft == activeDraft));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, selectedTabIndex,
      isProcessing, pendingUiEvent, activeDraft);

  @override
  String toString() {
    return 'RecordPageState(selectedDate: $selectedDate, selectedTabIndex: $selectedTabIndex, isProcessing: $isProcessing, pendingUiEvent: $pendingUiEvent, activeDraft: $activeDraft)';
  }
}

/// @nodoc
abstract mixin class _$RecordPageStateCopyWith<$Res>
    implements $RecordPageStateCopyWith<$Res> {
  factory _$RecordPageStateCopyWith(
          _RecordPageState value, $Res Function(_RecordPageState) _then) =
      __$RecordPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime selectedDate,
      int selectedTabIndex,
      bool isProcessing,
      RecordUiEvent? pendingUiEvent,
      RecordDraft? activeDraft});

  @override
  $RecordUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class __$RecordPageStateCopyWithImpl<$Res>
    implements _$RecordPageStateCopyWith<$Res> {
  __$RecordPageStateCopyWithImpl(this._self, this._then);

  final _RecordPageState _self;
  final $Res Function(_RecordPageState) _then;

  /// Create a copy of RecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedDate = null,
    Object? selectedTabIndex = null,
    Object? isProcessing = null,
    Object? pendingUiEvent = freezed,
    Object? activeDraft = freezed,
  }) {
    return _then(_RecordPageState(
      selectedDate: null == selectedDate
          ? _self.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedTabIndex: null == selectedTabIndex
          ? _self.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as RecordUiEvent?,
      activeDraft: freezed == activeDraft
          ? _self.activeDraft
          : activeDraft // ignore: cast_nullable_to_non_nullable
              as RecordDraft?,
    ));
  }

  /// Create a copy of RecordPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $RecordUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

// dart format on
