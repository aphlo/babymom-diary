// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredient_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IngredientDetailState {
  /// 現在の食材名（カスタム食材の名前変更に対応）
  String get currentIngredientName;

  /// カスタム食材かどうか
  bool get isCustomIngredient;

  /// 処理中フラグ
  bool get isProcessing;

  /// 保留中のUIイベント
  IngredientDetailUiEvent? get pendingUiEvent;

  /// Create a copy of IngredientDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IngredientDetailStateCopyWith<IngredientDetailState> get copyWith =>
      _$IngredientDetailStateCopyWithImpl<IngredientDetailState>(
          this as IngredientDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IngredientDetailState &&
            (identical(other.currentIngredientName, currentIngredientName) ||
                other.currentIngredientName == currentIngredientName) &&
            (identical(other.isCustomIngredient, isCustomIngredient) ||
                other.isCustomIngredient == isCustomIngredient) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentIngredientName,
      isCustomIngredient, isProcessing, pendingUiEvent);

  @override
  String toString() {
    return 'IngredientDetailState(currentIngredientName: $currentIngredientName, isCustomIngredient: $isCustomIngredient, isProcessing: $isProcessing, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class $IngredientDetailStateCopyWith<$Res> {
  factory $IngredientDetailStateCopyWith(IngredientDetailState value,
          $Res Function(IngredientDetailState) _then) =
      _$IngredientDetailStateCopyWithImpl;
  @useResult
  $Res call(
      {String currentIngredientName,
      bool isCustomIngredient,
      bool isProcessing,
      IngredientDetailUiEvent? pendingUiEvent});

  $IngredientDetailUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class _$IngredientDetailStateCopyWithImpl<$Res>
    implements $IngredientDetailStateCopyWith<$Res> {
  _$IngredientDetailStateCopyWithImpl(this._self, this._then);

  final IngredientDetailState _self;
  final $Res Function(IngredientDetailState) _then;

  /// Create a copy of IngredientDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIngredientName = null,
    Object? isCustomIngredient = null,
    Object? isProcessing = null,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_self.copyWith(
      currentIngredientName: null == currentIngredientName
          ? _self.currentIngredientName
          : currentIngredientName // ignore: cast_nullable_to_non_nullable
              as String,
      isCustomIngredient: null == isCustomIngredient
          ? _self.isCustomIngredient
          : isCustomIngredient // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as IngredientDetailUiEvent?,
    ));
  }

  /// Create a copy of IngredientDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IngredientDetailUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $IngredientDetailUiEventCopyWith<$Res>(_self.pendingUiEvent!,
        (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [IngredientDetailState].
extension IngredientDetailStatePatterns on IngredientDetailState {
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
    TResult Function(_IngredientDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IngredientDetailState() when $default != null:
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
    TResult Function(_IngredientDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientDetailState():
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
    TResult? Function(_IngredientDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientDetailState() when $default != null:
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
    TResult Function(String currentIngredientName, bool isCustomIngredient,
            bool isProcessing, IngredientDetailUiEvent? pendingUiEvent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IngredientDetailState() when $default != null:
        return $default(_that.currentIngredientName, _that.isCustomIngredient,
            _that.isProcessing, _that.pendingUiEvent);
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
    TResult Function(String currentIngredientName, bool isCustomIngredient,
            bool isProcessing, IngredientDetailUiEvent? pendingUiEvent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientDetailState():
        return $default(_that.currentIngredientName, _that.isCustomIngredient,
            _that.isProcessing, _that.pendingUiEvent);
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
    TResult? Function(String currentIngredientName, bool isCustomIngredient,
            bool isProcessing, IngredientDetailUiEvent? pendingUiEvent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientDetailState() when $default != null:
        return $default(_that.currentIngredientName, _that.isCustomIngredient,
            _that.isProcessing, _that.pendingUiEvent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _IngredientDetailState extends IngredientDetailState {
  const _IngredientDetailState(
      {required this.currentIngredientName,
      required this.isCustomIngredient,
      this.isProcessing = false,
      this.pendingUiEvent})
      : super._();

  /// 現在の食材名（カスタム食材の名前変更に対応）
  @override
  final String currentIngredientName;

  /// カスタム食材かどうか
  @override
  final bool isCustomIngredient;

  /// 処理中フラグ
  @override
  @JsonKey()
  final bool isProcessing;

  /// 保留中のUIイベント
  @override
  final IngredientDetailUiEvent? pendingUiEvent;

  /// Create a copy of IngredientDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IngredientDetailStateCopyWith<_IngredientDetailState> get copyWith =>
      __$IngredientDetailStateCopyWithImpl<_IngredientDetailState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IngredientDetailState &&
            (identical(other.currentIngredientName, currentIngredientName) ||
                other.currentIngredientName == currentIngredientName) &&
            (identical(other.isCustomIngredient, isCustomIngredient) ||
                other.isCustomIngredient == isCustomIngredient) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentIngredientName,
      isCustomIngredient, isProcessing, pendingUiEvent);

  @override
  String toString() {
    return 'IngredientDetailState(currentIngredientName: $currentIngredientName, isCustomIngredient: $isCustomIngredient, isProcessing: $isProcessing, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class _$IngredientDetailStateCopyWith<$Res>
    implements $IngredientDetailStateCopyWith<$Res> {
  factory _$IngredientDetailStateCopyWith(_IngredientDetailState value,
          $Res Function(_IngredientDetailState) _then) =
      __$IngredientDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String currentIngredientName,
      bool isCustomIngredient,
      bool isProcessing,
      IngredientDetailUiEvent? pendingUiEvent});

  @override
  $IngredientDetailUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class __$IngredientDetailStateCopyWithImpl<$Res>
    implements _$IngredientDetailStateCopyWith<$Res> {
  __$IngredientDetailStateCopyWithImpl(this._self, this._then);

  final _IngredientDetailState _self;
  final $Res Function(_IngredientDetailState) _then;

  /// Create a copy of IngredientDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentIngredientName = null,
    Object? isCustomIngredient = null,
    Object? isProcessing = null,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_IngredientDetailState(
      currentIngredientName: null == currentIngredientName
          ? _self.currentIngredientName
          : currentIngredientName // ignore: cast_nullable_to_non_nullable
              as String,
      isCustomIngredient: null == isCustomIngredient
          ? _self.isCustomIngredient
          : isCustomIngredient // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as IngredientDetailUiEvent?,
    ));
  }

  /// Create a copy of IngredientDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IngredientDetailUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $IngredientDetailUiEventCopyWith<$Res>(_self.pendingUiEvent!,
        (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// @nodoc
mixin _$IngredientDetailUiEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is IngredientDetailUiEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'IngredientDetailUiEvent()';
  }
}

/// @nodoc
class $IngredientDetailUiEventCopyWith<$Res> {
  $IngredientDetailUiEventCopyWith(
      IngredientDetailUiEvent _, $Res Function(IngredientDetailUiEvent) __);
}

/// Adds pattern-matching-related methods to [IngredientDetailUiEvent].
extension IngredientDetailUiEventPatterns on IngredientDetailUiEvent {
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
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _NavigateBack() when navigateBack != null:
        return navigateBack(_that);
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
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that);
      case _NavigateBack():
        return navigateBack(_that);
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
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _NavigateBack() when navigateBack != null:
        return navigateBack(_that);
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
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _NavigateBack() when navigateBack != null:
        return navigateBack();
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
    required TResult Function() navigateBack,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that.message);
      case _NavigateBack():
        return navigateBack();
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
    TResult? Function()? navigateBack,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _NavigateBack() when navigateBack != null:
        return navigateBack();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShowMessage implements IngredientDetailUiEvent {
  const _ShowMessage(this.message);

  final String message;

  /// Create a copy of IngredientDetailUiEvent
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
    return 'IngredientDetailUiEvent.showMessage(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ShowMessageCopyWith<$Res>
    implements $IngredientDetailUiEventCopyWith<$Res> {
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

  /// Create a copy of IngredientDetailUiEvent
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

class _NavigateBack implements IngredientDetailUiEvent {
  const _NavigateBack();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NavigateBack);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'IngredientDetailUiEvent.navigateBack()';
  }
}

// dart format on
