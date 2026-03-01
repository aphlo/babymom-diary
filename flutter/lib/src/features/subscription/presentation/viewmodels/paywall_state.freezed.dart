// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paywall_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaywallUiEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PaywallUiEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PaywallUiEvent()';
  }
}

/// @nodoc
class $PaywallUiEventCopyWith<$Res> {
  $PaywallUiEventCopyWith(PaywallUiEvent _, $Res Function(PaywallUiEvent) __);
}

/// Adds pattern-matching-related methods to [PaywallUiEvent].
extension PaywallUiEventPatterns on PaywallUiEvent {
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
    TResult Function(_PurchaseCompleted value)? purchaseCompleted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _PurchaseCompleted() when purchaseCompleted != null:
        return purchaseCompleted(_that);
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
    required TResult Function(_PurchaseCompleted value) purchaseCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that);
      case _PurchaseCompleted():
        return purchaseCompleted(_that);
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
    TResult? Function(_PurchaseCompleted value)? purchaseCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that);
      case _PurchaseCompleted() when purchaseCompleted != null:
        return purchaseCompleted(_that);
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
    TResult Function()? purchaseCompleted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _PurchaseCompleted() when purchaseCompleted != null:
        return purchaseCompleted();
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
    required TResult Function() purchaseCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage():
        return showMessage(_that.message);
      case _PurchaseCompleted():
        return purchaseCompleted();
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
    TResult? Function()? purchaseCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case _ShowMessage() when showMessage != null:
        return showMessage(_that.message);
      case _PurchaseCompleted() when purchaseCompleted != null:
        return purchaseCompleted();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ShowMessage implements PaywallUiEvent {
  const _ShowMessage(this.message);

  final String message;

  /// Create a copy of PaywallUiEvent
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
    return 'PaywallUiEvent.showMessage(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ShowMessageCopyWith<$Res>
    implements $PaywallUiEventCopyWith<$Res> {
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

  /// Create a copy of PaywallUiEvent
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

class _PurchaseCompleted implements PaywallUiEvent {
  const _PurchaseCompleted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PurchaseCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PaywallUiEvent.purchaseCompleted()';
  }
}

/// @nodoc
mixin _$PaywallState {
  SubscriptionPlan get selectedPlan;
  List<Package> get availablePackages;
  bool get isLoadingOfferings;
  bool get isPurchasing;
  bool get isRestoring;
  String? get offeringsError;
  PaywallUiEvent? get pendingUiEvent;

  /// Create a copy of PaywallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaywallStateCopyWith<PaywallState> get copyWith =>
      _$PaywallStateCopyWithImpl<PaywallState>(
          this as PaywallState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaywallState &&
            (identical(other.selectedPlan, selectedPlan) ||
                other.selectedPlan == selectedPlan) &&
            const DeepCollectionEquality()
                .equals(other.availablePackages, availablePackages) &&
            (identical(other.isLoadingOfferings, isLoadingOfferings) ||
                other.isLoadingOfferings == isLoadingOfferings) &&
            (identical(other.isPurchasing, isPurchasing) ||
                other.isPurchasing == isPurchasing) &&
            (identical(other.isRestoring, isRestoring) ||
                other.isRestoring == isRestoring) &&
            (identical(other.offeringsError, offeringsError) ||
                other.offeringsError == offeringsError) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedPlan,
      const DeepCollectionEquality().hash(availablePackages),
      isLoadingOfferings,
      isPurchasing,
      isRestoring,
      offeringsError,
      pendingUiEvent);

  @override
  String toString() {
    return 'PaywallState(selectedPlan: $selectedPlan, availablePackages: $availablePackages, isLoadingOfferings: $isLoadingOfferings, isPurchasing: $isPurchasing, isRestoring: $isRestoring, offeringsError: $offeringsError, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class $PaywallStateCopyWith<$Res> {
  factory $PaywallStateCopyWith(
          PaywallState value, $Res Function(PaywallState) _then) =
      _$PaywallStateCopyWithImpl;
  @useResult
  $Res call(
      {SubscriptionPlan selectedPlan,
      List<Package> availablePackages,
      bool isLoadingOfferings,
      bool isPurchasing,
      bool isRestoring,
      String? offeringsError,
      PaywallUiEvent? pendingUiEvent});

  $PaywallUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class _$PaywallStateCopyWithImpl<$Res> implements $PaywallStateCopyWith<$Res> {
  _$PaywallStateCopyWithImpl(this._self, this._then);

  final PaywallState _self;
  final $Res Function(PaywallState) _then;

  /// Create a copy of PaywallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedPlan = null,
    Object? availablePackages = null,
    Object? isLoadingOfferings = null,
    Object? isPurchasing = null,
    Object? isRestoring = null,
    Object? offeringsError = freezed,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_self.copyWith(
      selectedPlan: null == selectedPlan
          ? _self.selectedPlan
          : selectedPlan // ignore: cast_nullable_to_non_nullable
              as SubscriptionPlan,
      availablePackages: null == availablePackages
          ? _self.availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      isLoadingOfferings: null == isLoadingOfferings
          ? _self.isLoadingOfferings
          : isLoadingOfferings // ignore: cast_nullable_to_non_nullable
              as bool,
      isPurchasing: null == isPurchasing
          ? _self.isPurchasing
          : isPurchasing // ignore: cast_nullable_to_non_nullable
              as bool,
      isRestoring: null == isRestoring
          ? _self.isRestoring
          : isRestoring // ignore: cast_nullable_to_non_nullable
              as bool,
      offeringsError: freezed == offeringsError
          ? _self.offeringsError
          : offeringsError // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as PaywallUiEvent?,
    ));
  }

  /// Create a copy of PaywallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaywallUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $PaywallUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PaywallState].
extension PaywallStatePatterns on PaywallState {
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
    TResult Function(_PaywallState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaywallState() when $default != null:
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
    TResult Function(_PaywallState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaywallState():
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
    TResult? Function(_PaywallState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaywallState() when $default != null:
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
            SubscriptionPlan selectedPlan,
            List<Package> availablePackages,
            bool isLoadingOfferings,
            bool isPurchasing,
            bool isRestoring,
            String? offeringsError,
            PaywallUiEvent? pendingUiEvent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaywallState() when $default != null:
        return $default(
            _that.selectedPlan,
            _that.availablePackages,
            _that.isLoadingOfferings,
            _that.isPurchasing,
            _that.isRestoring,
            _that.offeringsError,
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
            SubscriptionPlan selectedPlan,
            List<Package> availablePackages,
            bool isLoadingOfferings,
            bool isPurchasing,
            bool isRestoring,
            String? offeringsError,
            PaywallUiEvent? pendingUiEvent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaywallState():
        return $default(
            _that.selectedPlan,
            _that.availablePackages,
            _that.isLoadingOfferings,
            _that.isPurchasing,
            _that.isRestoring,
            _that.offeringsError,
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
            SubscriptionPlan selectedPlan,
            List<Package> availablePackages,
            bool isLoadingOfferings,
            bool isPurchasing,
            bool isRestoring,
            String? offeringsError,
            PaywallUiEvent? pendingUiEvent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaywallState() when $default != null:
        return $default(
            _that.selectedPlan,
            _that.availablePackages,
            _that.isLoadingOfferings,
            _that.isPurchasing,
            _that.isRestoring,
            _that.offeringsError,
            _that.pendingUiEvent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PaywallState extends PaywallState {
  const _PaywallState(
      {required this.selectedPlan,
      required final List<Package> availablePackages,
      required this.isLoadingOfferings,
      required this.isPurchasing,
      required this.isRestoring,
      this.offeringsError,
      this.pendingUiEvent})
      : _availablePackages = availablePackages,
        super._();

  @override
  final SubscriptionPlan selectedPlan;
  final List<Package> _availablePackages;
  @override
  List<Package> get availablePackages {
    if (_availablePackages is EqualUnmodifiableListView)
      return _availablePackages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availablePackages);
  }

  @override
  final bool isLoadingOfferings;
  @override
  final bool isPurchasing;
  @override
  final bool isRestoring;
  @override
  final String? offeringsError;
  @override
  final PaywallUiEvent? pendingUiEvent;

  /// Create a copy of PaywallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaywallStateCopyWith<_PaywallState> get copyWith =>
      __$PaywallStateCopyWithImpl<_PaywallState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaywallState &&
            (identical(other.selectedPlan, selectedPlan) ||
                other.selectedPlan == selectedPlan) &&
            const DeepCollectionEquality()
                .equals(other._availablePackages, _availablePackages) &&
            (identical(other.isLoadingOfferings, isLoadingOfferings) ||
                other.isLoadingOfferings == isLoadingOfferings) &&
            (identical(other.isPurchasing, isPurchasing) ||
                other.isPurchasing == isPurchasing) &&
            (identical(other.isRestoring, isRestoring) ||
                other.isRestoring == isRestoring) &&
            (identical(other.offeringsError, offeringsError) ||
                other.offeringsError == offeringsError) &&
            (identical(other.pendingUiEvent, pendingUiEvent) ||
                other.pendingUiEvent == pendingUiEvent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedPlan,
      const DeepCollectionEquality().hash(_availablePackages),
      isLoadingOfferings,
      isPurchasing,
      isRestoring,
      offeringsError,
      pendingUiEvent);

  @override
  String toString() {
    return 'PaywallState(selectedPlan: $selectedPlan, availablePackages: $availablePackages, isLoadingOfferings: $isLoadingOfferings, isPurchasing: $isPurchasing, isRestoring: $isRestoring, offeringsError: $offeringsError, pendingUiEvent: $pendingUiEvent)';
  }
}

/// @nodoc
abstract mixin class _$PaywallStateCopyWith<$Res>
    implements $PaywallStateCopyWith<$Res> {
  factory _$PaywallStateCopyWith(
          _PaywallState value, $Res Function(_PaywallState) _then) =
      __$PaywallStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SubscriptionPlan selectedPlan,
      List<Package> availablePackages,
      bool isLoadingOfferings,
      bool isPurchasing,
      bool isRestoring,
      String? offeringsError,
      PaywallUiEvent? pendingUiEvent});

  @override
  $PaywallUiEventCopyWith<$Res>? get pendingUiEvent;
}

/// @nodoc
class __$PaywallStateCopyWithImpl<$Res>
    implements _$PaywallStateCopyWith<$Res> {
  __$PaywallStateCopyWithImpl(this._self, this._then);

  final _PaywallState _self;
  final $Res Function(_PaywallState) _then;

  /// Create a copy of PaywallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedPlan = null,
    Object? availablePackages = null,
    Object? isLoadingOfferings = null,
    Object? isPurchasing = null,
    Object? isRestoring = null,
    Object? offeringsError = freezed,
    Object? pendingUiEvent = freezed,
  }) {
    return _then(_PaywallState(
      selectedPlan: null == selectedPlan
          ? _self.selectedPlan
          : selectedPlan // ignore: cast_nullable_to_non_nullable
              as SubscriptionPlan,
      availablePackages: null == availablePackages
          ? _self._availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      isLoadingOfferings: null == isLoadingOfferings
          ? _self.isLoadingOfferings
          : isLoadingOfferings // ignore: cast_nullable_to_non_nullable
              as bool,
      isPurchasing: null == isPurchasing
          ? _self.isPurchasing
          : isPurchasing // ignore: cast_nullable_to_non_nullable
              as bool,
      isRestoring: null == isRestoring
          ? _self.isRestoring
          : isRestoring // ignore: cast_nullable_to_non_nullable
              as bool,
      offeringsError: freezed == offeringsError
          ? _self.offeringsError
          : offeringsError // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingUiEvent: freezed == pendingUiEvent
          ? _self.pendingUiEvent
          : pendingUiEvent // ignore: cast_nullable_to_non_nullable
              as PaywallUiEvent?,
    ));
  }

  /// Create a copy of PaywallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaywallUiEventCopyWith<$Res>? get pendingUiEvent {
    if (_self.pendingUiEvent == null) {
      return null;
    }

    return $PaywallUiEventCopyWith<$Res>(_self.pendingUiEvent!, (value) {
      return _then(_self.copyWith(pendingUiEvent: value));
    });
  }
}

// dart format on
