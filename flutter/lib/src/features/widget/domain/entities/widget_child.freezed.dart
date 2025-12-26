// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_child.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WidgetChild {
  String get id;
  String get name;
  DateTime get birthday;

  /// Create a copy of WidgetChild
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WidgetChildCopyWith<WidgetChild> get copyWith =>
      _$WidgetChildCopyWithImpl<WidgetChild>(this as WidgetChild, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WidgetChild &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, birthday);

  @override
  String toString() {
    return 'WidgetChild(id: $id, name: $name, birthday: $birthday)';
  }
}

/// @nodoc
abstract mixin class $WidgetChildCopyWith<$Res> {
  factory $WidgetChildCopyWith(
          WidgetChild value, $Res Function(WidgetChild) _then) =
      _$WidgetChildCopyWithImpl;
  @useResult
  $Res call({String id, String name, DateTime birthday});
}

/// @nodoc
class _$WidgetChildCopyWithImpl<$Res> implements $WidgetChildCopyWith<$Res> {
  _$WidgetChildCopyWithImpl(this._self, this._then);

  final WidgetChild _self;
  final $Res Function(WidgetChild) _then;

  /// Create a copy of WidgetChild
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? birthday = null,
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
      birthday: null == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [WidgetChild].
extension WidgetChildPatterns on WidgetChild {
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
    TResult Function(_WidgetChild value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetChild() when $default != null:
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
    TResult Function(_WidgetChild value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetChild():
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
    TResult? Function(_WidgetChild value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetChild() when $default != null:
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
    TResult Function(String id, String name, DateTime birthday)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WidgetChild() when $default != null:
        return $default(_that.id, _that.name, _that.birthday);
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
    TResult Function(String id, String name, DateTime birthday) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetChild():
        return $default(_that.id, _that.name, _that.birthday);
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
    TResult? Function(String id, String name, DateTime birthday)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WidgetChild() when $default != null:
        return $default(_that.id, _that.name, _that.birthday);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WidgetChild extends WidgetChild {
  const _WidgetChild(
      {required this.id, required this.name, required this.birthday})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime birthday;

  /// Create a copy of WidgetChild
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WidgetChildCopyWith<_WidgetChild> get copyWith =>
      __$WidgetChildCopyWithImpl<_WidgetChild>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetChild &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, birthday);

  @override
  String toString() {
    return 'WidgetChild(id: $id, name: $name, birthday: $birthday)';
  }
}

/// @nodoc
abstract mixin class _$WidgetChildCopyWith<$Res>
    implements $WidgetChildCopyWith<$Res> {
  factory _$WidgetChildCopyWith(
          _WidgetChild value, $Res Function(_WidgetChild) _then) =
      __$WidgetChildCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, DateTime birthday});
}

/// @nodoc
class __$WidgetChildCopyWithImpl<$Res> implements _$WidgetChildCopyWith<$Res> {
  __$WidgetChildCopyWithImpl(this._self, this._then);

  final _WidgetChild _self;
  final $Res Function(_WidgetChild) _then;

  /// Create a copy of WidgetChild
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? birthday = null,
  }) {
    return _then(_WidgetChild(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
