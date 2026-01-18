// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feeding_table_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedingTableSettingsState {
  /// 表示するカテゴリの順序付きリスト
  List<FeedingTableCategory> get visibleCategories;

  /// 非表示のカテゴリリスト
  List<FeedingTableCategory> get hiddenCategories;

  /// ローディング中かどうか
  bool get isLoading;

  /// 保存中かどうか
  bool get isSaving;

  /// Create a copy of FeedingTableSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeedingTableSettingsStateCopyWith<FeedingTableSettingsState> get copyWith =>
      _$FeedingTableSettingsStateCopyWithImpl<FeedingTableSettingsState>(
          this as FeedingTableSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeedingTableSettingsState &&
            const DeepCollectionEquality()
                .equals(other.visibleCategories, visibleCategories) &&
            const DeepCollectionEquality()
                .equals(other.hiddenCategories, hiddenCategories) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(visibleCategories),
      const DeepCollectionEquality().hash(hiddenCategories),
      isLoading,
      isSaving);

  @override
  String toString() {
    return 'FeedingTableSettingsState(visibleCategories: $visibleCategories, hiddenCategories: $hiddenCategories, isLoading: $isLoading, isSaving: $isSaving)';
  }
}

/// @nodoc
abstract mixin class $FeedingTableSettingsStateCopyWith<$Res> {
  factory $FeedingTableSettingsStateCopyWith(FeedingTableSettingsState value,
          $Res Function(FeedingTableSettingsState) _then) =
      _$FeedingTableSettingsStateCopyWithImpl;
  @useResult
  $Res call(
      {List<FeedingTableCategory> visibleCategories,
      List<FeedingTableCategory> hiddenCategories,
      bool isLoading,
      bool isSaving});
}

/// @nodoc
class _$FeedingTableSettingsStateCopyWithImpl<$Res>
    implements $FeedingTableSettingsStateCopyWith<$Res> {
  _$FeedingTableSettingsStateCopyWithImpl(this._self, this._then);

  final FeedingTableSettingsState _self;
  final $Res Function(FeedingTableSettingsState) _then;

  /// Create a copy of FeedingTableSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visibleCategories = null,
    Object? hiddenCategories = null,
    Object? isLoading = null,
    Object? isSaving = null,
  }) {
    return _then(_self.copyWith(
      visibleCategories: null == visibleCategories
          ? _self.visibleCategories
          : visibleCategories // ignore: cast_nullable_to_non_nullable
              as List<FeedingTableCategory>,
      hiddenCategories: null == hiddenCategories
          ? _self.hiddenCategories
          : hiddenCategories // ignore: cast_nullable_to_non_nullable
              as List<FeedingTableCategory>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _self.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [FeedingTableSettingsState].
extension FeedingTableSettingsStatePatterns on FeedingTableSettingsState {
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
    TResult Function(_FeedingTableSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettingsState() when $default != null:
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
    TResult Function(_FeedingTableSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettingsState():
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
    TResult? Function(_FeedingTableSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettingsState() when $default != null:
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
            List<FeedingTableCategory> visibleCategories,
            List<FeedingTableCategory> hiddenCategories,
            bool isLoading,
            bool isSaving)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettingsState() when $default != null:
        return $default(_that.visibleCategories, _that.hiddenCategories,
            _that.isLoading, _that.isSaving);
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
            List<FeedingTableCategory> visibleCategories,
            List<FeedingTableCategory> hiddenCategories,
            bool isLoading,
            bool isSaving)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettingsState():
        return $default(_that.visibleCategories, _that.hiddenCategories,
            _that.isLoading, _that.isSaving);
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
            List<FeedingTableCategory> visibleCategories,
            List<FeedingTableCategory> hiddenCategories,
            bool isLoading,
            bool isSaving)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettingsState() when $default != null:
        return $default(_that.visibleCategories, _that.hiddenCategories,
            _that.isLoading, _that.isSaving);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FeedingTableSettingsState implements FeedingTableSettingsState {
  const _FeedingTableSettingsState(
      {final List<FeedingTableCategory> visibleCategories = const [],
      final List<FeedingTableCategory> hiddenCategories = const [],
      this.isLoading = true,
      this.isSaving = false})
      : _visibleCategories = visibleCategories,
        _hiddenCategories = hiddenCategories;

  /// 表示するカテゴリの順序付きリスト
  final List<FeedingTableCategory> _visibleCategories;

  /// 表示するカテゴリの順序付きリスト
  @override
  @JsonKey()
  List<FeedingTableCategory> get visibleCategories {
    if (_visibleCategories is EqualUnmodifiableListView)
      return _visibleCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleCategories);
  }

  /// 非表示のカテゴリリスト
  final List<FeedingTableCategory> _hiddenCategories;

  /// 非表示のカテゴリリスト
  @override
  @JsonKey()
  List<FeedingTableCategory> get hiddenCategories {
    if (_hiddenCategories is EqualUnmodifiableListView)
      return _hiddenCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenCategories);
  }

  /// ローディング中かどうか
  @override
  @JsonKey()
  final bool isLoading;

  /// 保存中かどうか
  @override
  @JsonKey()
  final bool isSaving;

  /// Create a copy of FeedingTableSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FeedingTableSettingsStateCopyWith<_FeedingTableSettingsState>
      get copyWith =>
          __$FeedingTableSettingsStateCopyWithImpl<_FeedingTableSettingsState>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FeedingTableSettingsState &&
            const DeepCollectionEquality()
                .equals(other._visibleCategories, _visibleCategories) &&
            const DeepCollectionEquality()
                .equals(other._hiddenCategories, _hiddenCategories) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_visibleCategories),
      const DeepCollectionEquality().hash(_hiddenCategories),
      isLoading,
      isSaving);

  @override
  String toString() {
    return 'FeedingTableSettingsState(visibleCategories: $visibleCategories, hiddenCategories: $hiddenCategories, isLoading: $isLoading, isSaving: $isSaving)';
  }
}

/// @nodoc
abstract mixin class _$FeedingTableSettingsStateCopyWith<$Res>
    implements $FeedingTableSettingsStateCopyWith<$Res> {
  factory _$FeedingTableSettingsStateCopyWith(_FeedingTableSettingsState value,
          $Res Function(_FeedingTableSettingsState) _then) =
      __$FeedingTableSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<FeedingTableCategory> visibleCategories,
      List<FeedingTableCategory> hiddenCategories,
      bool isLoading,
      bool isSaving});
}

/// @nodoc
class __$FeedingTableSettingsStateCopyWithImpl<$Res>
    implements _$FeedingTableSettingsStateCopyWith<$Res> {
  __$FeedingTableSettingsStateCopyWithImpl(this._self, this._then);

  final _FeedingTableSettingsState _self;
  final $Res Function(_FeedingTableSettingsState) _then;

  /// Create a copy of FeedingTableSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? visibleCategories = null,
    Object? hiddenCategories = null,
    Object? isLoading = null,
    Object? isSaving = null,
  }) {
    return _then(_FeedingTableSettingsState(
      visibleCategories: null == visibleCategories
          ? _self._visibleCategories
          : visibleCategories // ignore: cast_nullable_to_non_nullable
              as List<FeedingTableCategory>,
      hiddenCategories: null == hiddenCategories
          ? _self._hiddenCategories
          : hiddenCategories // ignore: cast_nullable_to_non_nullable
              as List<FeedingTableCategory>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _self.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
