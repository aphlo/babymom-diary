// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WidgetSettingsState {
  /// 直近の記録表示カテゴリ（最大3つ）
  List<WidgetRecordCategory> get displayCategories;

  /// クイックアクションカテゴリ（最大5つ）
  List<WidgetRecordCategory> get quickActionCategories;

  /// 授乳表設定で非表示になっているカテゴリ
  List<WidgetRecordCategory> get hiddenCategories;

  /// 読み込み中かどうか
  bool get isLoading;

  /// 保存中かどうか
  bool get isSaving;

  /// Create a copy of WidgetSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WidgetSettingsStateCopyWith<WidgetSettingsState> get copyWith =>
      _$WidgetSettingsStateCopyWithImpl<WidgetSettingsState>(
          this as WidgetSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WidgetSettingsState &&
            const DeepCollectionEquality()
                .equals(other.displayCategories, displayCategories) &&
            const DeepCollectionEquality()
                .equals(other.quickActionCategories, quickActionCategories) &&
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
      const DeepCollectionEquality().hash(displayCategories),
      const DeepCollectionEquality().hash(quickActionCategories),
      const DeepCollectionEquality().hash(hiddenCategories),
      isLoading,
      isSaving);

  @override
  String toString() {
    return 'WidgetSettingsState(displayCategories: $displayCategories, quickActionCategories: $quickActionCategories, hiddenCategories: $hiddenCategories, isLoading: $isLoading, isSaving: $isSaving)';
  }
}

/// @nodoc
abstract mixin class $WidgetSettingsStateCopyWith<$Res> {
  factory $WidgetSettingsStateCopyWith(
          WidgetSettingsState value, $Res Function(WidgetSettingsState) _then) =
      _$WidgetSettingsStateCopyWithImpl;
  @useResult
  $Res call(
      {List<WidgetRecordCategory> displayCategories,
      List<WidgetRecordCategory> quickActionCategories,
      List<WidgetRecordCategory> hiddenCategories,
      bool isLoading,
      bool isSaving});
}

/// @nodoc
class _$WidgetSettingsStateCopyWithImpl<$Res>
    implements $WidgetSettingsStateCopyWith<$Res> {
  _$WidgetSettingsStateCopyWithImpl(this._self, this._then);

  final WidgetSettingsState _self;
  final $Res Function(WidgetSettingsState) _then;

  /// Create a copy of WidgetSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayCategories = null,
    Object? quickActionCategories = null,
    Object? hiddenCategories = null,
    Object? isLoading = null,
    Object? isSaving = null,
  }) {
    return _then(_self.copyWith(
      displayCategories: null == displayCategories
          ? _self.displayCategories
          : displayCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetRecordCategory>,
      quickActionCategories: null == quickActionCategories
          ? _self.quickActionCategories
          : quickActionCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetRecordCategory>,
      hiddenCategories: null == hiddenCategories
          ? _self.hiddenCategories
          : hiddenCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetRecordCategory>,
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

/// Adds pattern-matching-related methods to [WidgetSettingsState].
extension WidgetSettingsStatePatterns on WidgetSettingsState {
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
    TResult Function(_WidgetSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetSettingsState() when $default != null:
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
    TResult Function(_WidgetSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettingsState():
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
    TResult? Function(_WidgetSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettingsState() when $default != null:
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
            List<WidgetRecordCategory> displayCategories,
            List<WidgetRecordCategory> quickActionCategories,
            List<WidgetRecordCategory> hiddenCategories,
            bool isLoading,
            bool isSaving)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetSettingsState() when $default != null:
        return $default(_that.displayCategories, _that.quickActionCategories,
            _that.hiddenCategories, _that.isLoading, _that.isSaving);
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
            List<WidgetRecordCategory> displayCategories,
            List<WidgetRecordCategory> quickActionCategories,
            List<WidgetRecordCategory> hiddenCategories,
            bool isLoading,
            bool isSaving)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettingsState():
        return $default(_that.displayCategories, _that.quickActionCategories,
            _that.hiddenCategories, _that.isLoading, _that.isSaving);
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
            List<WidgetRecordCategory> displayCategories,
            List<WidgetRecordCategory> quickActionCategories,
            List<WidgetRecordCategory> hiddenCategories,
            bool isLoading,
            bool isSaving)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettingsState() when $default != null:
        return $default(_that.displayCategories, _that.quickActionCategories,
            _that.hiddenCategories, _that.isLoading, _that.isSaving);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WidgetSettingsState extends WidgetSettingsState {
  const _WidgetSettingsState(
      {required final List<WidgetRecordCategory> displayCategories,
      required final List<WidgetRecordCategory> quickActionCategories,
      final List<WidgetRecordCategory> hiddenCategories = const [],
      this.isLoading = false,
      this.isSaving = false})
      : _displayCategories = displayCategories,
        _quickActionCategories = quickActionCategories,
        _hiddenCategories = hiddenCategories,
        super._();

  /// 直近の記録表示カテゴリ（最大3つ）
  final List<WidgetRecordCategory> _displayCategories;

  /// 直近の記録表示カテゴリ（最大3つ）
  @override
  List<WidgetRecordCategory> get displayCategories {
    if (_displayCategories is EqualUnmodifiableListView)
      return _displayCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_displayCategories);
  }

  /// クイックアクションカテゴリ（最大5つ）
  final List<WidgetRecordCategory> _quickActionCategories;

  /// クイックアクションカテゴリ（最大5つ）
  @override
  List<WidgetRecordCategory> get quickActionCategories {
    if (_quickActionCategories is EqualUnmodifiableListView)
      return _quickActionCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickActionCategories);
  }

  /// 授乳表設定で非表示になっているカテゴリ
  final List<WidgetRecordCategory> _hiddenCategories;

  /// 授乳表設定で非表示になっているカテゴリ
  @override
  @JsonKey()
  List<WidgetRecordCategory> get hiddenCategories {
    if (_hiddenCategories is EqualUnmodifiableListView)
      return _hiddenCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenCategories);
  }

  /// 読み込み中かどうか
  @override
  @JsonKey()
  final bool isLoading;

  /// 保存中かどうか
  @override
  @JsonKey()
  final bool isSaving;

  /// Create a copy of WidgetSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WidgetSettingsStateCopyWith<_WidgetSettingsState> get copyWith =>
      __$WidgetSettingsStateCopyWithImpl<_WidgetSettingsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetSettingsState &&
            const DeepCollectionEquality()
                .equals(other._displayCategories, _displayCategories) &&
            const DeepCollectionEquality()
                .equals(other._quickActionCategories, _quickActionCategories) &&
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
      const DeepCollectionEquality().hash(_displayCategories),
      const DeepCollectionEquality().hash(_quickActionCategories),
      const DeepCollectionEquality().hash(_hiddenCategories),
      isLoading,
      isSaving);

  @override
  String toString() {
    return 'WidgetSettingsState(displayCategories: $displayCategories, quickActionCategories: $quickActionCategories, hiddenCategories: $hiddenCategories, isLoading: $isLoading, isSaving: $isSaving)';
  }
}

/// @nodoc
abstract mixin class _$WidgetSettingsStateCopyWith<$Res>
    implements $WidgetSettingsStateCopyWith<$Res> {
  factory _$WidgetSettingsStateCopyWith(_WidgetSettingsState value,
          $Res Function(_WidgetSettingsState) _then) =
      __$WidgetSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<WidgetRecordCategory> displayCategories,
      List<WidgetRecordCategory> quickActionCategories,
      List<WidgetRecordCategory> hiddenCategories,
      bool isLoading,
      bool isSaving});
}

/// @nodoc
class __$WidgetSettingsStateCopyWithImpl<$Res>
    implements _$WidgetSettingsStateCopyWith<$Res> {
  __$WidgetSettingsStateCopyWithImpl(this._self, this._then);

  final _WidgetSettingsState _self;
  final $Res Function(_WidgetSettingsState) _then;

  /// Create a copy of WidgetSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? displayCategories = null,
    Object? quickActionCategories = null,
    Object? hiddenCategories = null,
    Object? isLoading = null,
    Object? isSaving = null,
  }) {
    return _then(_WidgetSettingsState(
      displayCategories: null == displayCategories
          ? _self._displayCategories
          : displayCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetRecordCategory>,
      quickActionCategories: null == quickActionCategories
          ? _self._quickActionCategories
          : quickActionCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetRecordCategory>,
      hiddenCategories: null == hiddenCategories
          ? _self._hiddenCategories
          : hiddenCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetRecordCategory>,
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
