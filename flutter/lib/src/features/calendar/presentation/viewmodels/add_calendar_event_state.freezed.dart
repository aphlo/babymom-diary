// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_calendar_event_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddCalendarEventState {
  String get title;
  String get memo;
  bool get allDay;
  DateTime get startDate;
  DateTime get endDate;
  TimeOfDay get startTime;
  TimeOfDay get endTime;
  String get selectedIconPath;
  bool get isSubmitting;
  String? get titleError;
  String? get dateTimeError;
  List<String> get availableIconPaths;

  /// Create a copy of AddCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddCalendarEventStateCopyWith<AddCalendarEventState> get copyWith =>
      _$AddCalendarEventStateCopyWithImpl<AddCalendarEventState>(
          this as AddCalendarEventState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddCalendarEventState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.selectedIconPath, selectedIconPath) ||
                other.selectedIconPath == selectedIconPath) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.titleError, titleError) ||
                other.titleError == titleError) &&
            (identical(other.dateTimeError, dateTimeError) ||
                other.dateTimeError == dateTimeError) &&
            const DeepCollectionEquality()
                .equals(other.availableIconPaths, availableIconPaths));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      memo,
      allDay,
      startDate,
      endDate,
      startTime,
      endTime,
      selectedIconPath,
      isSubmitting,
      titleError,
      dateTimeError,
      const DeepCollectionEquality().hash(availableIconPaths));

  @override
  String toString() {
    return 'AddCalendarEventState(title: $title, memo: $memo, allDay: $allDay, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, selectedIconPath: $selectedIconPath, isSubmitting: $isSubmitting, titleError: $titleError, dateTimeError: $dateTimeError, availableIconPaths: $availableIconPaths)';
  }
}

/// @nodoc
abstract mixin class $AddCalendarEventStateCopyWith<$Res> {
  factory $AddCalendarEventStateCopyWith(AddCalendarEventState value,
          $Res Function(AddCalendarEventState) _then) =
      _$AddCalendarEventStateCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      String memo,
      bool allDay,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay startTime,
      TimeOfDay endTime,
      String selectedIconPath,
      bool isSubmitting,
      String? titleError,
      String? dateTimeError,
      List<String> availableIconPaths});
}

/// @nodoc
class _$AddCalendarEventStateCopyWithImpl<$Res>
    implements $AddCalendarEventStateCopyWith<$Res> {
  _$AddCalendarEventStateCopyWithImpl(this._self, this._then);

  final AddCalendarEventState _self;
  final $Res Function(AddCalendarEventState) _then;

  /// Create a copy of AddCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? memo = null,
    Object? allDay = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? selectedIconPath = null,
    Object? isSubmitting = null,
    Object? titleError = freezed,
    Object? dateTimeError = freezed,
    Object? availableIconPaths = null,
  }) {
    return _then(_self.copyWith(
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
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      selectedIconPath: null == selectedIconPath
          ? _self.selectedIconPath
          : selectedIconPath // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      titleError: freezed == titleError
          ? _self.titleError
          : titleError // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimeError: freezed == dateTimeError
          ? _self.dateTimeError
          : dateTimeError // ignore: cast_nullable_to_non_nullable
              as String?,
      availableIconPaths: null == availableIconPaths
          ? _self.availableIconPaths
          : availableIconPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AddCalendarEventState].
extension AddCalendarEventStatePatterns on AddCalendarEventState {
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
    TResult Function(_AddCalendarEventState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddCalendarEventState() when $default != null:
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
    TResult Function(_AddCalendarEventState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCalendarEventState():
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
    TResult? Function(_AddCalendarEventState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCalendarEventState() when $default != null:
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
            String title,
            String memo,
            bool allDay,
            DateTime startDate,
            DateTime endDate,
            TimeOfDay startTime,
            TimeOfDay endTime,
            String selectedIconPath,
            bool isSubmitting,
            String? titleError,
            String? dateTimeError,
            List<String> availableIconPaths)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddCalendarEventState() when $default != null:
        return $default(
            _that.title,
            _that.memo,
            _that.allDay,
            _that.startDate,
            _that.endDate,
            _that.startTime,
            _that.endTime,
            _that.selectedIconPath,
            _that.isSubmitting,
            _that.titleError,
            _that.dateTimeError,
            _that.availableIconPaths);
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
            String title,
            String memo,
            bool allDay,
            DateTime startDate,
            DateTime endDate,
            TimeOfDay startTime,
            TimeOfDay endTime,
            String selectedIconPath,
            bool isSubmitting,
            String? titleError,
            String? dateTimeError,
            List<String> availableIconPaths)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCalendarEventState():
        return $default(
            _that.title,
            _that.memo,
            _that.allDay,
            _that.startDate,
            _that.endDate,
            _that.startTime,
            _that.endTime,
            _that.selectedIconPath,
            _that.isSubmitting,
            _that.titleError,
            _that.dateTimeError,
            _that.availableIconPaths);
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
            String title,
            String memo,
            bool allDay,
            DateTime startDate,
            DateTime endDate,
            TimeOfDay startTime,
            TimeOfDay endTime,
            String selectedIconPath,
            bool isSubmitting,
            String? titleError,
            String? dateTimeError,
            List<String> availableIconPaths)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCalendarEventState() when $default != null:
        return $default(
            _that.title,
            _that.memo,
            _that.allDay,
            _that.startDate,
            _that.endDate,
            _that.startTime,
            _that.endTime,
            _that.selectedIconPath,
            _that.isSubmitting,
            _that.titleError,
            _that.dateTimeError,
            _that.availableIconPaths);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AddCalendarEventState extends AddCalendarEventState {
  const _AddCalendarEventState(
      {required this.title,
      required this.memo,
      required this.allDay,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.selectedIconPath,
      required this.isSubmitting,
      this.titleError,
      this.dateTimeError,
      required final List<String> availableIconPaths})
      : _availableIconPaths = availableIconPaths,
        super._();

  @override
  final String title;
  @override
  final String memo;
  @override
  final bool allDay;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final TimeOfDay startTime;
  @override
  final TimeOfDay endTime;
  @override
  final String selectedIconPath;
  @override
  final bool isSubmitting;
  @override
  final String? titleError;
  @override
  final String? dateTimeError;
  final List<String> _availableIconPaths;
  @override
  List<String> get availableIconPaths {
    if (_availableIconPaths is EqualUnmodifiableListView)
      return _availableIconPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableIconPaths);
  }

  /// Create a copy of AddCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddCalendarEventStateCopyWith<_AddCalendarEventState> get copyWith =>
      __$AddCalendarEventStateCopyWithImpl<_AddCalendarEventState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddCalendarEventState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.selectedIconPath, selectedIconPath) ||
                other.selectedIconPath == selectedIconPath) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.titleError, titleError) ||
                other.titleError == titleError) &&
            (identical(other.dateTimeError, dateTimeError) ||
                other.dateTimeError == dateTimeError) &&
            const DeepCollectionEquality()
                .equals(other._availableIconPaths, _availableIconPaths));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      memo,
      allDay,
      startDate,
      endDate,
      startTime,
      endTime,
      selectedIconPath,
      isSubmitting,
      titleError,
      dateTimeError,
      const DeepCollectionEquality().hash(_availableIconPaths));

  @override
  String toString() {
    return 'AddCalendarEventState(title: $title, memo: $memo, allDay: $allDay, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, selectedIconPath: $selectedIconPath, isSubmitting: $isSubmitting, titleError: $titleError, dateTimeError: $dateTimeError, availableIconPaths: $availableIconPaths)';
  }
}

/// @nodoc
abstract mixin class _$AddCalendarEventStateCopyWith<$Res>
    implements $AddCalendarEventStateCopyWith<$Res> {
  factory _$AddCalendarEventStateCopyWith(_AddCalendarEventState value,
          $Res Function(_AddCalendarEventState) _then) =
      __$AddCalendarEventStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      String memo,
      bool allDay,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay startTime,
      TimeOfDay endTime,
      String selectedIconPath,
      bool isSubmitting,
      String? titleError,
      String? dateTimeError,
      List<String> availableIconPaths});
}

/// @nodoc
class __$AddCalendarEventStateCopyWithImpl<$Res>
    implements _$AddCalendarEventStateCopyWith<$Res> {
  __$AddCalendarEventStateCopyWithImpl(this._self, this._then);

  final _AddCalendarEventState _self;
  final $Res Function(_AddCalendarEventState) _then;

  /// Create a copy of AddCalendarEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? memo = null,
    Object? allDay = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? selectedIconPath = null,
    Object? isSubmitting = null,
    Object? titleError = freezed,
    Object? dateTimeError = freezed,
    Object? availableIconPaths = null,
  }) {
    return _then(_AddCalendarEventState(
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
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      selectedIconPath: null == selectedIconPath
          ? _self.selectedIconPath
          : selectedIconPath // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      titleError: freezed == titleError
          ? _self.titleError
          : titleError // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimeError: freezed == dateTimeError
          ? _self.dateTimeError
          : dateTimeError // ignore: cast_nullable_to_non_nullable
              as String?,
      availableIconPaths: null == availableIconPaths
          ? _self._availableIconPaths
          : availableIconPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
