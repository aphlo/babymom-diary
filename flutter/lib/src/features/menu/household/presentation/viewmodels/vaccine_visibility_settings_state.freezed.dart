// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_visibility_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineVisibilitySettingsState {
  /// ローディング中かどうか
  bool get isLoading;

  /// エラーメッセージ
  String? get error;

  /// ワクチンIDをキーとした表示設定マップ
  Map<String, bool> get visibilitySettings;

  /// 全てのワクチン情報（id, name）
  List<VaccineDisplayInfo> get vaccines;

  /// 保存中かどうか
  bool get isSaving;

  /// Create a copy of VaccineVisibilitySettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineVisibilitySettingsStateCopyWith<VaccineVisibilitySettingsState>
      get copyWith => _$VaccineVisibilitySettingsStateCopyWithImpl<
              VaccineVisibilitySettingsState>(
          this as VaccineVisibilitySettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineVisibilitySettingsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other.visibilitySettings, visibilitySettings) &&
            const DeepCollectionEquality().equals(other.vaccines, vaccines) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      const DeepCollectionEquality().hash(visibilitySettings),
      const DeepCollectionEquality().hash(vaccines),
      isSaving);

  @override
  String toString() {
    return 'VaccineVisibilitySettingsState(isLoading: $isLoading, error: $error, visibilitySettings: $visibilitySettings, vaccines: $vaccines, isSaving: $isSaving)';
  }
}

/// @nodoc
abstract mixin class $VaccineVisibilitySettingsStateCopyWith<$Res> {
  factory $VaccineVisibilitySettingsStateCopyWith(
          VaccineVisibilitySettingsState value,
          $Res Function(VaccineVisibilitySettingsState) _then) =
      _$VaccineVisibilitySettingsStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      String? error,
      Map<String, bool> visibilitySettings,
      List<VaccineDisplayInfo> vaccines,
      bool isSaving});
}

/// @nodoc
class _$VaccineVisibilitySettingsStateCopyWithImpl<$Res>
    implements $VaccineVisibilitySettingsStateCopyWith<$Res> {
  _$VaccineVisibilitySettingsStateCopyWithImpl(this._self, this._then);

  final VaccineVisibilitySettingsState _self;
  final $Res Function(VaccineVisibilitySettingsState) _then;

  /// Create a copy of VaccineVisibilitySettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? visibilitySettings = null,
    Object? vaccines = null,
    Object? isSaving = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      visibilitySettings: null == visibilitySettings
          ? _self.visibilitySettings
          : visibilitySettings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      vaccines: null == vaccines
          ? _self.vaccines
          : vaccines // ignore: cast_nullable_to_non_nullable
              as List<VaccineDisplayInfo>,
      isSaving: null == isSaving
          ? _self.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineVisibilitySettingsState].
extension VaccineVisibilitySettingsStatePatterns
    on VaccineVisibilitySettingsState {
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
    TResult Function(_VaccineVisibilitySettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettingsState() when $default != null:
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
    TResult Function(_VaccineVisibilitySettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettingsState():
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
    TResult? Function(_VaccineVisibilitySettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettingsState() when $default != null:
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
            bool isLoading,
            String? error,
            Map<String, bool> visibilitySettings,
            List<VaccineDisplayInfo> vaccines,
            bool isSaving)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettingsState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.visibilitySettings,
            _that.vaccines, _that.isSaving);
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
            bool isLoading,
            String? error,
            Map<String, bool> visibilitySettings,
            List<VaccineDisplayInfo> vaccines,
            bool isSaving)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettingsState():
        return $default(_that.isLoading, _that.error, _that.visibilitySettings,
            _that.vaccines, _that.isSaving);
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
            bool isLoading,
            String? error,
            Map<String, bool> visibilitySettings,
            List<VaccineDisplayInfo> vaccines,
            bool isSaving)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineVisibilitySettingsState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.visibilitySettings,
            _that.vaccines, _that.isSaving);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineVisibilitySettingsState extends VaccineVisibilitySettingsState {
  const _VaccineVisibilitySettingsState(
      {this.isLoading = false,
      this.error,
      final Map<String, bool> visibilitySettings = const {},
      final List<VaccineDisplayInfo> vaccines = const [],
      this.isSaving = false})
      : _visibilitySettings = visibilitySettings,
        _vaccines = vaccines,
        super._();

  /// ローディング中かどうか
  @override
  @JsonKey()
  final bool isLoading;

  /// エラーメッセージ
  @override
  final String? error;

  /// ワクチンIDをキーとした表示設定マップ
  final Map<String, bool> _visibilitySettings;

  /// ワクチンIDをキーとした表示設定マップ
  @override
  @JsonKey()
  Map<String, bool> get visibilitySettings {
    if (_visibilitySettings is EqualUnmodifiableMapView)
      return _visibilitySettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_visibilitySettings);
  }

  /// 全てのワクチン情報（id, name）
  final List<VaccineDisplayInfo> _vaccines;

  /// 全てのワクチン情報（id, name）
  @override
  @JsonKey()
  List<VaccineDisplayInfo> get vaccines {
    if (_vaccines is EqualUnmodifiableListView) return _vaccines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vaccines);
  }

  /// 保存中かどうか
  @override
  @JsonKey()
  final bool isSaving;

  /// Create a copy of VaccineVisibilitySettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineVisibilitySettingsStateCopyWith<_VaccineVisibilitySettingsState>
      get copyWith => __$VaccineVisibilitySettingsStateCopyWithImpl<
          _VaccineVisibilitySettingsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineVisibilitySettingsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._visibilitySettings, _visibilitySettings) &&
            const DeepCollectionEquality().equals(other._vaccines, _vaccines) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      const DeepCollectionEquality().hash(_visibilitySettings),
      const DeepCollectionEquality().hash(_vaccines),
      isSaving);

  @override
  String toString() {
    return 'VaccineVisibilitySettingsState(isLoading: $isLoading, error: $error, visibilitySettings: $visibilitySettings, vaccines: $vaccines, isSaving: $isSaving)';
  }
}

/// @nodoc
abstract mixin class _$VaccineVisibilitySettingsStateCopyWith<$Res>
    implements $VaccineVisibilitySettingsStateCopyWith<$Res> {
  factory _$VaccineVisibilitySettingsStateCopyWith(
          _VaccineVisibilitySettingsState value,
          $Res Function(_VaccineVisibilitySettingsState) _then) =
      __$VaccineVisibilitySettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? error,
      Map<String, bool> visibilitySettings,
      List<VaccineDisplayInfo> vaccines,
      bool isSaving});
}

/// @nodoc
class __$VaccineVisibilitySettingsStateCopyWithImpl<$Res>
    implements _$VaccineVisibilitySettingsStateCopyWith<$Res> {
  __$VaccineVisibilitySettingsStateCopyWithImpl(this._self, this._then);

  final _VaccineVisibilitySettingsState _self;
  final $Res Function(_VaccineVisibilitySettingsState) _then;

  /// Create a copy of VaccineVisibilitySettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? visibilitySettings = null,
    Object? vaccines = null,
    Object? isSaving = null,
  }) {
    return _then(_VaccineVisibilitySettingsState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      visibilitySettings: null == visibilitySettings
          ? _self._visibilitySettings
          : visibilitySettings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      vaccines: null == vaccines
          ? _self._vaccines
          : vaccines // ignore: cast_nullable_to_non_nullable
              as List<VaccineDisplayInfo>,
      isSaving: null == isSaving
          ? _self.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$VaccineDisplayInfo {
  String get id;
  String get name;

  /// Create a copy of VaccineDisplayInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineDisplayInfoCopyWith<VaccineDisplayInfo> get copyWith =>
      _$VaccineDisplayInfoCopyWithImpl<VaccineDisplayInfo>(
          this as VaccineDisplayInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineDisplayInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'VaccineDisplayInfo(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $VaccineDisplayInfoCopyWith<$Res> {
  factory $VaccineDisplayInfoCopyWith(
          VaccineDisplayInfo value, $Res Function(VaccineDisplayInfo) _then) =
      _$VaccineDisplayInfoCopyWithImpl;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$VaccineDisplayInfoCopyWithImpl<$Res>
    implements $VaccineDisplayInfoCopyWith<$Res> {
  _$VaccineDisplayInfoCopyWithImpl(this._self, this._then);

  final VaccineDisplayInfo _self;
  final $Res Function(VaccineDisplayInfo) _then;

  /// Create a copy of VaccineDisplayInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineDisplayInfo].
extension VaccineDisplayInfoPatterns on VaccineDisplayInfo {
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
    TResult Function(_VaccineDisplayInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDisplayInfo() when $default != null:
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
    TResult Function(_VaccineDisplayInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDisplayInfo():
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
    TResult? Function(_VaccineDisplayInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDisplayInfo() when $default != null:
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
    TResult Function(String id, String name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDisplayInfo() when $default != null:
        return $default(_that.id, _that.name);
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
    TResult Function(String id, String name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDisplayInfo():
        return $default(_that.id, _that.name);
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
    TResult? Function(String id, String name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDisplayInfo() when $default != null:
        return $default(_that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VaccineDisplayInfo implements VaccineDisplayInfo {
  const _VaccineDisplayInfo({required this.id, required this.name});

  @override
  final String id;
  @override
  final String name;

  /// Create a copy of VaccineDisplayInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineDisplayInfoCopyWith<_VaccineDisplayInfo> get copyWith =>
      __$VaccineDisplayInfoCopyWithImpl<_VaccineDisplayInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineDisplayInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'VaccineDisplayInfo(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$VaccineDisplayInfoCopyWith<$Res>
    implements $VaccineDisplayInfoCopyWith<$Res> {
  factory _$VaccineDisplayInfoCopyWith(
          _VaccineDisplayInfo value, $Res Function(_VaccineDisplayInfo) _then) =
      __$VaccineDisplayInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$VaccineDisplayInfoCopyWithImpl<$Res>
    implements _$VaccineDisplayInfoCopyWith<$Res> {
  __$VaccineDisplayInfoCopyWithImpl(this._self, this._then);

  final _VaccineDisplayInfo _self;
  final $Res Function(_VaccineDisplayInfo) _then;

  /// Create a copy of VaccineDisplayInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_VaccineDisplayInfo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
