// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionState {
  /// 処理中かどうか
  bool get isProcessing;

  /// 現在サブスク加入中かどうか
  bool get isSubscribed;

  /// 利用可能なオファリング
  Offerings? get offerings;

  /// エラーメッセージ
  String? get errorMessage;

  /// 成功メッセージ
  String? get successMessage;

  /// 保留中のUIイベント
  SubscriptionUiEvent? get pendingUiEvent;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubscriptionStateCopyWith<SubscriptionState> get copyWith =>
      _$SubscriptionStateCopyWithImpl<SubscriptionState>(
          this as SubscriptionState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubscriptionState &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.isSubscribed, isSubscribed) ||
                other.isSubscribed == isSubscribed) &&
            (identical(other.offerings, offerings) ||
                other.offerings == offerings) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isProcessing, isSubscribed,
      offerings, errorMessage, successMessage, pendingUiEvent);

  @override
  String toString() {
    return 'SubscriptionState(isProcessing: $isProcessing, isSubscribed: $isSubscribed, offerings: $offerings, errorMessage: $errorMessage, successMessage: $successMessage, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateCopyWith(
          SubscriptionState value, $Res Function(SubscriptionState) _then) =
      _$SubscriptionStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isProcessing,
      bool isSubscribed,
      Offerings? offerings,
      String? errorMessage,
      String? successMessage,
      SubscriptionUiEvent? pendingUiEvent});

  $SubscriptionUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? isSubscribed = null,
    Object? offerings = freezed,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_self.copyWith(
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubscribed: null == isSubscribed
          ? _self.isSubscribed
          : isSubscribed // ignore: cast_nullable_to_non_nullable
              as bool,
      offerings: freezed == offerings
          ? _self.offerings
          : offerings // ignore: cast_nullable_to_non_nullable
              as Offerings?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _self.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as SubscriptionUiEvent?,
    ));
  }

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $SubscriptionUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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
    TResult Function(_SubscriptionState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubscriptionState() when $default != null:
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
    TResult Function(_SubscriptionState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionState():
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
    TResult? Function(_SubscriptionState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionState() when $default != null:
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
            bool isProcessing,
            bool isSubscribed,
            Offerings? offerings,
            String? errorMessage,
            String? successMessage,
            SubscriptionUiEvent? pendingUiEvent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubscriptionState() when $default != null:
        return $default(_that.isProcessing, _that.isSubscribed, _that.offerings,
            _that.errorMessage, _that.successMessage, _that.pendingUiEvent);
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
            bool isProcessing,
            bool isSubscribed,
            Offerings? offerings,
            String? errorMessage,
            String? successMessage,
            SubscriptionUiEvent? pendingUiEvent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionState():
        return $default(_that.isProcessing, _that.isSubscribed, _that.offerings,
            _that.errorMessage, _that.successMessage, _that.pendingUiEvent);
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
            bool isProcessing,
            bool isSubscribed,
            Offerings? offerings,
            String? errorMessage,
            String? successMessage,
            SubscriptionUiEvent? pendingUiEvent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionState() when $default != null:
        return $default(_that.isProcessing, _that.isSubscribed, _that.offerings,
            _that.errorMessage, _that.successMessage, _that.pendingUiEvent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SubscriptionState implements SubscriptionState {
  const _SubscriptionState(
      {this.isProcessing = false,
      this.isSubscribed = false,
      this.offerings,
      this.errorMessage,
      this.successMessage,
      this.pendingUiEvent});

  /// 処理中かどうか
  @override
  @JsonKey()
  final bool isProcessing;

  /// 現在サブスク加入中かどうか
  @override
  @JsonKey()
  final bool isSubscribed;

  /// 利用可能なオファリング
  @override
  final Offerings? offerings;

  /// エラーメッセージ
  @override
  final String? errorMessage;

  /// 成功メッセージ
  @override
  final String? successMessage;

  /// 保留中のUIイベント
  @override
  final SubscriptionUiEvent? pendingUiEvent;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubscriptionStateCopyWith<_SubscriptionState> get copyWith =>
      __$SubscriptionStateCopyWithImpl<_SubscriptionState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubscriptionState &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.isSubscribed, isSubscribed) ||
                other.isSubscribed == isSubscribed) &&
            (identical(other.offerings, offerings) ||
                other.offerings == offerings) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isProcessing, isSubscribed,
      offerings, errorMessage, successMessage, pendingUiEvent);

  @override
  String toString() {
    return 'SubscriptionState(isProcessing: $isProcessing, isSubscribed: $isSubscribed, offerings: $offerings, errorMessage: $errorMessage, successMessage: $successMessage, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class _$SubscriptionStateCopyWith<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  factory _$SubscriptionStateCopyWith(
          _SubscriptionState value, $Res Function(_SubscriptionState) _then) =
      __$SubscriptionStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isProcessing,
      bool isSubscribed,
      Offerings? offerings,
      String? errorMessage,
      String? successMessage,
      SubscriptionUiEvent? pendingUiEvent});

  @override
  $SubscriptionUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class __$SubscriptionStateCopyWithImpl<$Res>
    implements _$SubscriptionStateCopyWith<$Res> {
  __$SubscriptionStateCopyWithImpl(this._self, this._then);

  final _SubscriptionState _self;
  final $Res Function(_SubscriptionState) _then;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isProcessing = null,
    Object? isSubscribed = null,
    Object? offerings = freezed,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_SubscriptionState(
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubscribed: null == isSubscribed
          ? _self.isSubscribed
          : isSubscribed // ignore: cast_nullable_to_non_nullable
              as bool,
      offerings: freezed == offerings
          ? _self.offerings
          : offerings // ignore: cast_nullable_to_non_nullable
              as Offerings?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _self.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as SubscriptionUiEvent?,
    ));
  }

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $SubscriptionUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// @nodoc
mixin _$SubscriptionUiEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SubscriptionUiEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SubscriptionUiEvent()';
  }
}

/// @nodoc
class $SubscriptionUiEventCopyWith<$Res> {
  $SubscriptionUiEventCopyWith(
      SubscriptionUiEvent _, $Res Function(SubscriptionUiEvent) __);
}

/// Adds pattern-matching-related methods to [SubscriptionUiEvent].
extension SubscriptionUiEventPatterns on SubscriptionUiEvent {
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
    TResult Function(_PurchaseSuccess value)? purchaseSuccess,
    TResult Function(_RestoreSuccess value)? restoreSuccess,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _PurchaseSuccess() when purchaseSuccess != null:
        return purchaseSuccess(_that);
      case _RestoreSuccess() when restoreSuccess != null:
        return restoreSuccess(_that);
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
    required TResult Function(_PurchaseSuccess value) purchaseSuccess,
    required TResult Function(_RestoreSuccess value) restoreSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that);
      case _PurchaseSuccess():
        return purchaseSuccess(_that);
      case _RestoreSuccess():
        return restoreSuccess(_that);
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
    TResult? Function(_PurchaseSuccess value)? purchaseSuccess,
    TResult? Function(_RestoreSuccess value)? restoreSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _PurchaseSuccess() when purchaseSuccess != null:
        return purchaseSuccess(_that);
      case _RestoreSuccess() when restoreSuccess != null:
        return restoreSuccess(_that);
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
    TResult Function()? purchaseSuccess,
    TResult Function(bool hasActiveSubscription)? restoreSuccess,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _PurchaseSuccess() when purchaseSuccess != null:
        return purchaseSuccess();
      case _RestoreSuccess() when restoreSuccess != null:
        return restoreSuccess(_that.hasActiveSubscription);
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
    required TResult Function() purchaseSuccess,
    required TResult Function(bool hasActiveSubscription) restoreSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that.message);
      case _PurchaseSuccess():
        return purchaseSuccess();
      case _RestoreSuccess():
        return restoreSuccess(_that.hasActiveSubscription);
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
    TResult? Function()? purchaseSuccess,
    TResult? Function(bool hasActiveSubscription)? restoreSuccess,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _PurchaseSuccess() when purchaseSuccess != null:
        return purchaseSuccess();
      case _RestoreSuccess() when restoreSuccess != null:
        return restoreSuccess(_that.hasActiveSubscription);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShowMessage implements SubscriptionUiEvent {
  const _ShowMessage(this.message);

  final String message;

  /// Create a copy of SubscriptionUiEvent
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
    return 'SubscriptionUiEvent.showMessage(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ShowMessageCopyWith<$Res>
    implements $SubscriptionUiEventCopyWith<$Res> {
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

  /// Create a copy of SubscriptionUiEvent
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

class _PurchaseSuccess implements SubscriptionUiEvent {
  const _PurchaseSuccess();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PurchaseSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SubscriptionUiEvent.purchaseSuccess()';
  }
}

/// @nodoc

class _RestoreSuccess implements SubscriptionUiEvent {
  const _RestoreSuccess(this.hasActiveSubscription);

  final bool hasActiveSubscription;

  /// Create a copy of SubscriptionUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RestoreSuccessCopyWith<_RestoreSuccess> get copyWith =>
      __$RestoreSuccessCopyWithImpl<_RestoreSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RestoreSuccess &&
            (identical(other.hasActiveSubscription, hasActiveSubscription) ||
                other.hasActiveSubscription == hasActiveSubscription));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasActiveSubscription);

  @override
  String toString() {
    return 'SubscriptionUiEvent.restoreSuccess(hasActiveSubscription: $hasActiveSubscription)';
  }
}

/// @nodoc
abstract mixin class _$RestoreSuccessCopyWith<$Res>
    implements $SubscriptionUiEventCopyWith<$Res> {
  factory _$RestoreSuccessCopyWith(
          _RestoreSuccess value, $Res Function(_RestoreSuccess) _then) =
      __$RestoreSuccessCopyWithImpl;
  @useResult
  $Res call({bool hasActiveSubscription});
}

/// @nodoc
class __$RestoreSuccessCopyWithImpl<$Res>
    implements _$RestoreSuccessCopyWith<$Res> {
  __$RestoreSuccessCopyWithImpl(this._self, this._then);

  final _RestoreSuccess _self;
  final $Res Function(_RestoreSuccess) _then;

  /// Create a copy of SubscriptionUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hasActiveSubscription = null,
  }) {
    return _then(_RestoreSuccess(
      null == hasActiveSubscription
          ? _self.hasActiveSubscription
          : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
