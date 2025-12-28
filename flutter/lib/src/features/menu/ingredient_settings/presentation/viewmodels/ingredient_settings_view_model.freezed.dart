// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredient_settings_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IngredientSettingsState {
  FoodCategory? get expandedCategory;

  /// Create a copy of IngredientSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IngredientSettingsStateCopyWith<IngredientSettingsState> get copyWith =>
      _$IngredientSettingsStateCopyWithImpl<IngredientSettingsState>(
          this as IngredientSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IngredientSettingsState &&
            (identical(other.expandedCategory, expandedCategory) ||
                other.expandedCategory == expandedCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expandedCategory);

  @override
  String toString() {
    return 'IngredientSettingsState(expandedCategory: $expandedCategory)';
  }
}

/// @nodoc
abstract mixin class $IngredientSettingsStateCopyWith<$Res> {
  factory $IngredientSettingsStateCopyWith(IngredientSettingsState value,
          $Res Function(IngredientSettingsState) _then) =
      _$IngredientSettingsStateCopyWithImpl;
  @useResult
  $Res call({FoodCategory? expandedCategory});
}

/// @nodoc
class _$IngredientSettingsStateCopyWithImpl<$Res>
    implements $IngredientSettingsStateCopyWith<$Res> {
  _$IngredientSettingsStateCopyWithImpl(this._self, this._then);

  final IngredientSettingsState _self;
  final $Res Function(IngredientSettingsState) _then;

  /// Create a copy of IngredientSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expandedCategory = freezed,
  }) {
    return _then(_self.copyWith(
      expandedCategory: freezed == expandedCategory
          ? _self.expandedCategory
          : expandedCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
    ));
  }
}

/// Adds pattern-matching-related methods to [IngredientSettingsState].
extension IngredientSettingsStatePatterns on IngredientSettingsState {
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
    TResult Function(_IngredientSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IngredientSettingsState() when $default != null:
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
    TResult Function(_IngredientSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientSettingsState():
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
    TResult? Function(_IngredientSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientSettingsState() when $default != null:
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
    TResult Function(FoodCategory? expandedCategory)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IngredientSettingsState() when $default != null:
        return $default(_that.expandedCategory);
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
    TResult Function(FoodCategory? expandedCategory) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientSettingsState():
        return $default(_that.expandedCategory);
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
    TResult? Function(FoodCategory? expandedCategory)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IngredientSettingsState() when $default != null:
        return $default(_that.expandedCategory);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _IngredientSettingsState implements IngredientSettingsState {
  const _IngredientSettingsState({this.expandedCategory});

  @override
  final FoodCategory? expandedCategory;

  /// Create a copy of IngredientSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IngredientSettingsStateCopyWith<_IngredientSettingsState> get copyWith =>
      __$IngredientSettingsStateCopyWithImpl<_IngredientSettingsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IngredientSettingsState &&
            (identical(other.expandedCategory, expandedCategory) ||
                other.expandedCategory == expandedCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expandedCategory);

  @override
  String toString() {
    return 'IngredientSettingsState(expandedCategory: $expandedCategory)';
  }
}

/// @nodoc
abstract mixin class _$IngredientSettingsStateCopyWith<$Res>
    implements $IngredientSettingsStateCopyWith<$Res> {
  factory _$IngredientSettingsStateCopyWith(_IngredientSettingsState value,
          $Res Function(_IngredientSettingsState) _then) =
      __$IngredientSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({FoodCategory? expandedCategory});
}

/// @nodoc
class __$IngredientSettingsStateCopyWithImpl<$Res>
    implements _$IngredientSettingsStateCopyWith<$Res> {
  __$IngredientSettingsStateCopyWithImpl(this._self, this._then);

  final _IngredientSettingsState _self;
  final $Res Function(_IngredientSettingsState) _then;

  /// Create a copy of IngredientSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? expandedCategory = freezed,
  }) {
    return _then(_IngredientSettingsState(
      expandedCategory: freezed == expandedCategory
          ? _self.expandedCategory
          : expandedCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
    ));
  }
}

// dart format on
