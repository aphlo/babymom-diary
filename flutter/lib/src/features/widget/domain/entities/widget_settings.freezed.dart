// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediumWidgetSettings {
  List<RecordType> get displayRecordTypes;
  List<RecordType> get quickActionTypes;

  /// Create a copy of MediumWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MediumWidgetSettingsCopyWith<MediumWidgetSettings> get copyWith =>
      _$MediumWidgetSettingsCopyWithImpl<MediumWidgetSettings>(
          this as MediumWidgetSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MediumWidgetSettings &&
            const DeepCollectionEquality()
                .equals(other.displayRecordTypes, displayRecordTypes) &&
            const DeepCollectionEquality()
                .equals(other.quickActionTypes, quickActionTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(displayRecordTypes),
      const DeepCollectionEquality().hash(quickActionTypes));

  @override
  String toString() {
    return 'MediumWidgetSettings(displayRecordTypes: $displayRecordTypes, quickActionTypes: $quickActionTypes)';
  }
}

/// @nodoc
abstract mixin class $MediumWidgetSettingsCopyWith<$Res> {
  factory $MediumWidgetSettingsCopyWith(MediumWidgetSettings value,
          $Res Function(MediumWidgetSettings) _then) =
      _$MediumWidgetSettingsCopyWithImpl;
  @useResult
  $Res call(
      {List<RecordType> displayRecordTypes, List<RecordType> quickActionTypes});
}

/// @nodoc
class _$MediumWidgetSettingsCopyWithImpl<$Res>
    implements $MediumWidgetSettingsCopyWith<$Res> {
  _$MediumWidgetSettingsCopyWithImpl(this._self, this._then);

  final MediumWidgetSettings _self;
  final $Res Function(MediumWidgetSettings) _then;

  /// Create a copy of MediumWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayRecordTypes = null,
    Object? quickActionTypes = null,
  }) {
    return _then(_self.copyWith(
      displayRecordTypes: null == displayRecordTypes
          ? _self.displayRecordTypes
          : displayRecordTypes // ignore: cast_nullable_to_non_nullable
              as List<RecordType>,
      quickActionTypes: null == quickActionTypes
          ? _self.quickActionTypes
          : quickActionTypes // ignore: cast_nullable_to_non_nullable
              as List<RecordType>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MediumWidgetSettings].
extension MediumWidgetSettingsPatterns on MediumWidgetSettings {
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
    TResult Function(_MediumWidgetSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediumWidgetSettings() when $default != null:
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
    TResult Function(_MediumWidgetSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediumWidgetSettings():
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
    TResult? Function(_MediumWidgetSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediumWidgetSettings() when $default != null:
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
    TResult Function(List<RecordType> displayRecordTypes,
            List<RecordType> quickActionTypes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediumWidgetSettings() when $default != null:
        return $default(_that.displayRecordTypes, _that.quickActionTypes);
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
    TResult Function(List<RecordType> displayRecordTypes,
            List<RecordType> quickActionTypes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediumWidgetSettings():
        return $default(_that.displayRecordTypes, _that.quickActionTypes);
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
    TResult? Function(List<RecordType> displayRecordTypes,
            List<RecordType> quickActionTypes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediumWidgetSettings() when $default != null:
        return $default(_that.displayRecordTypes, _that.quickActionTypes);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MediumWidgetSettings extends MediumWidgetSettings {
  const _MediumWidgetSettings(
      {final List<RecordType> displayRecordTypes = const [
        RecordType.breastRight,
        RecordType.formula,
        RecordType.pee
      ],
      final List<RecordType> quickActionTypes = const [
        RecordType.breastLeft,
        RecordType.formula,
        RecordType.pee,
        RecordType.poop,
        RecordType.temperature
      ]})
      : _displayRecordTypes = displayRecordTypes,
        _quickActionTypes = quickActionTypes,
        super._();

  final List<RecordType> _displayRecordTypes;
  @override
  @JsonKey()
  List<RecordType> get displayRecordTypes {
    if (_displayRecordTypes is EqualUnmodifiableListView)
      return _displayRecordTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_displayRecordTypes);
  }

  final List<RecordType> _quickActionTypes;
  @override
  @JsonKey()
  List<RecordType> get quickActionTypes {
    if (_quickActionTypes is EqualUnmodifiableListView)
      return _quickActionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickActionTypes);
  }

  /// Create a copy of MediumWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MediumWidgetSettingsCopyWith<_MediumWidgetSettings> get copyWith =>
      __$MediumWidgetSettingsCopyWithImpl<_MediumWidgetSettings>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MediumWidgetSettings &&
            const DeepCollectionEquality()
                .equals(other._displayRecordTypes, _displayRecordTypes) &&
            const DeepCollectionEquality()
                .equals(other._quickActionTypes, _quickActionTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_displayRecordTypes),
      const DeepCollectionEquality().hash(_quickActionTypes));

  @override
  String toString() {
    return 'MediumWidgetSettings(displayRecordTypes: $displayRecordTypes, quickActionTypes: $quickActionTypes)';
  }
}

/// @nodoc
abstract mixin class _$MediumWidgetSettingsCopyWith<$Res>
    implements $MediumWidgetSettingsCopyWith<$Res> {
  factory _$MediumWidgetSettingsCopyWith(_MediumWidgetSettings value,
          $Res Function(_MediumWidgetSettings) _then) =
      __$MediumWidgetSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<RecordType> displayRecordTypes, List<RecordType> quickActionTypes});
}

/// @nodoc
class __$MediumWidgetSettingsCopyWithImpl<$Res>
    implements _$MediumWidgetSettingsCopyWith<$Res> {
  __$MediumWidgetSettingsCopyWithImpl(this._self, this._then);

  final _MediumWidgetSettings _self;
  final $Res Function(_MediumWidgetSettings) _then;

  /// Create a copy of MediumWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? displayRecordTypes = null,
    Object? quickActionTypes = null,
  }) {
    return _then(_MediumWidgetSettings(
      displayRecordTypes: null == displayRecordTypes
          ? _self._displayRecordTypes
          : displayRecordTypes // ignore: cast_nullable_to_non_nullable
              as List<RecordType>,
      quickActionTypes: null == quickActionTypes
          ? _self._quickActionTypes
          : quickActionTypes // ignore: cast_nullable_to_non_nullable
              as List<RecordType>,
    ));
  }
}

/// @nodoc
mixin _$SmallWidgetSettings {
  RecordType? get filterRecordType;

  /// Create a copy of SmallWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SmallWidgetSettingsCopyWith<SmallWidgetSettings> get copyWith =>
      _$SmallWidgetSettingsCopyWithImpl<SmallWidgetSettings>(
          this as SmallWidgetSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SmallWidgetSettings &&
            (identical(other.filterRecordType, filterRecordType) ||
                other.filterRecordType == filterRecordType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterRecordType);

  @override
  String toString() {
    return 'SmallWidgetSettings(filterRecordType: $filterRecordType)';
  }
}

/// @nodoc
abstract mixin class $SmallWidgetSettingsCopyWith<$Res> {
  factory $SmallWidgetSettingsCopyWith(
          SmallWidgetSettings value, $Res Function(SmallWidgetSettings) _then) =
      _$SmallWidgetSettingsCopyWithImpl;
  @useResult
  $Res call({RecordType? filterRecordType});
}

/// @nodoc
class _$SmallWidgetSettingsCopyWithImpl<$Res>
    implements $SmallWidgetSettingsCopyWith<$Res> {
  _$SmallWidgetSettingsCopyWithImpl(this._self, this._then);

  final SmallWidgetSettings _self;
  final $Res Function(SmallWidgetSettings) _then;

  /// Create a copy of SmallWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterRecordType = freezed,
  }) {
    return _then(_self.copyWith(
      filterRecordType: freezed == filterRecordType
          ? _self.filterRecordType
          : filterRecordType // ignore: cast_nullable_to_non_nullable
              as RecordType?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SmallWidgetSettings].
extension SmallWidgetSettingsPatterns on SmallWidgetSettings {
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
    TResult Function(_SmallWidgetSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmallWidgetSettings() when $default != null:
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
    TResult Function(_SmallWidgetSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmallWidgetSettings():
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
    TResult? Function(_SmallWidgetSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmallWidgetSettings() when $default != null:
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
    TResult Function(RecordType? filterRecordType)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmallWidgetSettings() when $default != null:
        return $default(_that.filterRecordType);
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
    TResult Function(RecordType? filterRecordType) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmallWidgetSettings():
        return $default(_that.filterRecordType);
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
    TResult? Function(RecordType? filterRecordType)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmallWidgetSettings() when $default != null:
        return $default(_that.filterRecordType);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SmallWidgetSettings extends SmallWidgetSettings {
  const _SmallWidgetSettings({this.filterRecordType}) : super._();

  @override
  final RecordType? filterRecordType;

  /// Create a copy of SmallWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SmallWidgetSettingsCopyWith<_SmallWidgetSettings> get copyWith =>
      __$SmallWidgetSettingsCopyWithImpl<_SmallWidgetSettings>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SmallWidgetSettings &&
            (identical(other.filterRecordType, filterRecordType) ||
                other.filterRecordType == filterRecordType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterRecordType);

  @override
  String toString() {
    return 'SmallWidgetSettings(filterRecordType: $filterRecordType)';
  }
}

/// @nodoc
abstract mixin class _$SmallWidgetSettingsCopyWith<$Res>
    implements $SmallWidgetSettingsCopyWith<$Res> {
  factory _$SmallWidgetSettingsCopyWith(_SmallWidgetSettings value,
          $Res Function(_SmallWidgetSettings) _then) =
      __$SmallWidgetSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({RecordType? filterRecordType});
}

/// @nodoc
class __$SmallWidgetSettingsCopyWithImpl<$Res>
    implements _$SmallWidgetSettingsCopyWith<$Res> {
  __$SmallWidgetSettingsCopyWithImpl(this._self, this._then);

  final _SmallWidgetSettings _self;
  final $Res Function(_SmallWidgetSettings) _then;

  /// Create a copy of SmallWidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filterRecordType = freezed,
  }) {
    return _then(_SmallWidgetSettings(
      filterRecordType: freezed == filterRecordType
          ? _self.filterRecordType
          : filterRecordType // ignore: cast_nullable_to_non_nullable
              as RecordType?,
    ));
  }
}

/// @nodoc
mixin _$WidgetSettings {
  MediumWidgetSettings get mediumWidget;
  SmallWidgetSettings get smallWidget;

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WidgetSettingsCopyWith<WidgetSettings> get copyWith =>
      _$WidgetSettingsCopyWithImpl<WidgetSettings>(
          this as WidgetSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WidgetSettings &&
            (identical(other.mediumWidget, mediumWidget) ||
                other.mediumWidget == mediumWidget) &&
            (identical(other.smallWidget, smallWidget) ||
                other.smallWidget == smallWidget));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mediumWidget, smallWidget);

  @override
  String toString() {
    return 'WidgetSettings(mediumWidget: $mediumWidget, smallWidget: $smallWidget)';
  }
}

/// @nodoc
abstract mixin class $WidgetSettingsCopyWith<$Res> {
  factory $WidgetSettingsCopyWith(
          WidgetSettings value, $Res Function(WidgetSettings) _then) =
      _$WidgetSettingsCopyWithImpl;
  @useResult
  $Res call(
      {MediumWidgetSettings mediumWidget, SmallWidgetSettings smallWidget});

  $MediumWidgetSettingsCopyWith<$Res> get mediumWidget;
  $SmallWidgetSettingsCopyWith<$Res> get smallWidget;
}

/// @nodoc
class _$WidgetSettingsCopyWithImpl<$Res>
    implements $WidgetSettingsCopyWith<$Res> {
  _$WidgetSettingsCopyWithImpl(this._self, this._then);

  final WidgetSettings _self;
  final $Res Function(WidgetSettings) _then;

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediumWidget = null,
    Object? smallWidget = null,
  }) {
    return _then(_self.copyWith(
      mediumWidget: null == mediumWidget
          ? _self.mediumWidget
          : mediumWidget // ignore: cast_nullable_to_non_nullable
              as MediumWidgetSettings,
      smallWidget: null == smallWidget
          ? _self.smallWidget
          : smallWidget // ignore: cast_nullable_to_non_nullable
              as SmallWidgetSettings,
    ));
  }

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediumWidgetSettingsCopyWith<$Res> get mediumWidget {
    return $MediumWidgetSettingsCopyWith<$Res>(_self.mediumWidget, (value) {
      return _then(_self.copyWith(mediumWidget: value));
    });
  }

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmallWidgetSettingsCopyWith<$Res> get smallWidget {
    return $SmallWidgetSettingsCopyWith<$Res>(_self.smallWidget, (value) {
      return _then(_self.copyWith(smallWidget: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WidgetSettings].
extension WidgetSettingsPatterns on WidgetSettings {
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
    TResult Function(_WidgetSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetSettings() when $default != null:
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
    TResult Function(_WidgetSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettings():
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
    TResult? Function(_WidgetSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettings() when $default != null:
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
            MediumWidgetSettings mediumWidget, SmallWidgetSettings smallWidget)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetSettings() when $default != null:
        return $default(_that.mediumWidget, _that.smallWidget);
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
            MediumWidgetSettings mediumWidget, SmallWidgetSettings smallWidget)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettings():
        return $default(_that.mediumWidget, _that.smallWidget);
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
            MediumWidgetSettings mediumWidget, SmallWidgetSettings smallWidget)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetSettings() when $default != null:
        return $default(_that.mediumWidget, _that.smallWidget);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WidgetSettings extends WidgetSettings {
  const _WidgetSettings(
      {this.mediumWidget = const MediumWidgetSettings(),
      this.smallWidget = const SmallWidgetSettings()})
      : super._();

  @override
  @JsonKey()
  final MediumWidgetSettings mediumWidget;
  @override
  @JsonKey()
  final SmallWidgetSettings smallWidget;

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WidgetSettingsCopyWith<_WidgetSettings> get copyWith =>
      __$WidgetSettingsCopyWithImpl<_WidgetSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetSettings &&
            (identical(other.mediumWidget, mediumWidget) ||
                other.mediumWidget == mediumWidget) &&
            (identical(other.smallWidget, smallWidget) ||
                other.smallWidget == smallWidget));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mediumWidget, smallWidget);

  @override
  String toString() {
    return 'WidgetSettings(mediumWidget: $mediumWidget, smallWidget: $smallWidget)';
  }
}

/// @nodoc
abstract mixin class _$WidgetSettingsCopyWith<$Res>
    implements $WidgetSettingsCopyWith<$Res> {
  factory _$WidgetSettingsCopyWith(
          _WidgetSettings value, $Res Function(_WidgetSettings) _then) =
      __$WidgetSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {MediumWidgetSettings mediumWidget, SmallWidgetSettings smallWidget});

  @override
  $MediumWidgetSettingsCopyWith<$Res> get mediumWidget;
  @override
  $SmallWidgetSettingsCopyWith<$Res> get smallWidget;
}

/// @nodoc
class __$WidgetSettingsCopyWithImpl<$Res>
    implements _$WidgetSettingsCopyWith<$Res> {
  __$WidgetSettingsCopyWithImpl(this._self, this._then);

  final _WidgetSettings _self;
  final $Res Function(_WidgetSettings) _then;

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediumWidget = null,
    Object? smallWidget = null,
  }) {
    return _then(_WidgetSettings(
      mediumWidget: null == mediumWidget
          ? _self.mediumWidget
          : mediumWidget // ignore: cast_nullable_to_non_nullable
              as MediumWidgetSettings,
      smallWidget: null == smallWidget
          ? _self.smallWidget
          : smallWidget // ignore: cast_nullable_to_non_nullable
              as SmallWidgetSettings,
    ));
  }

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediumWidgetSettingsCopyWith<$Res> get mediumWidget {
    return $MediumWidgetSettingsCopyWith<$Res>(_self.mediumWidget, (value) {
      return _then(_self.copyWith(mediumWidget: value));
    });
  }

  /// Create a copy of WidgetSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmallWidgetSettingsCopyWith<$Res> get smallWidget {
    return $SmallWidgetSettingsCopyWith<$Res>(_self.smallWidget, (value) {
      return _then(_self.copyWith(smallWidget: value));
    });
  }
}

// dart format on
