// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_visibility_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineVisibilitySettings {
  /// 世帯ID
  String get householdId;

  /// ワクチンIDをキーとした表示設定マップ
  /// true: 表示, false: 非表示
  /// キーが存在しない場合はデフォルトで表示
  Map<String, bool> get visibilityMap;

  /// Create a copy of VaccineVisibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineVisibilitySettingsCopyWith<VaccineVisibilitySettings> get copyWith =>
      _$VaccineVisibilitySettingsCopyWithImpl<VaccineVisibilitySettings>(
          this as VaccineVisibilitySettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineVisibilitySettings &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            const DeepCollectionEquality()
                .equals(other.visibilityMap, visibilityMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, householdId,
      const DeepCollectionEquality().hash(visibilityMap));

  @override
  String toString() {
    return 'VaccineVisibilitySettings(householdId: $householdId, visibilityMap: $visibilityMap)';
  }
}

/// @nodoc
abstract mixin class $VaccineVisibilitySettingsCopyWith<$Res> {
  factory $VaccineVisibilitySettingsCopyWith(VaccineVisibilitySettings value,
          $Res Function(VaccineVisibilitySettings) _then) =
      _$VaccineVisibilitySettingsCopyWithImpl;
  @useResult
  $Res call({String householdId, Map<String, bool> visibilityMap});
}

/// @nodoc
class _$VaccineVisibilitySettingsCopyWithImpl<$Res>
    implements $VaccineVisibilitySettingsCopyWith<$Res> {
  _$VaccineVisibilitySettingsCopyWithImpl(this._self, this._then);

  final VaccineVisibilitySettings _self;
  final $Res Function(VaccineVisibilitySettings) _then;

  /// Create a copy of VaccineVisibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = null,
    Object? visibilityMap = null,
  }) {
    return _then(_self.copyWith(
      householdId: null == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      visibilityMap: null == visibilityMap
          ? _self.visibilityMap
          : visibilityMap // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineVisibilitySettings].
extension VaccineVisibilitySettingsPatterns on VaccineVisibilitySettings {
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
    TResult Function(_VaccineVisibilitySettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettings() when $default != null:
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
    TResult Function(_VaccineVisibilitySettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettings():
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
    TResult? Function(_VaccineVisibilitySettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettings() when $default != null:
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
    TResult Function(String householdId, Map<String, bool> visibilityMap)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettings() when $default != null:
        return $default(_that.householdId, _that.visibilityMap);
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
    TResult Function(String householdId, Map<String, bool> visibilityMap)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettings():
        return $default(_that.householdId, _that.visibilityMap);
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
    TResult? Function(String householdId, Map<String, bool> visibilityMap)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettings() when $default != null:
        return $default(_that.householdId, _that.visibilityMap);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineVisibilitySettings extends VaccineVisibilitySettings {
  const _VaccineVisibilitySettings(
      {required this.householdId,
      required final Map<String, bool> visibilityMap})
      : _visibilityMap = visibilityMap,
        super._();

  /// 世帯ID
  @override
  final String householdId;

  /// ワクチンIDをキーとした表示設定マップ
  /// true: 表示, false: 非表示
  /// キーが存在しない場合はデフォルトで表示
  final Map<String, bool> _visibilityMap;

  /// ワクチンIDをキーとした表示設定マップ
  /// true: 表示, false: 非表示
  /// キーが存在しない場合はデフォルトで表示
  @override
  Map<String, bool> get visibilityMap {
    if (_visibilityMap is EqualUnmodifiableMapView) return _visibilityMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_visibilityMap);
  }

  /// Create a copy of VaccineVisibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineVisibilitySettingsCopyWith<_VaccineVisibilitySettings>
      get copyWith =>
          __$VaccineVisibilitySettingsCopyWithImpl<_VaccineVisibilitySettings>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineVisibilitySettings &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            const DeepCollectionEquality()
                .equals(other._visibilityMap, _visibilityMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, householdId,
      const DeepCollectionEquality().hash(_visibilityMap));

  @override
  String toString() {
    return 'VaccineVisibilitySettings(householdId: $householdId, visibilityMap: $visibilityMap)';
  }
}

/// @nodoc
abstract mixin class _$VaccineVisibilitySettingsCopyWith<$Res>
    implements $VaccineVisibilitySettingsCopyWith<$Res> {
  factory _$VaccineVisibilitySettingsCopyWith(_VaccineVisibilitySettings value,
          $Res Function(_VaccineVisibilitySettings) _then) =
      __$VaccineVisibilitySettingsCopyWithImpl;
  @override
  @useResult
  $Res call({String householdId, Map<String, bool> visibilityMap});
}

/// @nodoc
class __$VaccineVisibilitySettingsCopyWithImpl<$Res>
    implements _$VaccineVisibilitySettingsCopyWith<$Res> {
  __$VaccineVisibilitySettingsCopyWithImpl(this._self, this._then);

  final _VaccineVisibilitySettings _self;
  final $Res Function(_VaccineVisibilitySettings) _then;

  /// Create a copy of VaccineVisibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? householdId = null,
    Object? visibilityMap = null,
  }) {
    return _then(_VaccineVisibilitySettings(
      householdId: null == householdId
          ? _self.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      visibilityMap: null == visibilityMap
          ? _self._visibilityMap
          : visibilityMap // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

// dart format on
