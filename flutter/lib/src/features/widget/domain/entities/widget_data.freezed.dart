// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WidgetData {
  DateTime get lastUpdated;
  String? get selectedChildId;
  List<WidgetChild> get children;
  Map<String, List<WidgetRecord>> get recentRecords;

  /// Create a copy of WidgetData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WidgetDataCopyWith<WidgetData> get copyWith =>
      _$WidgetDataCopyWithImpl<WidgetData>(this as WidgetData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WidgetData &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.selectedChildId, selectedChildId) ||
                other.selectedChildId == selectedChildId) &&
            const DeepCollectionEquality().equals(other.children, children) &&
            const DeepCollectionEquality()
                .equals(other.recentRecords, recentRecords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastUpdated,
      selectedChildId,
      const DeepCollectionEquality().hash(children),
      const DeepCollectionEquality().hash(recentRecords));

  @override
  String toString() {
    return 'WidgetData(lastUpdated: $lastUpdated, selectedChildId: $selectedChildId, children: $children, recentRecords: $recentRecords)';
  }
}

/// @nodoc
abstract mixin class $WidgetDataCopyWith<$Res> {
  factory $WidgetDataCopyWith(
          WidgetData value, $Res Function(WidgetData) _then) =
      _$WidgetDataCopyWithImpl;
  @useResult
  $Res call(
      {DateTime lastUpdated,
      String? selectedChildId,
      List<WidgetChild> children,
      Map<String, List<WidgetRecord>> recentRecords});
}

/// @nodoc
class _$WidgetDataCopyWithImpl<$Res> implements $WidgetDataCopyWith<$Res> {
  _$WidgetDataCopyWithImpl(this._self, this._then);

  final WidgetData _self;
  final $Res Function(WidgetData) _then;

  /// Create a copy of WidgetData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastUpdated = null,
    Object? selectedChildId = freezed,
    Object? children = null,
    Object? recentRecords = null,
  }) {
    return _then(_self.copyWith(
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedChildId: freezed == selectedChildId
          ? _self.selectedChildId
          : selectedChildId // ignore: cast_nullable_to_non_nullable
              as String?,
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<WidgetChild>,
      recentRecords: null == recentRecords
          ? _self.recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as Map<String, List<WidgetRecord>>,
    ));
  }
}

/// Adds pattern-matching-related methods to [WidgetData].
extension WidgetDataPatterns on WidgetData {
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
    TResult Function(_WidgetData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetData() when $default != null:
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
    TResult Function(_WidgetData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetData():
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
    TResult? Function(_WidgetData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetData() when $default != null:
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
            DateTime lastUpdated,
            String? selectedChildId,
            List<WidgetChild> children,
            Map<String, List<WidgetRecord>> recentRecords)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetData() when $default != null:
        return $default(_that.lastUpdated, _that.selectedChildId,
            _that.children, _that.recentRecords);
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
            DateTime lastUpdated,
            String? selectedChildId,
            List<WidgetChild> children,
            Map<String, List<WidgetRecord>> recentRecords)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetData():
        return $default(_that.lastUpdated, _that.selectedChildId,
            _that.children, _that.recentRecords);
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
            DateTime lastUpdated,
            String? selectedChildId,
            List<WidgetChild> children,
            Map<String, List<WidgetRecord>> recentRecords)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetData() when $default != null:
        return $default(_that.lastUpdated, _that.selectedChildId,
            _that.children, _that.recentRecords);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WidgetData extends WidgetData {
  const _WidgetData(
      {required this.lastUpdated,
      this.selectedChildId,
      final List<WidgetChild> children = const [],
      final Map<String, List<WidgetRecord>> recentRecords = const {}})
      : _children = children,
        _recentRecords = recentRecords,
        super._();

  @override
  final DateTime lastUpdated;
  @override
  final String? selectedChildId;
  final List<WidgetChild> _children;
  @override
  @JsonKey()
  List<WidgetChild> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final Map<String, List<WidgetRecord>> _recentRecords;
  @override
  @JsonKey()
  Map<String, List<WidgetRecord>> get recentRecords {
    if (_recentRecords is EqualUnmodifiableMapView) return _recentRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_recentRecords);
  }

  /// Create a copy of WidgetData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WidgetDataCopyWith<_WidgetData> get copyWith =>
      __$WidgetDataCopyWithImpl<_WidgetData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetData &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.selectedChildId, selectedChildId) ||
                other.selectedChildId == selectedChildId) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality()
                .equals(other._recentRecords, _recentRecords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastUpdated,
      selectedChildId,
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(_recentRecords));

  @override
  String toString() {
    return 'WidgetData(lastUpdated: $lastUpdated, selectedChildId: $selectedChildId, children: $children, recentRecords: $recentRecords)';
  }
}

/// @nodoc
abstract mixin class _$WidgetDataCopyWith<$Res>
    implements $WidgetDataCopyWith<$Res> {
  factory _$WidgetDataCopyWith(
          _WidgetData value, $Res Function(_WidgetData) _then) =
      __$WidgetDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime lastUpdated,
      String? selectedChildId,
      List<WidgetChild> children,
      Map<String, List<WidgetRecord>> recentRecords});
}

/// @nodoc
class __$WidgetDataCopyWithImpl<$Res> implements _$WidgetDataCopyWith<$Res> {
  __$WidgetDataCopyWithImpl(this._self, this._then);

  final _WidgetData _self;
  final $Res Function(_WidgetData) _then;

  /// Create a copy of WidgetData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastUpdated = null,
    Object? selectedChildId = freezed,
    Object? children = null,
    Object? recentRecords = null,
  }) {
    return _then(_WidgetData(
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedChildId: freezed == selectedChildId
          ? _self.selectedChildId
          : selectedChildId // ignore: cast_nullable_to_non_nullable
              as String?,
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<WidgetChild>,
      recentRecords: null == recentRecords
          ? _self._recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as Map<String, List<WidgetRecord>>,
    ));
  }
}

// dart format on
