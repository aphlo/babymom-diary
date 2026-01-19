// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feeding_table_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedingTableSettings {
  /// 表示するカテゴリの順序付きリスト
  /// リストに含まれるカテゴリのみ表示される
  List<FeedingTableCategory> get visibleCategories;

  /// Create a copy of FeedingTableSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeedingTableSettingsCopyWith<FeedingTableSettings> get copyWith =>
      _$FeedingTableSettingsCopyWithImpl<FeedingTableSettings>(
          this as FeedingTableSettings, _$identity);

  /// Serializes this FeedingTableSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeedingTableSettings &&
            const DeepCollectionEquality()
                .equals(other.visibleCategories, visibleCategories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(visibleCategories));

  @override
  String toString() {
    return 'FeedingTableSettings(visibleCategories: $visibleCategories)';
  }
}

/// @nodoc
abstract mixin class $FeedingTableSettingsCopyWith<$Res> {
  factory $FeedingTableSettingsCopyWith(FeedingTableSettings value,
          $Res Function(FeedingTableSettings) _then) =
      _$FeedingTableSettingsCopyWithImpl;
  @useResult
  $Res call({List<FeedingTableCategory> visibleCategories});
}

/// @nodoc
class _$FeedingTableSettingsCopyWithImpl<$Res>
    implements $FeedingTableSettingsCopyWith<$Res> {
  _$FeedingTableSettingsCopyWithImpl(this._self, this._then);

  final FeedingTableSettings _self;
  final $Res Function(FeedingTableSettings) _then;

  /// Create a copy of FeedingTableSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visibleCategories = null,
  }) {
    return _then(_self.copyWith(
      visibleCategories: null == visibleCategories
          ? _self.visibleCategories
          : visibleCategories // ignore: cast_nullable_to_non_nullable
              as List<FeedingTableCategory>,
    ));
  }
}

/// Adds pattern-matching-related methods to [FeedingTableSettings].
extension FeedingTableSettingsPatterns on FeedingTableSettings {
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
    TResult Function(_FeedingTableSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettings() when $default != null:
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
    TResult Function(_FeedingTableSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettings():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_FeedingTableSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettings() when $default != null:
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
    TResult Function(List<FeedingTableCategory> visibleCategories)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettings() when $default != null:
        return $default(_that.visibleCategories);
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
    TResult Function(List<FeedingTableCategory> visibleCategories) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettings():
        return $default(_that.visibleCategories);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(List<FeedingTableCategory> visibleCategories)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeedingTableSettings() when $default != null:
        return $default(_that.visibleCategories);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FeedingTableSettings extends FeedingTableSettings {
  const _FeedingTableSettings(
      {final List<FeedingTableCategory> visibleCategories = const [
        FeedingTableCategory.nursing,
        FeedingTableCategory.formula,
        FeedingTableCategory.pump,
        FeedingTableCategory.babyFood,
        FeedingTableCategory.pee,
        FeedingTableCategory.poop,
        FeedingTableCategory.temperature,
        FeedingTableCategory.other
      ]})
      : _visibleCategories = visibleCategories,
        super._();
  factory _FeedingTableSettings.fromJson(Map<String, dynamic> json) =>
      _$FeedingTableSettingsFromJson(json);

  /// 表示するカテゴリの順序付きリスト
  /// リストに含まれるカテゴリのみ表示される
  final List<FeedingTableCategory> _visibleCategories;

  /// 表示するカテゴリの順序付きリスト
  /// リストに含まれるカテゴリのみ表示される
  @override
  @JsonKey()
  List<FeedingTableCategory> get visibleCategories {
    if (_visibleCategories is EqualUnmodifiableListView)
      return _visibleCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleCategories);
  }

  /// Create a copy of FeedingTableSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FeedingTableSettingsCopyWith<_FeedingTableSettings> get copyWith =>
      __$FeedingTableSettingsCopyWithImpl<_FeedingTableSettings>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FeedingTableSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FeedingTableSettings &&
            const DeepCollectionEquality()
                .equals(other._visibleCategories, _visibleCategories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_visibleCategories));

  @override
  String toString() {
    return 'FeedingTableSettings(visibleCategories: $visibleCategories)';
  }
}

/// @nodoc
abstract mixin class _$FeedingTableSettingsCopyWith<$Res>
    implements $FeedingTableSettingsCopyWith<$Res> {
  factory _$FeedingTableSettingsCopyWith(_FeedingTableSettings value,
          $Res Function(_FeedingTableSettings) _then) =
      __$FeedingTableSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({List<FeedingTableCategory> visibleCategories});
}

/// @nodoc
class __$FeedingTableSettingsCopyWithImpl<$Res>
    implements _$FeedingTableSettingsCopyWith<$Res> {
  __$FeedingTableSettingsCopyWithImpl(this._self, this._then);

  final _FeedingTableSettings _self;
  final $Res Function(_FeedingTableSettings) _then;

  /// Create a copy of FeedingTableSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? visibleCategories = null,
  }) {
    return _then(_FeedingTableSettings(
      visibleCategories: null == visibleCategories
          ? _self._visibleCategories
          : visibleCategories // ignore: cast_nullable_to_non_nullable
              as List<FeedingTableCategory>,
    ));
  }
}

// dart format on
