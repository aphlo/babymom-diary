// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarUiEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CalendarUiEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CalendarUiEvent()';
  }
}

/// @nodoc
class $CalendarUiEventCopyWith<$Res> {
  $CalendarUiEventCopyWith(
      CalendarUiEvent _, $Res Function(CalendarUiEvent) __);
}

/// Adds pattern-matching-related methods to [CalendarUiEvent].
extension CalendarUiEventPatterns on CalendarUiEvent {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowMessage value)? showMessage,
    TResult Function(_OpenAddEvent value)? openAddEvent,
    TResult Function(_OpenSettings value)? openSettings,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _OpenAddEvent() when openAddEvent != null:
        return openAddEvent(_that);
      case _OpenSettings() when openSettings != null:
        return openSettings(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowMessage value) showMessage,
    required TResult Function(_OpenAddEvent value) openAddEvent,
    required TResult Function(_OpenSettings value) openSettings,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that);
      case _OpenAddEvent():
        return openAddEvent(_that);
      case _OpenSettings():
        return openSettings(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ShowMessage value)? showMessage,
    TResult? Function(_OpenAddEvent value)? openAddEvent,
    TResult? Function(_OpenSettings value)? openSettings,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _OpenAddEvent() when openAddEvent != null:
        return openAddEvent(_that);
      case _OpenSettings() when openSettings != null:
        return openSettings(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showMessage,
    TResult Function(AddEventRequest request)? openAddEvent,
    TResult Function()? openSettings,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _OpenAddEvent() when openAddEvent != null:
        return openAddEvent(_that.request);
      case _OpenSettings() when openSettings != null:
        return openSettings();
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
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showMessage,
    required TResult Function(AddEventRequest request) openAddEvent,
    required TResult Function() openSettings,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that.message);
      case _OpenAddEvent():
        return openAddEvent(_that.request);
      case _OpenSettings():
        return openSettings();
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showMessage,
    TResult? Function(AddEventRequest request)? openAddEvent,
    TResult? Function()? openSettings,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _OpenAddEvent() when openAddEvent != null:
        return openAddEvent(_that.request);
      case _OpenSettings() when openSettings != null:
        return openSettings();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShowMessage implements CalendarUiEvent {
  const _ShowMessage(this.message);

  final String message;

  /// Create a copy of CalendarUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShowMessageCopyWith<_ShowMessage> get copyWith =>
      __$ShowMessageCopyWithImpl<_ShowMessage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShowMessage &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'CalendarUiEvent.showMessage(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ShowMessageCopyWith<$Res>
    implements $CalendarUiEventCopyWith<$Res> {
  factory _$ShowMessageCopyWith(
          _ShowMessage value, $Res Function(_ShowMessage) _then) =
      __$ShowMessageCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ShowMessageCopyWithImpl<$Res> implements _$ShowMessageCopyWith<$Res> {
  __$ShowMessageCopyWithImpl(this._self, this._then);

  final _ShowMessage _self;
  final $Res Function(_ShowMessage) _then;

  /// Create a copy of CalendarUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_ShowMessage(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _OpenAddEvent implements CalendarUiEvent {
  const _OpenAddEvent(this.request);

  final AddEventRequest request;

  /// Create a copy of CalendarUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OpenAddEventCopyWith<_OpenAddEvent> get copyWith =>
      __$OpenAddEventCopyWithImpl<_OpenAddEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OpenAddEvent &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'CalendarUiEvent.openAddEvent(request: $request)';
  }
}

/// @nodoc
abstract mixin class _$OpenAddEventCopyWith<$Res>
    implements $CalendarUiEventCopyWith<$Res> {
  factory _$OpenAddEventCopyWith(
          _OpenAddEvent value, $Res Function(_OpenAddEvent) _then) =
      __$OpenAddEventCopyWithImpl;
  @useResult
  $Res call({AddEventRequest request});

  $AddEventRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$OpenAddEventCopyWithImpl<$Res>
    implements _$OpenAddEventCopyWith<$Res> {
  __$OpenAddEventCopyWithImpl(this._self, this._then);

  final _OpenAddEvent _self;
  final $Res Function(_OpenAddEvent) _then;

  /// Create a copy of CalendarUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? request = null,
  }) {
    return _then(_OpenAddEvent(
      null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as AddEventRequest,
    ));
  }

  /// Create a copy of CalendarUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddEventRequestCopyWith<$Res> get request {
    return $AddEventRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }
}

/// @nodoc

class _OpenSettings implements CalendarUiEvent {
  const _OpenSettings();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _OpenSettings);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CalendarUiEvent.openSettings()';
  }
}

/// @nodoc
mixin _$AddEventRequest {
  DateTime get initialDate;
  List<ChildSummary> get children;
  String? get initialChildId;

  /// Create a copy of AddEventRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddEventRequestCopyWith<AddEventRequest> get copyWith =>
      _$AddEventRequestCopyWithImpl<AddEventRequest>(
          this as AddEventRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddEventRequest &&
            (identical(other.initialDate, initialDate) ||
                other.initialDate == initialDate) &&
            const DeepCollectionEquality().equals(other.children, children) &&
            (identical(other.initialChildId, initialChildId) ||
                other.initialChildId == initialChildId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialDate,
      const DeepCollectionEquality().hash(children), initialChildId);

  @override
  String toString() {
    return 'AddEventRequest(initialDate: $initialDate, children: $children, initialChildId: $initialChildId)';
  }
}

/// @nodoc
abstract mixin class $AddEventRequestCopyWith<$Res> {
  factory $AddEventRequestCopyWith(
          AddEventRequest value, $Res Function(AddEventRequest) _then) =
      _$AddEventRequestCopyWithImpl;
  @useResult
  $Res call(
      {DateTime initialDate,
      List<ChildSummary> children,
      String? initialChildId});
}

/// @nodoc
class _$AddEventRequestCopyWithImpl<$Res>
    implements $AddEventRequestCopyWith<$Res> {
  _$AddEventRequestCopyWithImpl(this._self, this._then);

  final AddEventRequest _self;
  final $Res Function(AddEventRequest) _then;

  /// Create a copy of AddEventRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialDate = null,
    Object? children = null,
    Object? initialChildId = freezed,
  }) {
    return _then(_self.copyWith(
      initialDate: null == initialDate
          ? _self.initialDate
          : initialDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ChildSummary>,
      initialChildId: freezed == initialChildId
          ? _self.initialChildId
          : initialChildId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AddEventRequest].
extension AddEventRequestPatterns on AddEventRequest {
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
    TResult Function(_AddEventRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddEventRequest() when $default != null:
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
    TResult Function(_AddEventRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddEventRequest():
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
    TResult? Function(_AddEventRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddEventRequest() when $default != null:
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
    TResult Function(DateTime initialDate, List<ChildSummary> children,
            String? initialChildId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddEventRequest() when $default != null:
        return $default(
            _that.initialDate, _that.children, _that.initialChildId);
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
    TResult Function(DateTime initialDate, List<ChildSummary> children,
            String? initialChildId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddEventRequest():
        return $default(
            _that.initialDate, _that.children, _that.initialChildId);
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
    TResult? Function(DateTime initialDate, List<ChildSummary> children,
            String? initialChildId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddEventRequest() when $default != null:
        return $default(
            _that.initialDate, _that.children, _that.initialChildId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AddEventRequest implements AddEventRequest {
  const _AddEventRequest(
      {required this.initialDate,
      required final List<ChildSummary> children,
      required this.initialChildId})
      : _children = children;

  @override
  final DateTime initialDate;
  final List<ChildSummary> _children;
  @override
  List<ChildSummary> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final String? initialChildId;

  /// Create a copy of AddEventRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddEventRequestCopyWith<_AddEventRequest> get copyWith =>
      __$AddEventRequestCopyWithImpl<_AddEventRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddEventRequest &&
            (identical(other.initialDate, initialDate) ||
                other.initialDate == initialDate) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.initialChildId, initialChildId) ||
                other.initialChildId == initialChildId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialDate,
      const DeepCollectionEquality().hash(_children), initialChildId);

  @override
  String toString() {
    return 'AddEventRequest(initialDate: $initialDate, children: $children, initialChildId: $initialChildId)';
  }
}

/// @nodoc
abstract mixin class _$AddEventRequestCopyWith<$Res>
    implements $AddEventRequestCopyWith<$Res> {
  factory _$AddEventRequestCopyWith(
          _AddEventRequest value, $Res Function(_AddEventRequest) _then) =
      __$AddEventRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime initialDate,
      List<ChildSummary> children,
      String? initialChildId});
}

/// @nodoc
class __$AddEventRequestCopyWithImpl<$Res>
    implements _$AddEventRequestCopyWith<$Res> {
  __$AddEventRequestCopyWithImpl(this._self, this._then);

  final _AddEventRequest _self;
  final $Res Function(_AddEventRequest) _then;

  /// Create a copy of AddEventRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? initialDate = null,
    Object? children = null,
    Object? initialChildId = freezed,
  }) {
    return _then(_AddEventRequest(
      initialDate: null == initialDate
          ? _self.initialDate
          : initialDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ChildSummary>,
      initialChildId: freezed == initialChildId
          ? _self.initialChildId
          : initialChildId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$CalendarState {
  DateTime get focusedDay;
  DateTime get selectedDay;
  Map<DateTime, List<CalendarEvent>> get eventsByDay;
  AsyncValue<List<CalendarEvent>> get eventsAsync;
  String? get householdId;
  List<ChildSummary> get availableChildren;
  String? get selectedChildId;
  CalendarSettings get calendarSettings;
  CalendarUiEvent? get pendingUiEvent;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      _$CalendarStateCopyWithImpl<CalendarState>(
          this as CalendarState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalendarState &&
            (identical(other.focusedDay, focusedDay) ||
                other.focusedDay == focusedDay) &&
            (identical(other.selectedDay, selectedDay) ||
                other.selectedDay == selectedDay) &&
            const DeepCollectionEquality()
                .equals(other.eventsByDay, eventsByDay) &&
            (identical(other.eventsAsync, eventsAsync) ||
                other.eventsAsync == eventsAsync) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            const DeepCollectionEquality()
                .equals(other.availableChildren, availableChildren) &&
            (identical(other.selectedChildId, selectedChildId) ||
                other.selectedChildId == selectedChildId) &&
            (identical(other.calendarSettings, calendarSettings) ||
                other.calendarSettings == calendarSettings) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      focusedDay,
      selectedDay,
      const DeepCollectionEquality().hash(eventsByDay),
      eventsAsync,
      householdId,
      const DeepCollectionEquality().hash(availableChildren),
      selectedChildId,
      calendarSettings,
      pendingUiEvent);

  @override
  String toString() {
    return 'CalendarState(focusedDay: $focusedDay, selectedDay: $selectedDay, eventsByDay: $eventsByDay, eventsAsync: $eventsAsync, householdId: $householdId, availableChildren: $availableChildren, selectedChildId: $selectedChildId, calendarSettings: $calendarSettings, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) _then) =
      _$CalendarStateCopyWithImpl;
  @useResult
  $Res call(
      {DateTime focusedDay,
      DateTime selectedDay,
      Map<DateTime, List<CalendarEvent>> eventsByDay,
      AsyncValue<List<CalendarEvent>> eventsAsync,
      String? householdId,
      List<ChildSummary> availableChildren,
      String? selectedChildId,
      CalendarSettings calendarSettings,
      CalendarUiEvent? pendingUiEvent});

  $CalendarSettingsCopyWith<$Res> get calendarSettings;
  $CalendarUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusedDay = null,
    Object? selectedDay = null,
    Object? eventsByDay = null,
    Object? eventsAsync = null,
    Object? householdId = freezed,
    Object? availableChildren = null,
    Object? selectedChildId = freezed,
    Object? calendarSettings = null,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_self.copyWith(
      focusedDay: null == focusedDay
          ? _self.focusedDay
          : focusedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedDay: null == selectedDay
          ? _self.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventsByDay: null == eventsByDay
          ? _self.eventsByDay
          : eventsByDay // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<CalendarEvent>>,
      eventsAsync: null == eventsAsync
          ? _self.eventsAsync
          : eventsAsync // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<CalendarEvent>>,
      householdId: freezed == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      availableChildren: null == availableChildren
          ? _self.availableChildren
          : availableChildren // ignore: cast_nullable_to_non_nullable
              as List<ChildSummary>,
      selectedChildId: freezed == selectedChildId
          ? _self.selectedChildId
          : selectedChildId // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarSettings: null == calendarSettings
          ? _self.calendarSettings
          : calendarSettings // ignore: cast_nullable_to_non_nullable
              as CalendarSettings,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as CalendarUiEvent?,
    ));
  }

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarSettingsCopyWith<$Res> get calendarSettings {
    return $CalendarSettingsCopyWith<$Res>(_self.calendarSettings, (value) {
      return _then(_self.copyWith(calendarSettings: value));
    });
  }

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $CalendarUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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
    TResult Function(_CalendarState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarState() when $default != null:
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
    TResult Function(_CalendarState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarState():
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
    TResult? Function(_CalendarState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarState() when $default != null:
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
            DateTime focusedDay,
            DateTime selectedDay,
            Map<DateTime, List<CalendarEvent>> eventsByDay,
            AsyncValue<List<CalendarEvent>> eventsAsync,
            String? householdId,
            List<ChildSummary> availableChildren,
            String? selectedChildId,
            CalendarSettings calendarSettings,
            CalendarUiEvent? pendingUiEvent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalendarState() when $default != null:
        return $default(
            _that.focusedDay,
            _that.selectedDay,
            _that.eventsByDay,
            _that.eventsAsync,
            _that.householdId,
            _that.availableChildren,
            _that.selectedChildId,
            _that.calendarSettings,
            _that.pendingUiEvent);
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
            DateTime focusedDay,
            DateTime selectedDay,
            Map<DateTime, List<CalendarEvent>> eventsByDay,
            AsyncValue<List<CalendarEvent>> eventsAsync,
            String? householdId,
            List<ChildSummary> availableChildren,
            String? selectedChildId,
            CalendarSettings calendarSettings,
            CalendarUiEvent? pendingUiEvent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarState():
        return $default(
            _that.focusedDay,
            _that.selectedDay,
            _that.eventsByDay,
            _that.eventsAsync,
            _that.householdId,
            _that.availableChildren,
            _that.selectedChildId,
            _that.calendarSettings,
            _that.pendingUiEvent);
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
            DateTime focusedDay,
            DateTime selectedDay,
            Map<DateTime, List<CalendarEvent>> eventsByDay,
            AsyncValue<List<CalendarEvent>> eventsAsync,
            String? householdId,
            List<ChildSummary> availableChildren,
            String? selectedChildId,
            CalendarSettings calendarSettings,
            CalendarUiEvent? pendingUiEvent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalendarState() when $default != null:
        return $default(
            _that.focusedDay,
            _that.selectedDay,
            _that.eventsByDay,
            _that.eventsAsync,
            _that.householdId,
            _that.availableChildren,
            _that.selectedChildId,
            _that.calendarSettings,
            _that.pendingUiEvent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CalendarState extends CalendarState {
  const _CalendarState(
      {required this.focusedDay,
      required this.selectedDay,
      required final Map<DateTime, List<CalendarEvent>> eventsByDay,
      required this.eventsAsync,
      required this.householdId,
      required final List<ChildSummary> availableChildren,
      required this.selectedChildId,
      required this.calendarSettings,
      this.pendingUiEvent})
      : _eventsByDay = eventsByDay,
        _availableChildren = availableChildren,
        super._();

  @override
  final DateTime focusedDay;
  @override
  final DateTime selectedDay;
  final Map<DateTime, List<CalendarEvent>> _eventsByDay;
  @override
  Map<DateTime, List<CalendarEvent>> get eventsByDay {
    if (_eventsByDay is EqualUnmodifiableMapView) return _eventsByDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_eventsByDay);
  }

  @override
  final AsyncValue<List<CalendarEvent>> eventsAsync;
  @override
  final String? householdId;
  final List<ChildSummary> _availableChildren;
  @override
  List<ChildSummary> get availableChildren {
    if (_availableChildren is EqualUnmodifiableListView)
      return _availableChildren;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableChildren);
  }

  @override
  final String? selectedChildId;
  @override
  final CalendarSettings calendarSettings;
  @override
  final CalendarUiEvent? pendingUiEvent;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalendarStateCopyWith<_CalendarState> get copyWith =>
      __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalendarState &&
            (identical(other.focusedDay, focusedDay) ||
                other.focusedDay == focusedDay) &&
            (identical(other.selectedDay, selectedDay) ||
                other.selectedDay == selectedDay) &&
            const DeepCollectionEquality()
                .equals(other._eventsByDay, _eventsByDay) &&
            (identical(other.eventsAsync, eventsAsync) ||
                other.eventsAsync == eventsAsync) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            const DeepCollectionEquality()
                .equals(other._availableChildren, _availableChildren) &&
            (identical(other.selectedChildId, selectedChildId) ||
                other.selectedChildId == selectedChildId) &&
            (identical(other.calendarSettings, calendarSettings) ||
                other.calendarSettings == calendarSettings) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      focusedDay,
      selectedDay,
      const DeepCollectionEquality().hash(_eventsByDay),
      eventsAsync,
      householdId,
      const DeepCollectionEquality().hash(_availableChildren),
      selectedChildId,
      calendarSettings,
      pendingUiEvent);

  @override
  String toString() {
    return 'CalendarState(focusedDay: $focusedDay, selectedDay: $selectedDay, eventsByDay: $eventsByDay, eventsAsync: $eventsAsync, householdId: $householdId, availableChildren: $availableChildren, selectedChildId: $selectedChildId, calendarSettings: $calendarSettings, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(
          _CalendarState value, $Res Function(_CalendarState) _then) =
      __$CalendarStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime focusedDay,
      DateTime selectedDay,
      Map<DateTime, List<CalendarEvent>> eventsByDay,
      AsyncValue<List<CalendarEvent>> eventsAsync,
      String? householdId,
      List<ChildSummary> availableChildren,
      String? selectedChildId,
      CalendarSettings calendarSettings,
      CalendarUiEvent? pendingUiEvent});

  @override
  $CalendarSettingsCopyWith<$Res> get calendarSettings;
  @override
  $CalendarUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? focusedDay = null,
    Object? selectedDay = null,
    Object? eventsByDay = null,
    Object? eventsAsync = null,
    Object? householdId = freezed,
    Object? availableChildren = null,
    Object? selectedChildId = freezed,
    Object? calendarSettings = null,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_CalendarState(
      focusedDay: null == focusedDay
          ? _self.focusedDay
          : focusedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedDay: null == selectedDay
          ? _self.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventsByDay: null == eventsByDay
          ? _self._eventsByDay
          : eventsByDay // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<CalendarEvent>>,
      eventsAsync: null == eventsAsync
          ? _self.eventsAsync
          : eventsAsync // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<CalendarEvent>>,
      householdId: freezed == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      availableChildren: null == availableChildren
          ? _self._availableChildren
          : availableChildren // ignore: cast_nullable_to_non_nullable
              as List<ChildSummary>,
      selectedChildId: freezed == selectedChildId
          ? _self.selectedChildId
          : selectedChildId // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarSettings: null == calendarSettings
          ? _self.calendarSettings
          : calendarSettings // ignore: cast_nullable_to_non_nullable
              as CalendarSettings,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as CalendarUiEvent?,
    ));
  }

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarSettingsCopyWith<$Res> get calendarSettings {
    return $CalendarSettingsCopyWith<$Res>(_self.calendarSettings, (value) {
      return _then(_self.copyWith(calendarSettings: value));
    });
  }

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $CalendarUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

// dart format on
