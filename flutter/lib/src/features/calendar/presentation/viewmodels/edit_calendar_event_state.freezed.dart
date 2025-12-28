// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_calendar_event_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditCalendarEventState {
  String get eventId;
  String get title;
  String get memo;
  bool get allDay;
  DateTime get startDate;
  TimeOfDay get startTime;
  DateTime get endDate;
  TimeOfDay get endTime;
  String get selectedIconPath;
  List<String> get availableIconPaths;
  String? get titleError;
  String? get dateTimeError;
  bool get isSubmitting;
  bool get isDeleting;

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditCalendarEventStateCopyWith<EditCalendarEventState> get copyWith =>
      _$EditCalendarEventStateCopyWithImpl<EditCalendarEventState>(
          this as EditCalendarEventState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditCalendarEventState &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.selectedIconPath, selectedIconPath) ||
                other.selectedIconPath == selectedIconPath) &&
            const DeepCollectionEquality()
                .equals(other.availableIconPaths, availableIconPaths) &&
            (identical(other.titleError, titleError) ||
                other.titleError == titleError) &&
            (identical(other.dateTimeError, dateTimeError) ||
                other.dateTimeError == dateTimeError) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      title,
      memo,
      allDay,
      startDate,
      startTime,
      endDate,
      endTime,
      selectedIconPath,
      const DeepCollectionEquality().hash(availableIconPaths),
      titleError,
      dateTimeError,
      isSubmitting,
      isDeleting);

  @override
  String toString() {
    return 'EditCalendarEventState(eventId: $eventId, title: $title, memo: $memo, allDay: $allDay, startDate: $startDate, startTime: $startTime, endDate: $endDate, endTime: $endTime, selectedIconPath: $selectedIconPath, availableIconPaths: $availableIconPaths, titleError: $titleError, dateTimeError: $dateTimeError, isSubmitting: $isSubmitting, isDeleting: $isDeleting)';
  }
}

/// @nodoc
abstract mixin class $EditCalendarEventStateCopyWith<$Res> {
  factory $EditCalendarEventStateCopyWith(EditCalendarEventState value,
          $Res Function(EditCalendarEventState) _then) =
      _$EditCalendarEventStateCopyWithImpl;
  @useResult
  $Res call(
      {String eventId,
      String title,
      String memo,
      bool allDay,
      DateTime startDate,
      TimeOfDay startTime,
      DateTime endDate,
      TimeOfDay endTime,
      String selectedIconPath,
      List<String> availableIconPaths,
      String? titleError,
      String? dateTimeError,
      bool isSubmitting,
      bool isDeleting});

  $TimeOfDayCopyWith<$Res> get startTime;
  $TimeOfDayCopyWith<$Res> get endTime;
}

/// @nodoc
class _$EditCalendarEventStateCopyWithImpl<$Res>
    implements $EditCalendarEventStateCopyWith<$Res> {
  _$EditCalendarEventStateCopyWithImpl(this._self, this._then);

  final EditCalendarEventState _self;
  final $Res Function(EditCalendarEventState) _then;

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? title = null,
    Object? memo = null,
    Object? allDay = null,
    Object? startDate = null,
    Object? startTime = null,
    Object? endDate = null,
    Object? endTime = null,
    Object? selectedIconPath = null,
    Object? availableIconPaths = null,
    Object? titleError = freezed,
    Object? dateTimeError = freezed,
    Object? isSubmitting = null,
    Object? isDeleting = null,
  }) {
    return _then(_self.copyWith(
      eventId: null == eventId
          ? _self.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _self.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      allDay: null == allDay
          ? _self.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      selectedIconPath: null == selectedIconPath
          ? _self.selectedIconPath
          : selectedIconPath // ignore: cast_nullable_to_non_nullable
              as String,
      availableIconPaths: null == availableIconPaths
          ? _self.availableIconPaths
          : availableIconPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      titleError: freezed == titleError
          ? _self.titleError
          : titleError // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimeError: freezed == dateTimeError
          ? _self.dateTimeError
          : dateTimeError // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleting: null == isDeleting
          ? _self.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res> get startTime {
    return $TimeOfDayCopyWith<$Res>(_self.startTime, (value) {
      return _then(_self.copyWith(startTime: value));
    });
  }

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res> get endTime {
    return $TimeOfDayCopyWith<$Res>(_self.endTime, (value) {
      return _then(_self.copyWith(endTime: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EditCalendarEventState].
extension EditCalendarEventStatePatterns on EditCalendarEventState {
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
    TResult Function(_EditCalendarEventState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditCalendarEventState() when $default != null:
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
    TResult Function(_EditCalendarEventState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditCalendarEventState():
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
    TResult? Function(_EditCalendarEventState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditCalendarEventState() when $default != null:
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
            String eventId,
            String title,
            String memo,
            bool allDay,
            DateTime startDate,
            TimeOfDay startTime,
            DateTime endDate,
            TimeOfDay endTime,
            String selectedIconPath,
            List<String> availableIconPaths,
            String? titleError,
            String? dateTimeError,
            bool isSubmitting,
            bool isDeleting)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditCalendarEventState() when $default != null:
        return $default(
            _that.eventId,
            _that.title,
            _that.memo,
            _that.allDay,
            _that.startDate,
            _that.startTime,
            _that.endDate,
            _that.endTime,
            _that.selectedIconPath,
            _that.availableIconPaths,
            _that.titleError,
            _that.dateTimeError,
            _that.isSubmitting,
            _that.isDeleting);
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
            String eventId,
            String title,
            String memo,
            bool allDay,
            DateTime startDate,
            TimeOfDay startTime,
            DateTime endDate,
            TimeOfDay endTime,
            String selectedIconPath,
            List<String> availableIconPaths,
            String? titleError,
            String? dateTimeError,
            bool isSubmitting,
            bool isDeleting)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditCalendarEventState():
        return $default(
            _that.eventId,
            _that.title,
            _that.memo,
            _that.allDay,
            _that.startDate,
            _that.startTime,
            _that.endDate,
            _that.endTime,
            _that.selectedIconPath,
            _that.availableIconPaths,
            _that.titleError,
            _that.dateTimeError,
            _that.isSubmitting,
            _that.isDeleting);
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
            String eventId,
            String title,
            String memo,
            bool allDay,
            DateTime startDate,
            TimeOfDay startTime,
            DateTime endDate,
            TimeOfDay endTime,
            String selectedIconPath,
            List<String> availableIconPaths,
            String? titleError,
            String? dateTimeError,
            bool isSubmitting,
            bool isDeleting)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditCalendarEventState() when $default != null:
        return $default(
            _that.eventId,
            _that.title,
            _that.memo,
            _that.allDay,
            _that.startDate,
            _that.startTime,
            _that.endDate,
            _that.endTime,
            _that.selectedIconPath,
            _that.availableIconPaths,
            _that.titleError,
            _that.dateTimeError,
            _that.isSubmitting,
            _that.isDeleting);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EditCalendarEventState extends EditCalendarEventState {
  const _EditCalendarEventState(
      {required this.eventId,
      required this.title,
      required this.memo,
      required this.allDay,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime,
      required this.selectedIconPath,
      required final List<String> availableIconPaths,
      this.titleError,
      this.dateTimeError,
      this.isSubmitting = false,
      this.isDeleting = false})
      : _availableIconPaths = availableIconPaths,
        super._();

  @override
  final String eventId;
  @override
  final String title;
  @override
  final String memo;
  @override
  final bool allDay;
  @override
  final DateTime startDate;
  @override
  final TimeOfDay startTime;
  @override
  final DateTime endDate;
  @override
  final TimeOfDay endTime;
  @override
  final String selectedIconPath;
  final List<String> _availableIconPaths;
  @override
  List<String> get availableIconPaths {
    if (_availableIconPaths is EqualUnmodifiableListView)
      return _availableIconPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableIconPaths);
  }

  @override
  final String? titleError;
  @override
  final String? dateTimeError;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isDeleting;

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditCalendarEventStateCopyWith<_EditCalendarEventState> get copyWith =>
      __$EditCalendarEventStateCopyWithImpl<_EditCalendarEventState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditCalendarEventState &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.selectedIconPath, selectedIconPath) ||
                other.selectedIconPath == selectedIconPath) &&
            const DeepCollectionEquality()
                .equals(other._availableIconPaths, _availableIconPaths) &&
            (identical(other.titleError, titleError) ||
                other.titleError == titleError) &&
            (identical(other.dateTimeError, dateTimeError) ||
                other.dateTimeError == dateTimeError) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      title,
      memo,
      allDay,
      startDate,
      startTime,
      endDate,
      endTime,
      selectedIconPath,
      const DeepCollectionEquality().hash(_availableIconPaths),
      titleError,
      dateTimeError,
      isSubmitting,
      isDeleting);

  @override
  String toString() {
    return 'EditCalendarEventState(eventId: $eventId, title: $title, memo: $memo, allDay: $allDay, startDate: $startDate, startTime: $startTime, endDate: $endDate, endTime: $endTime, selectedIconPath: $selectedIconPath, availableIconPaths: $availableIconPaths, titleError: $titleError, dateTimeError: $dateTimeError, isSubmitting: $isSubmitting, isDeleting: $isDeleting)';
  }
}

/// @nodoc
abstract mixin class _$EditCalendarEventStateCopyWith<$Res>
    implements $EditCalendarEventStateCopyWith<$Res> {
  factory _$EditCalendarEventStateCopyWith(_EditCalendarEventState value,
          $Res Function(_EditCalendarEventState) _then) =
      __$EditCalendarEventStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String eventId,
      String title,
      String memo,
      bool allDay,
      DateTime startDate,
      TimeOfDay startTime,
      DateTime endDate,
      TimeOfDay endTime,
      String selectedIconPath,
      List<String> availableIconPaths,
      String? titleError,
      String? dateTimeError,
      bool isSubmitting,
      bool isDeleting});

  @override
  $TimeOfDayCopyWith<$Res> get startTime;
  @override
  $TimeOfDayCopyWith<$Res> get endTime;
}

/// @nodoc
class __$EditCalendarEventStateCopyWithImpl<$Res>
    implements _$EditCalendarEventStateCopyWith<$Res> {
  __$EditCalendarEventStateCopyWithImpl(this._self, this._then);

  final _EditCalendarEventState _self;
  final $Res Function(_EditCalendarEventState) _then;

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? eventId = null,
    Object? title = null,
    Object? memo = null,
    Object? allDay = null,
    Object? startDate = null,
    Object? startTime = null,
    Object? endDate = null,
    Object? endTime = null,
    Object? selectedIconPath = null,
    Object? availableIconPaths = null,
    Object? titleError = freezed,
    Object? dateTimeError = freezed,
    Object? isSubmitting = null,
    Object? isDeleting = null,
  }) {
    return _then(_EditCalendarEventState(
      eventId: null == eventId
          ? _self.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _self.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      allDay: null == allDay
          ? _self.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      selectedIconPath: null == selectedIconPath
          ? _self.selectedIconPath
          : selectedIconPath // ignore: cast_nullable_to_non_nullable
              as String,
      availableIconPaths: null == availableIconPaths
          ? _self._availableIconPaths
          : availableIconPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      titleError: freezed == titleError
          ? _self.titleError
          : titleError // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimeError: freezed == dateTimeError
          ? _self.dateTimeError
          : dateTimeError // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleting: null == isDeleting
          ? _self.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res> get startTime {
    return $TimeOfDayCopyWith<$Res>(_self.startTime, (value) {
      return _then(_self.copyWith(startTime: value));
    });
  }

  /// Create a copy of EditCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res> get endTime {
    return $TimeOfDayCopyWith<$Res>(_self.endTime, (value) {
      return _then(_self.copyWith(endTime: value));
    });
  }
}

/// @nodoc
mixin _$TimeOfDay {
  int get hour;
  int get minute;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<TimeOfDay> get copyWith =>
      _$TimeOfDayCopyWithImpl<TimeOfDay>(this as TimeOfDay, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimeOfDay &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  @override
  String toString() {
    return 'TimeOfDay(hour: $hour, minute: $minute)';
  }
}

/// @nodoc
abstract mixin class $TimeOfDayCopyWith<$Res> {
  factory $TimeOfDayCopyWith(TimeOfDay value, $Res Function(TimeOfDay) _then) =
      _$TimeOfDayCopyWithImpl;
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class _$TimeOfDayCopyWithImpl<$Res> implements $TimeOfDayCopyWith<$Res> {
  _$TimeOfDayCopyWithImpl(this._self, this._then);

  final TimeOfDay _self;
  final $Res Function(TimeOfDay) _then;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_self.copyWith(
      hour: null == hour
          ? _self.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _self.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimeOfDay].
extension TimeOfDayPatterns on TimeOfDay {
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
    TResult Function(_TimeOfDay value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeOfDay() when $default != null:
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
    TResult Function(_TimeOfDay value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeOfDay():
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
    TResult? Function(_TimeOfDay value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeOfDay() when $default != null:
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
    TResult Function(int hour, int minute)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeOfDay() when $default != null:
        return $default(_that.hour, _that.minute);
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
    TResult Function(int hour, int minute) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeOfDay():
        return $default(_that.hour, _that.minute);
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
    TResult? Function(int hour, int minute)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeOfDay() when $default != null:
        return $default(_that.hour, _that.minute);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TimeOfDay extends TimeOfDay {
  const _TimeOfDay({required this.hour, required this.minute}) : super._();

  @override
  final int hour;
  @override
  final int minute;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimeOfDayCopyWith<_TimeOfDay> get copyWith =>
      __$TimeOfDayCopyWithImpl<_TimeOfDay>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimeOfDay &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  @override
  String toString() {
    return 'TimeOfDay(hour: $hour, minute: $minute)';
  }
}

/// @nodoc
abstract mixin class _$TimeOfDayCopyWith<$Res>
    implements $TimeOfDayCopyWith<$Res> {
  factory _$TimeOfDayCopyWith(
          _TimeOfDay value, $Res Function(_TimeOfDay) _then) =
      __$TimeOfDayCopyWithImpl;
  @override
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class __$TimeOfDayCopyWithImpl<$Res> implements _$TimeOfDayCopyWith<$Res> {
  __$TimeOfDayCopyWithImpl(this._self, this._then);

  final _TimeOfDay _self;
  final $Res Function(_TimeOfDay) _then;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_TimeOfDay(
      hour: null == hour
          ? _self.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _self.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
