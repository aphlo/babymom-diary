// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_other_tags_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManageOtherTagsState {
  String get input;
  bool get isSubmitting;
  String? get errorMessage;

  /// Create a copy of ManageOtherTagsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManageOtherTagsStateCopyWith<ManageOtherTagsState> get copyWith =>
      _$ManageOtherTagsStateCopyWithImpl<ManageOtherTagsState>(
          this as ManageOtherTagsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManageOtherTagsState &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, input, isSubmitting, errorMessage);

  @override
  String toString() {
    return 'ManageOtherTagsState(input: $input, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ManageOtherTagsStateCopyWith<$Res> {
  factory $ManageOtherTagsStateCopyWith(ManageOtherTagsState value,
          $Res Function(ManageOtherTagsState) _then) =
      _$ManageOtherTagsStateCopyWithImpl;
  @useResult
  $Res call({String input, bool isSubmitting, String? errorMessage});
}

/// @nodoc
class _$ManageOtherTagsStateCopyWithImpl<$Res>
    implements $ManageOtherTagsStateCopyWith<$Res> {
  _$ManageOtherTagsStateCopyWithImpl(this._self, this._then);

  final ManageOtherTagsState _self;
  final $Res Function(ManageOtherTagsState) _then;

  /// Create a copy of ManageOtherTagsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = null,
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      input: null == input
          ? _self.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ManageOtherTagsState].
extension ManageOtherTagsStatePatterns on ManageOtherTagsState {
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
    TResult Function(_ManageOtherTagsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManageOtherTagsState() when $default != null:
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
    TResult Function(_ManageOtherTagsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageOtherTagsState():
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
    TResult? Function(_ManageOtherTagsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageOtherTagsState() when $default != null:
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
    TResult Function(String input, bool isSubmitting, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManageOtherTagsState() when $default != null:
        return $default(_that.input, _that.isSubmitting, _that.errorMessage);
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
    TResult Function(String input, bool isSubmitting, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageOtherTagsState():
        return $default(_that.input, _that.isSubmitting, _that.errorMessage);
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
    TResult? Function(String input, bool isSubmitting, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageOtherTagsState() when $default != null:
        return $default(_that.input, _that.isSubmitting, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ManageOtherTagsState implements ManageOtherTagsState {
  const _ManageOtherTagsState(
      {this.input = '', this.isSubmitting = false, this.errorMessage});

  @override
  @JsonKey()
  final String input;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? errorMessage;

  /// Create a copy of ManageOtherTagsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManageOtherTagsStateCopyWith<_ManageOtherTagsState> get copyWith =>
      __$ManageOtherTagsStateCopyWithImpl<_ManageOtherTagsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManageOtherTagsState &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, input, isSubmitting, errorMessage);

  @override
  String toString() {
    return 'ManageOtherTagsState(input: $input, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ManageOtherTagsStateCopyWith<$Res>
    implements $ManageOtherTagsStateCopyWith<$Res> {
  factory _$ManageOtherTagsStateCopyWith(_ManageOtherTagsState value,
          $Res Function(_ManageOtherTagsState) _then) =
      __$ManageOtherTagsStateCopyWithImpl;
  @override
  @useResult
  $Res call({String input, bool isSubmitting, String? errorMessage});
}

/// @nodoc
class __$ManageOtherTagsStateCopyWithImpl<$Res>
    implements _$ManageOtherTagsStateCopyWith<$Res> {
  __$ManageOtherTagsStateCopyWithImpl(this._self, this._then);

  final _ManageOtherTagsState _self;
  final $Res Function(_ManageOtherTagsState) _then;

  /// Create a copy of ManageOtherTagsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? input = null,
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_ManageOtherTagsState(
      input: null == input
          ? _self.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
