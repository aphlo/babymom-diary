// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mom_diary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MomDiaryDto {
  DateTime get date;
  String? get content;

  /// Create a copy of MomDiaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MomDiaryDtoCopyWith<MomDiaryDto> get copyWith =>
      _$MomDiaryDtoCopyWithImpl<MomDiaryDto>(this as MomDiaryDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MomDiaryDto &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, content);

  @override
  String toString() {
    return 'MomDiaryDto(date: $date, content: $content)';
  }
}

/// @nodoc
abstract mixin class $MomDiaryDtoCopyWith<$Res> {
  factory $MomDiaryDtoCopyWith(
          MomDiaryDto value, $Res Function(MomDiaryDto) _then) =
      _$MomDiaryDtoCopyWithImpl;
  @useResult
  $Res call({DateTime date, String? content});
}

/// @nodoc
class _$MomDiaryDtoCopyWithImpl<$Res> implements $MomDiaryDtoCopyWith<$Res> {
  _$MomDiaryDtoCopyWithImpl(this._self, this._then);

  final MomDiaryDto _self;
  final $Res Function(MomDiaryDto) _then;

  /// Create a copy of MomDiaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? content = freezed,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MomDiaryDto].
extension MomDiaryDtoPatterns on MomDiaryDto {
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
    TResult Function(_MomDiaryDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MomDiaryDto() when $default != null:
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
    TResult Function(_MomDiaryDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryDto():
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
    TResult? Function(_MomDiaryDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryDto() when $default != null:
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
    TResult Function(DateTime date, String? content)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MomDiaryDto() when $default != null:
        return $default(_that.date, _that.content);
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
    TResult Function(DateTime date, String? content) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryDto():
        return $default(_that.date, _that.content);
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
    TResult? Function(DateTime date, String? content)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MomDiaryDto() when $default != null:
        return $default(_that.date, _that.content);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MomDiaryDto extends MomDiaryDto {
  const _MomDiaryDto({required this.date, this.content}) : super._();

  @override
  final DateTime date;
  @override
  final String? content;

  /// Create a copy of MomDiaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MomDiaryDtoCopyWith<_MomDiaryDto> get copyWith =>
      __$MomDiaryDtoCopyWithImpl<_MomDiaryDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MomDiaryDto &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, content);

  @override
  String toString() {
    return 'MomDiaryDto(date: $date, content: $content)';
  }
}

/// @nodoc
abstract mixin class _$MomDiaryDtoCopyWith<$Res>
    implements $MomDiaryDtoCopyWith<$Res> {
  factory _$MomDiaryDtoCopyWith(
          _MomDiaryDto value, $Res Function(_MomDiaryDto) _then) =
      __$MomDiaryDtoCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime date, String? content});
}

/// @nodoc
class __$MomDiaryDtoCopyWithImpl<$Res> implements _$MomDiaryDtoCopyWith<$Res> {
  __$MomDiaryDtoCopyWithImpl(this._self, this._then);

  final _MomDiaryDto _self;
  final $Res Function(_MomDiaryDto) _then;

  /// Create a copy of MomDiaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? content = freezed,
  }) {
    return _then(_MomDiaryDto(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
