// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editable_record_sheet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditableRecordSheetViewModelArgs {
  RecordDraft get initialDraft;
  bool get isNew;

  /// Create a copy of EditableRecordSheetViewModelArgs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditableRecordSheetViewModelArgsCopyWith<EditableRecordSheetViewModelArgs>
      get copyWith => _$EditableRecordSheetViewModelArgsCopyWithImpl<
              EditableRecordSheetViewModelArgs>(
          this as EditableRecordSheetViewModelArgs, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditableRecordSheetViewModelArgs &&
            (identical(other.initialDraft, initialDraft) ||
                other.initialDraft == initialDraft) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialDraft, isNew);

  @override
  String toString() {
    return 'EditableRecordSheetViewModelArgs(initialDraft: $initialDraft, isNew: $isNew)';
  }
}

/// @nodoc
abstract mixin class $EditableRecordSheetViewModelArgsCopyWith<$Res> {
  factory $EditableRecordSheetViewModelArgsCopyWith(
          EditableRecordSheetViewModelArgs value,
          $Res Function(EditableRecordSheetViewModelArgs) _then) =
      _$EditableRecordSheetViewModelArgsCopyWithImpl;
  @useResult
  $Res call({RecordDraft initialDraft, bool isNew});
}

/// @nodoc
class _$EditableRecordSheetViewModelArgsCopyWithImpl<$Res>
    implements $EditableRecordSheetViewModelArgsCopyWith<$Res> {
  _$EditableRecordSheetViewModelArgsCopyWithImpl(this._self, this._then);

  final EditableRecordSheetViewModelArgs _self;
  final $Res Function(EditableRecordSheetViewModelArgs) _then;

  /// Create a copy of EditableRecordSheetViewModelArgs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialDraft = null,
    Object? isNew = null,
  }) {
    return _then(_self.copyWith(
      initialDraft: null == initialDraft
          ? _self.initialDraft
          : initialDraft // ignore: cast_nullable_to_non_nullable
              as RecordDraft,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [EditableRecordSheetViewModelArgs].
extension EditableRecordSheetViewModelArgsPatterns
    on EditableRecordSheetViewModelArgs {
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
    TResult Function(_EditableRecordSheetViewModelArgs value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetViewModelArgs() when $default != null:
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
    TResult Function(_EditableRecordSheetViewModelArgs value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetViewModelArgs():
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
    TResult? Function(_EditableRecordSheetViewModelArgs value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetViewModelArgs() when $default != null:
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
    TResult Function(RecordDraft initialDraft, bool isNew)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetViewModelArgs() when $default != null:
        return $default(_that.initialDraft, _that.isNew);
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
    TResult Function(RecordDraft initialDraft, bool isNew) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetViewModelArgs():
        return $default(_that.initialDraft, _that.isNew);
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
    TResult? Function(RecordDraft initialDraft, bool isNew)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetViewModelArgs() when $default != null:
        return $default(_that.initialDraft, _that.isNew);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EditableRecordSheetViewModelArgs
    implements EditableRecordSheetViewModelArgs {
  const _EditableRecordSheetViewModelArgs(
      {required this.initialDraft, required this.isNew});

  @override
  final RecordDraft initialDraft;
  @override
  final bool isNew;

  /// Create a copy of EditableRecordSheetViewModelArgs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditableRecordSheetViewModelArgsCopyWith<_EditableRecordSheetViewModelArgs>
      get copyWith => __$EditableRecordSheetViewModelArgsCopyWithImpl<
          _EditableRecordSheetViewModelArgs>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditableRecordSheetViewModelArgs &&
            (identical(other.initialDraft, initialDraft) ||
                other.initialDraft == initialDraft) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialDraft, isNew);

  @override
  String toString() {
    return 'EditableRecordSheetViewModelArgs(initialDraft: $initialDraft, isNew: $isNew)';
  }
}

/// @nodoc
abstract mixin class _$EditableRecordSheetViewModelArgsCopyWith<$Res>
    implements $EditableRecordSheetViewModelArgsCopyWith<$Res> {
  factory _$EditableRecordSheetViewModelArgsCopyWith(
          _EditableRecordSheetViewModelArgs value,
          $Res Function(_EditableRecordSheetViewModelArgs) _then) =
      __$EditableRecordSheetViewModelArgsCopyWithImpl;
  @override
  @useResult
  $Res call({RecordDraft initialDraft, bool isNew});
}

/// @nodoc
class __$EditableRecordSheetViewModelArgsCopyWithImpl<$Res>
    implements _$EditableRecordSheetViewModelArgsCopyWith<$Res> {
  __$EditableRecordSheetViewModelArgsCopyWithImpl(this._self, this._then);

  final _EditableRecordSheetViewModelArgs _self;
  final $Res Function(_EditableRecordSheetViewModelArgs) _then;

  /// Create a copy of EditableRecordSheetViewModelArgs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? initialDraft = null,
    Object? isNew = null,
  }) {
    return _then(_EditableRecordSheetViewModelArgs(
      initialDraft: null == initialDraft
          ? _self.initialDraft
          : initialDraft // ignore: cast_nullable_to_non_nullable
              as RecordDraft,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$EditableRecordSheetState {
  RecordDraft get draft;
  TimeOfDay get timeOfDay;
  String get minutesInput;
  String get amountInput;
  String get noteInput;
  Set<String> get selectedTags;
  ExcretionVolume? get selectedVolume;
  String? get durationError;
  String? get volumeError;

  /// Create a copy of EditableRecordSheetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditableRecordSheetStateCopyWith<EditableRecordSheetState> get copyWith =>
      _$EditableRecordSheetStateCopyWithImpl<EditableRecordSheetState>(
          this as EditableRecordSheetState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditableRecordSheetState &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.minutesInput, minutesInput) ||
                other.minutesInput == minutesInput) &&
            (identical(other.amountInput, amountInput) ||
                other.amountInput == amountInput) &&
            (identical(other.noteInput, noteInput) ||
                other.noteInput == noteInput) &&
            const DeepCollectionEquality()
                .equals(other.selectedTags, selectedTags) &&
            (identical(other.selectedVolume, selectedVolume) ||
                other.selectedVolume == selectedVolume) &&
            (identical(other.durationError, durationError) ||
                other.durationError == durationError) &&
            (identical(other.volumeError, volumeError) ||
                other.volumeError == volumeError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      draft,
      timeOfDay,
      minutesInput,
      amountInput,
      noteInput,
      const DeepCollectionEquality().hash(selectedTags),
      selectedVolume,
      durationError,
      volumeError);

  @override
  String toString() {
    return 'EditableRecordSheetState(draft: $draft, timeOfDay: $timeOfDay, minutesInput: $minutesInput, amountInput: $amountInput, noteInput: $noteInput, selectedTags: $selectedTags, selectedVolume: $selectedVolume, durationError: $durationError, volumeError: $volumeError)';
  }
}

/// @nodoc
abstract mixin class $EditableRecordSheetStateCopyWith<$Res> {
  factory $EditableRecordSheetStateCopyWith(EditableRecordSheetState value,
          $Res Function(EditableRecordSheetState) _then) =
      _$EditableRecordSheetStateCopyWithImpl;
  @useResult
  $Res call(
      {RecordDraft draft,
      TimeOfDay timeOfDay,
      String minutesInput,
      String amountInput,
      String noteInput,
      Set<String> selectedTags,
      ExcretionVolume? selectedVolume,
      String? durationError,
      String? volumeError});
}

/// @nodoc
class _$EditableRecordSheetStateCopyWithImpl<$Res>
    implements $EditableRecordSheetStateCopyWith<$Res> {
  _$EditableRecordSheetStateCopyWithImpl(this._self, this._then);

  final EditableRecordSheetState _self;
  final $Res Function(EditableRecordSheetState) _then;

  /// Create a copy of EditableRecordSheetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? timeOfDay = null,
    Object? minutesInput = null,
    Object? amountInput = null,
    Object? noteInput = null,
    Object? selectedTags = null,
    Object? selectedVolume = freezed,
    Object? durationError = freezed,
    Object? volumeError = freezed,
  }) {
    return _then(_self.copyWith(
      draft: null == draft
          ? _self.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as RecordDraft,
      timeOfDay: null == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      minutesInput: null == minutesInput
          ? _self.minutesInput
          : minutesInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _self.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      noteInput: null == noteInput
          ? _self.noteInput
          : noteInput // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTags: null == selectedTags
          ? _self.selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      selectedVolume: freezed == selectedVolume
          ? _self.selectedVolume
          : selectedVolume // ignore: cast_nullable_to_non_nullable
              as ExcretionVolume?,
      durationError: freezed == durationError
          ? _self.durationError
          : durationError // ignore: cast_nullable_to_non_nullable
              as String?,
      volumeError: freezed == volumeError
          ? _self.volumeError
          : volumeError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EditableRecordSheetState].
extension EditableRecordSheetStatePatterns on EditableRecordSheetState {
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
    TResult Function(_EditableRecordSheetState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetState() when $default != null:
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
    TResult Function(_EditableRecordSheetState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetState():
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
    TResult? Function(_EditableRecordSheetState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetState() when $default != null:
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
            RecordDraft draft,
            TimeOfDay timeOfDay,
            String minutesInput,
            String amountInput,
            String noteInput,
            Set<String> selectedTags,
            ExcretionVolume? selectedVolume,
            String? durationError,
            String? volumeError)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetState() when $default != null:
        return $default(
            _that.draft,
            _that.timeOfDay,
            _that.minutesInput,
            _that.amountInput,
            _that.noteInput,
            _that.selectedTags,
            _that.selectedVolume,
            _that.durationError,
            _that.volumeError);
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
            RecordDraft draft,
            TimeOfDay timeOfDay,
            String minutesInput,
            String amountInput,
            String noteInput,
            Set<String> selectedTags,
            ExcretionVolume? selectedVolume,
            String? durationError,
            String? volumeError)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetState():
        return $default(
            _that.draft,
            _that.timeOfDay,
            _that.minutesInput,
            _that.amountInput,
            _that.noteInput,
            _that.selectedTags,
            _that.selectedVolume,
            _that.durationError,
            _that.volumeError);
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
            RecordDraft draft,
            TimeOfDay timeOfDay,
            String minutesInput,
            String amountInput,
            String noteInput,
            Set<String> selectedTags,
            ExcretionVolume? selectedVolume,
            String? durationError,
            String? volumeError)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditableRecordSheetState() when $default != null:
        return $default(
            _that.draft,
            _that.timeOfDay,
            _that.minutesInput,
            _that.amountInput,
            _that.noteInput,
            _that.selectedTags,
            _that.selectedVolume,
            _that.durationError,
            _that.volumeError);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EditableRecordSheetState extends EditableRecordSheetState {
  const _EditableRecordSheetState(
      {required this.draft,
      required this.timeOfDay,
      required this.minutesInput,
      required this.amountInput,
      required this.noteInput,
      required final Set<String> selectedTags,
      this.selectedVolume,
      this.durationError,
      this.volumeError})
      : _selectedTags = selectedTags,
        super._();

  @override
  final RecordDraft draft;
  @override
  final TimeOfDay timeOfDay;
  @override
  final String minutesInput;
  @override
  final String amountInput;
  @override
  final String noteInput;
  final Set<String> _selectedTags;
  @override
  Set<String> get selectedTags {
    if (_selectedTags is EqualUnmodifiableSetView) return _selectedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedTags);
  }

  @override
  final ExcretionVolume? selectedVolume;
  @override
  final String? durationError;
  @override
  final String? volumeError;

  /// Create a copy of EditableRecordSheetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditableRecordSheetStateCopyWith<_EditableRecordSheetState> get copyWith =>
      __$EditableRecordSheetStateCopyWithImpl<_EditableRecordSheetState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditableRecordSheetState &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.minutesInput, minutesInput) ||
                other.minutesInput == minutesInput) &&
            (identical(other.amountInput, amountInput) ||
                other.amountInput == amountInput) &&
            (identical(other.noteInput, noteInput) ||
                other.noteInput == noteInput) &&
            const DeepCollectionEquality()
                .equals(other._selectedTags, _selectedTags) &&
            (identical(other.selectedVolume, selectedVolume) ||
                other.selectedVolume == selectedVolume) &&
            (identical(other.durationError, durationError) ||
                other.durationError == durationError) &&
            (identical(other.volumeError, volumeError) ||
                other.volumeError == volumeError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      draft,
      timeOfDay,
      minutesInput,
      amountInput,
      noteInput,
      const DeepCollectionEquality().hash(_selectedTags),
      selectedVolume,
      durationError,
      volumeError);

  @override
  String toString() {
    return 'EditableRecordSheetState(draft: $draft, timeOfDay: $timeOfDay, minutesInput: $minutesInput, amountInput: $amountInput, noteInput: $noteInput, selectedTags: $selectedTags, selectedVolume: $selectedVolume, durationError: $durationError, volumeError: $volumeError)';
  }
}

/// @nodoc
abstract mixin class _$EditableRecordSheetStateCopyWith<$Res>
    implements $EditableRecordSheetStateCopyWith<$Res> {
  factory _$EditableRecordSheetStateCopyWith(_EditableRecordSheetState value,
          $Res Function(_EditableRecordSheetState) _then) =
      __$EditableRecordSheetStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {RecordDraft draft,
      TimeOfDay timeOfDay,
      String minutesInput,
      String amountInput,
      String noteInput,
      Set<String> selectedTags,
      ExcretionVolume? selectedVolume,
      String? durationError,
      String? volumeError});
}

/// @nodoc
class __$EditableRecordSheetStateCopyWithImpl<$Res>
    implements _$EditableRecordSheetStateCopyWith<$Res> {
  __$EditableRecordSheetStateCopyWithImpl(this._self, this._then);

  final _EditableRecordSheetState _self;
  final $Res Function(_EditableRecordSheetState) _then;

  /// Create a copy of EditableRecordSheetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? draft = null,
    Object? timeOfDay = null,
    Object? minutesInput = null,
    Object? amountInput = null,
    Object? noteInput = null,
    Object? selectedTags = null,
    Object? selectedVolume = freezed,
    Object? durationError = freezed,
    Object? volumeError = freezed,
  }) {
    return _then(_EditableRecordSheetState(
      draft: null == draft
          ? _self.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as RecordDraft,
      timeOfDay: null == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      minutesInput: null == minutesInput
          ? _self.minutesInput
          : minutesInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _self.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      noteInput: null == noteInput
          ? _self.noteInput
          : noteInput // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTags: null == selectedTags
          ? _self._selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      selectedVolume: freezed == selectedVolume
          ? _self.selectedVolume
          : selectedVolume // ignore: cast_nullable_to_non_nullable
              as ExcretionVolume?,
      durationError: freezed == durationError
          ? _self.durationError
          : durationError // ignore: cast_nullable_to_non_nullable
              as String?,
      volumeError: freezed == volumeError
          ? _self.volumeError
          : volumeError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
