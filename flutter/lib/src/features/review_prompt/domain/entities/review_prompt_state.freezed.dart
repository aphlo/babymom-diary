// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_prompt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewPromptState {
  /// 記録操作の累計回数
  int get recordCount;

  /// アプリ起動回数
  int get appLaunchCount;

  /// レビュー済みフラグ
  bool get hasReviewed;

  /// 最後にダイアログを表示した日付（ISO8601形式）
  String? get lastShownDate;

  /// Create a copy of ReviewPromptState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReviewPromptStateCopyWith<ReviewPromptState> get copyWith =>
      _$ReviewPromptStateCopyWithImpl<ReviewPromptState>(
          this as ReviewPromptState, _$identity);

  /// Serializes this ReviewPromptState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReviewPromptState &&
            (identical(other.recordCount, recordCount) ||
                other.recordCount == recordCount) &&
            (identical(other.appLaunchCount, appLaunchCount) ||
                other.appLaunchCount == appLaunchCount) &&
            (identical(other.hasReviewed, hasReviewed) ||
                other.hasReviewed == hasReviewed) &&
            (identical(other.lastShownDate, lastShownDate) ||
                other.lastShownDate == lastShownDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, recordCount, appLaunchCount, hasReviewed, lastShownDate);

  @override
  String toString() {
    return 'ReviewPromptState(recordCount: $recordCount, appLaunchCount: $appLaunchCount, hasReviewed: $hasReviewed, lastShownDate: $lastShownDate)';
  }
}

/// @nodoc
abstract mixin class $ReviewPromptStateCopyWith<$Res> {
  factory $ReviewPromptStateCopyWith(
          ReviewPromptState value, $Res Function(ReviewPromptState) _then) =
      _$ReviewPromptStateCopyWithImpl;
  @useResult
  $Res call(
      {int recordCount,
      int appLaunchCount,
      bool hasReviewed,
      String? lastShownDate});
}

/// @nodoc
class _$ReviewPromptStateCopyWithImpl<$Res>
    implements $ReviewPromptStateCopyWith<$Res> {
  _$ReviewPromptStateCopyWithImpl(this._self, this._then);

  final ReviewPromptState _self;
  final $Res Function(ReviewPromptState) _then;

  /// Create a copy of ReviewPromptState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordCount = null,
    Object? appLaunchCount = null,
    Object? hasReviewed = null,
    Object? lastShownDate = freezed,
  }) {
    return _then(_self.copyWith(
      recordCount: null == recordCount
          ? _self.recordCount
          : recordCount // ignore: cast_nullable_to_non_nullable
              as int,
      appLaunchCount: null == appLaunchCount
          ? _self.appLaunchCount
          : appLaunchCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasReviewed: null == hasReviewed
          ? _self.hasReviewed
          : hasReviewed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastShownDate: freezed == lastShownDate
          ? _self.lastShownDate
          : lastShownDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReviewPromptState].
extension ReviewPromptStatePatterns on ReviewPromptState {
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
    TResult Function(_ReviewPromptState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReviewPromptState() when $default != null:
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
    TResult Function(_ReviewPromptState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewPromptState():
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
    TResult? Function(_ReviewPromptState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewPromptState() when $default != null:
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
    TResult Function(int recordCount, int appLaunchCount, bool hasReviewed,
            String? lastShownDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReviewPromptState() when $default != null:
        return $default(_that.recordCount, _that.appLaunchCount,
            _that.hasReviewed, _that.lastShownDate);
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
    TResult Function(int recordCount, int appLaunchCount, bool hasReviewed,
            String? lastShownDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewPromptState():
        return $default(_that.recordCount, _that.appLaunchCount,
            _that.hasReviewed, _that.lastShownDate);
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
    TResult? Function(int recordCount, int appLaunchCount, bool hasReviewed,
            String? lastShownDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewPromptState() when $default != null:
        return $default(_that.recordCount, _that.appLaunchCount,
            _that.hasReviewed, _that.lastShownDate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReviewPromptState extends ReviewPromptState {
  const _ReviewPromptState(
      {required this.recordCount,
      required this.appLaunchCount,
      required this.hasReviewed,
      this.lastShownDate})
      : super._();
  factory _ReviewPromptState.fromJson(Map<String, dynamic> json) =>
      _$ReviewPromptStateFromJson(json);

  /// 記録操作の累計回数
  @override
  final int recordCount;

  /// アプリ起動回数
  @override
  final int appLaunchCount;

  /// レビュー済みフラグ
  @override
  final bool hasReviewed;

  /// 最後にダイアログを表示した日付（ISO8601形式）
  @override
  final String? lastShownDate;

  /// Create a copy of ReviewPromptState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReviewPromptStateCopyWith<_ReviewPromptState> get copyWith =>
      __$ReviewPromptStateCopyWithImpl<_ReviewPromptState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReviewPromptStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReviewPromptState &&
            (identical(other.recordCount, recordCount) ||
                other.recordCount == recordCount) &&
            (identical(other.appLaunchCount, appLaunchCount) ||
                other.appLaunchCount == appLaunchCount) &&
            (identical(other.hasReviewed, hasReviewed) ||
                other.hasReviewed == hasReviewed) &&
            (identical(other.lastShownDate, lastShownDate) ||
                other.lastShownDate == lastShownDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, recordCount, appLaunchCount, hasReviewed, lastShownDate);

  @override
  String toString() {
    return 'ReviewPromptState(recordCount: $recordCount, appLaunchCount: $appLaunchCount, hasReviewed: $hasReviewed, lastShownDate: $lastShownDate)';
  }
}

/// @nodoc
abstract mixin class _$ReviewPromptStateCopyWith<$Res>
    implements $ReviewPromptStateCopyWith<$Res> {
  factory _$ReviewPromptStateCopyWith(
          _ReviewPromptState value, $Res Function(_ReviewPromptState) _then) =
      __$ReviewPromptStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int recordCount,
      int appLaunchCount,
      bool hasReviewed,
      String? lastShownDate});
}

/// @nodoc
class __$ReviewPromptStateCopyWithImpl<$Res>
    implements _$ReviewPromptStateCopyWith<$Res> {
  __$ReviewPromptStateCopyWithImpl(this._self, this._then);

  final _ReviewPromptState _self;
  final $Res Function(_ReviewPromptState) _then;

  /// Create a copy of ReviewPromptState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? recordCount = null,
    Object? appLaunchCount = null,
    Object? hasReviewed = null,
    Object? lastShownDate = freezed,
  }) {
    return _then(_ReviewPromptState(
      recordCount: null == recordCount
          ? _self.recordCount
          : recordCount // ignore: cast_nullable_to_non_nullable
              as int,
      appLaunchCount: null == appLaunchCount
          ? _self.appLaunchCount
          : appLaunchCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasReviewed: null == hasReviewed
          ? _self.hasReviewed
          : hasReviewed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastShownDate: freezed == lastShownDate
          ? _self.lastShownDate
          : lastShownDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
