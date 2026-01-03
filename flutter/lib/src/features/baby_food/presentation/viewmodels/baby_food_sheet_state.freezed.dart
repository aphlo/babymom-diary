// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby_food_sheet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BabyFoodSheetState {
  /// 現在のステップ（0: 食材選択, 1: 量入力）
  int get currentStep;

  /// 記録時刻
  TimeOfDay get timeOfDay;

  /// 選択中の食材リスト
  List<BabyFoodItemDraft> get selectedItems;

  /// 展開中のカテゴリ（null: 全て閉じている）
  FoodCategory? get expandedCategory;

  /// カスタム食材リスト
  List<CustomIngredient> get customIngredients;

  /// 非表示食材のIDセット
  Set<String> get hiddenIngredients;

  /// メモ
  String? get note;

  /// 処理中かどうか
  bool get isProcessing;

  /// エラーメッセージ
  String? get errorMessage;

  /// 新規作成かどうか
  bool get isNew;

  /// 既存レコードのID（編集時のみ）
  String? get existingId;

  /// 食材選択ステップをスキップしたかどうか
  bool get skippedIngredientSelection;

  /// Create a copy of BabyFoodSheetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BabyFoodSheetStateCopyWith<BabyFoodSheetState> get copyWith =>
      _$BabyFoodSheetStateCopyWithImpl<BabyFoodSheetState>(
          this as BabyFoodSheetState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BabyFoodSheetState &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            const DeepCollectionEquality()
                .equals(other.selectedItems, selectedItems) &&
            (identical(other.expandedCategory, expandedCategory) ||
                other.expandedCategory == expandedCategory) &&
            const DeepCollectionEquality()
                .equals(other.customIngredients, customIngredients) &&
            const DeepCollectionEquality()
                .equals(other.hiddenIngredients, hiddenIngredients) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.existingId, existingId) ||
                other.existingId == existingId) &&
            (identical(other.skippedIngredientSelection,
                    skippedIngredientSelection) ||
                other.skippedIngredientSelection ==
                    skippedIngredientSelection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStep,
      timeOfDay,
      const DeepCollectionEquality().hash(selectedItems),
      expandedCategory,
      const DeepCollectionEquality().hash(customIngredients),
      const DeepCollectionEquality().hash(hiddenIngredients),
      note,
      isProcessing,
      errorMessage,
      isNew,
      existingId,
      skippedIngredientSelection);

  @override
  String toString() {
    return 'BabyFoodSheetState(currentStep: $currentStep, timeOfDay: $timeOfDay, selectedItems: $selectedItems, expandedCategory: $expandedCategory, customIngredients: $customIngredients, hiddenIngredients: $hiddenIngredients, note: $note, isProcessing: $isProcessing, errorMessage: $errorMessage, isNew: $isNew, existingId: $existingId, skippedIngredientSelection: $skippedIngredientSelection)';
  }
}

/// @nodoc
abstract mixin class $BabyFoodSheetStateCopyWith<$Res> {
  factory $BabyFoodSheetStateCopyWith(
          BabyFoodSheetState value, $Res Function(BabyFoodSheetState) _then) =
      _$BabyFoodSheetStateCopyWithImpl;
  @useResult
  $Res call(
      {int currentStep,
      TimeOfDay timeOfDay,
      List<BabyFoodItemDraft> selectedItems,
      FoodCategory? expandedCategory,
      List<CustomIngredient> customIngredients,
      Set<String> hiddenIngredients,
      String? note,
      bool isProcessing,
      String? errorMessage,
      bool isNew,
      String? existingId,
      bool skippedIngredientSelection});
}

/// @nodoc
class _$BabyFoodSheetStateCopyWithImpl<$Res>
    implements $BabyFoodSheetStateCopyWith<$Res> {
  _$BabyFoodSheetStateCopyWithImpl(this._self, this._then);

  final BabyFoodSheetState _self;
  final $Res Function(BabyFoodSheetState) _then;

  /// Create a copy of BabyFoodSheetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? timeOfDay = null,
    Object? selectedItems = null,
    Object? expandedCategory = freezed,
    Object? customIngredients = null,
    Object? hiddenIngredients = null,
    Object? note = freezed,
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? isNew = null,
    Object? existingId = freezed,
    Object? skippedIngredientSelection = null,
  }) {
    return _then(_self.copyWith(
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      timeOfDay: null == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      selectedItems: null == selectedItems
          ? _self.selectedItems
          : selectedItems // ignore: cast_nullable_to_non_nullable
              as List<BabyFoodItemDraft>,
      expandedCategory: freezed == expandedCategory
          ? _self.expandedCategory
          : expandedCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
      customIngredients: null == customIngredients
          ? _self.customIngredients
          : customIngredients // ignore: cast_nullable_to_non_nullable
              as List<CustomIngredient>,
      hiddenIngredients: null == hiddenIngredients
          ? _self.hiddenIngredients
          : hiddenIngredients // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      existingId: freezed == existingId
          ? _self.existingId
          : existingId // ignore: cast_nullable_to_non_nullable
              as String?,
      skippedIngredientSelection: null == skippedIngredientSelection
          ? _self.skippedIngredientSelection
          : skippedIngredientSelection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [BabyFoodSheetState].
extension BabyFoodSheetStatePatterns on BabyFoodSheetState {
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
    TResult Function(_BabyFoodSheetState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodSheetState() when $default != null:
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
    TResult Function(_BabyFoodSheetState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodSheetState():
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
    TResult? Function(_BabyFoodSheetState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodSheetState() when $default != null:
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
            int currentStep,
            TimeOfDay timeOfDay,
            List<BabyFoodItemDraft> selectedItems,
            FoodCategory? expandedCategory,
            List<CustomIngredient> customIngredients,
            Set<String> hiddenIngredients,
            String? note,
            bool isProcessing,
            String? errorMessage,
            bool isNew,
            String? existingId,
            bool skippedIngredientSelection)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BabyFoodSheetState() when $default != null:
        return $default(
            _that.currentStep,
            _that.timeOfDay,
            _that.selectedItems,
            _that.expandedCategory,
            _that.customIngredients,
            _that.hiddenIngredients,
            _that.note,
            _that.isProcessing,
            _that.errorMessage,
            _that.isNew,
            _that.existingId,
            _that.skippedIngredientSelection);
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
            int currentStep,
            TimeOfDay timeOfDay,
            List<BabyFoodItemDraft> selectedItems,
            FoodCategory? expandedCategory,
            List<CustomIngredient> customIngredients,
            Set<String> hiddenIngredients,
            String? note,
            bool isProcessing,
            String? errorMessage,
            bool isNew,
            String? existingId,
            bool skippedIngredientSelection)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodSheetState():
        return $default(
            _that.currentStep,
            _that.timeOfDay,
            _that.selectedItems,
            _that.expandedCategory,
            _that.customIngredients,
            _that.hiddenIngredients,
            _that.note,
            _that.isProcessing,
            _that.errorMessage,
            _that.isNew,
            _that.existingId,
            _that.skippedIngredientSelection);
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
            int currentStep,
            TimeOfDay timeOfDay,
            List<BabyFoodItemDraft> selectedItems,
            FoodCategory? expandedCategory,
            List<CustomIngredient> customIngredients,
            Set<String> hiddenIngredients,
            String? note,
            bool isProcessing,
            String? errorMessage,
            bool isNew,
            String? existingId,
            bool skippedIngredientSelection)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BabyFoodSheetState() when $default != null:
        return $default(
            _that.currentStep,
            _that.timeOfDay,
            _that.selectedItems,
            _that.expandedCategory,
            _that.customIngredients,
            _that.hiddenIngredients,
            _that.note,
            _that.isProcessing,
            _that.errorMessage,
            _that.isNew,
            _that.existingId,
            _that.skippedIngredientSelection);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BabyFoodSheetState extends BabyFoodSheetState {
  const _BabyFoodSheetState(
      {required this.currentStep,
      required this.timeOfDay,
      required final List<BabyFoodItemDraft> selectedItems,
      this.expandedCategory,
      required final List<CustomIngredient> customIngredients,
      required final Set<String> hiddenIngredients,
      this.note,
      this.isProcessing = false,
      this.errorMessage,
      required this.isNew,
      this.existingId,
      this.skippedIngredientSelection = false})
      : _selectedItems = selectedItems,
        _customIngredients = customIngredients,
        _hiddenIngredients = hiddenIngredients,
        super._();

  /// 現在のステップ（0: 食材選択, 1: 量入力）
  @override
  final int currentStep;

  /// 記録時刻
  @override
  final TimeOfDay timeOfDay;

  /// 選択中の食材リスト
  final List<BabyFoodItemDraft> _selectedItems;

  /// 選択中の食材リスト
  @override
  List<BabyFoodItemDraft> get selectedItems {
    if (_selectedItems is EqualUnmodifiableListView) return _selectedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedItems);
  }

  /// 展開中のカテゴリ（null: 全て閉じている）
  @override
  final FoodCategory? expandedCategory;

  /// カスタム食材リスト
  final List<CustomIngredient> _customIngredients;

  /// カスタム食材リスト
  @override
  List<CustomIngredient> get customIngredients {
    if (_customIngredients is EqualUnmodifiableListView)
      return _customIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customIngredients);
  }

  /// 非表示食材のIDセット
  final Set<String> _hiddenIngredients;

  /// 非表示食材のIDセット
  @override
  Set<String> get hiddenIngredients {
    if (_hiddenIngredients is EqualUnmodifiableSetView)
      return _hiddenIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_hiddenIngredients);
  }

  /// メモ
  @override
  final String? note;

  /// 処理中かどうか
  @override
  @JsonKey()
  final bool isProcessing;

  /// エラーメッセージ
  @override
  final String? errorMessage;

  /// 新規作成かどうか
  @override
  final bool isNew;

  /// 既存レコードのID（編集時のみ）
  @override
  final String? existingId;

  /// 食材選択ステップをスキップしたかどうか
  @override
  @JsonKey()
  final bool skippedIngredientSelection;

  /// Create a copy of BabyFoodSheetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BabyFoodSheetStateCopyWith<_BabyFoodSheetState> get copyWith =>
      __$BabyFoodSheetStateCopyWithImpl<_BabyFoodSheetState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BabyFoodSheetState &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            const DeepCollectionEquality()
                .equals(other._selectedItems, _selectedItems) &&
            (identical(other.expandedCategory, expandedCategory) ||
                other.expandedCategory == expandedCategory) &&
            const DeepCollectionEquality()
                .equals(other._customIngredients, _customIngredients) &&
            const DeepCollectionEquality()
                .equals(other._hiddenIngredients, _hiddenIngredients) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.existingId, existingId) ||
                other.existingId == existingId) &&
            (identical(other.skippedIngredientSelection,
                    skippedIngredientSelection) ||
                other.skippedIngredientSelection ==
                    skippedIngredientSelection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStep,
      timeOfDay,
      const DeepCollectionEquality().hash(_selectedItems),
      expandedCategory,
      const DeepCollectionEquality().hash(_customIngredients),
      const DeepCollectionEquality().hash(_hiddenIngredients),
      note,
      isProcessing,
      errorMessage,
      isNew,
      existingId,
      skippedIngredientSelection);

  @override
  String toString() {
    return 'BabyFoodSheetState(currentStep: $currentStep, timeOfDay: $timeOfDay, selectedItems: $selectedItems, expandedCategory: $expandedCategory, customIngredients: $customIngredients, hiddenIngredients: $hiddenIngredients, note: $note, isProcessing: $isProcessing, errorMessage: $errorMessage, isNew: $isNew, existingId: $existingId, skippedIngredientSelection: $skippedIngredientSelection)';
  }
}

/// @nodoc
abstract mixin class _$BabyFoodSheetStateCopyWith<$Res>
    implements $BabyFoodSheetStateCopyWith<$Res> {
  factory _$BabyFoodSheetStateCopyWith(
          _BabyFoodSheetState value, $Res Function(_BabyFoodSheetState) _then) =
      __$BabyFoodSheetStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int currentStep,
      TimeOfDay timeOfDay,
      List<BabyFoodItemDraft> selectedItems,
      FoodCategory? expandedCategory,
      List<CustomIngredient> customIngredients,
      Set<String> hiddenIngredients,
      String? note,
      bool isProcessing,
      String? errorMessage,
      bool isNew,
      String? existingId,
      bool skippedIngredientSelection});
}

/// @nodoc
class __$BabyFoodSheetStateCopyWithImpl<$Res>
    implements _$BabyFoodSheetStateCopyWith<$Res> {
  __$BabyFoodSheetStateCopyWithImpl(this._self, this._then);

  final _BabyFoodSheetState _self;
  final $Res Function(_BabyFoodSheetState) _then;

  /// Create a copy of BabyFoodSheetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentStep = null,
    Object? timeOfDay = null,
    Object? selectedItems = null,
    Object? expandedCategory = freezed,
    Object? customIngredients = null,
    Object? hiddenIngredients = null,
    Object? note = freezed,
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? isNew = null,
    Object? existingId = freezed,
    Object? skippedIngredientSelection = null,
  }) {
    return _then(_BabyFoodSheetState(
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      timeOfDay: null == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      selectedItems: null == selectedItems
          ? _self._selectedItems
          : selectedItems // ignore: cast_nullable_to_non_nullable
              as List<BabyFoodItemDraft>,
      expandedCategory: freezed == expandedCategory
          ? _self.expandedCategory
          : expandedCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
      customIngredients: null == customIngredients
          ? _self._customIngredients
          : customIngredients // ignore: cast_nullable_to_non_nullable
              as List<CustomIngredient>,
      hiddenIngredients: null == hiddenIngredients
          ? _self._hiddenIngredients
          : hiddenIngredients // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isProcessing: null == isProcessing
          ? _self.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      existingId: freezed == existingId
          ? _self.existingId
          : existingId // ignore: cast_nullable_to_non_nullable
              as String?,
      skippedIngredientSelection: null == skippedIngredientSelection
          ? _self.skippedIngredientSelection
          : skippedIngredientSelection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
