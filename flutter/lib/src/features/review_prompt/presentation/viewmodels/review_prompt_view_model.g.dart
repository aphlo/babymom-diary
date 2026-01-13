// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_prompt_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// レビュープロンプトのグローバルViewModel
///
/// 各featureの記録操作後に呼び出し、条件を満たす場合はダイアログ表示フラグをONにする。
/// UIレイヤー（App等）でこの状態を監視し、ダイアログを表示する。

@ProviderFor(ReviewPromptViewModel)
const reviewPromptViewModelProvider = ReviewPromptViewModelProvider._();

/// レビュープロンプトのグローバルViewModel
///
/// 各featureの記録操作後に呼び出し、条件を満たす場合はダイアログ表示フラグをONにする。
/// UIレイヤー（App等）でこの状態を監視し、ダイアログを表示する。
final class ReviewPromptViewModelProvider
    extends $NotifierProvider<ReviewPromptViewModel, ReviewPromptViewState> {
  /// レビュープロンプトのグローバルViewModel
  ///
  /// 各featureの記録操作後に呼び出し、条件を満たす場合はダイアログ表示フラグをONにする。
  /// UIレイヤー（App等）でこの状態を監視し、ダイアログを表示する。
  const ReviewPromptViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'reviewPromptViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$reviewPromptViewModelHash();

  @$internal
  @override
  ReviewPromptViewModel create() => ReviewPromptViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewPromptViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewPromptViewState>(value),
    );
  }
}

String _$reviewPromptViewModelHash() =>
    r'82256ccc2c838e3431e25db3ed0ce777074a7739';

/// レビュープロンプトのグローバルViewModel
///
/// 各featureの記録操作後に呼び出し、条件を満たす場合はダイアログ表示フラグをONにする。
/// UIレイヤー（App等）でこの状態を監視し、ダイアログを表示する。

abstract class _$ReviewPromptViewModel
    extends $Notifier<ReviewPromptViewState> {
  ReviewPromptViewState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReviewPromptViewState, ReviewPromptViewState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ReviewPromptViewState, ReviewPromptViewState>,
        ReviewPromptViewState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
