// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_child_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted selected child id

@ProviderFor(SelectedChildController)
const selectedChildControllerProvider = SelectedChildControllerProvider._();

/// Persisted selected child id
final class SelectedChildControllerProvider
    extends $AsyncNotifierProvider<SelectedChildController, String?> {
  /// Persisted selected child id
  const SelectedChildControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedChildControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedChildControllerHash();

  @$internal
  @override
  SelectedChildController create() => SelectedChildController();
}

String _$selectedChildControllerHash() =>
    r'f9a67a486973a29558c6d6a5fefadb0b740d9a22';

/// Persisted selected child id

abstract class _$SelectedChildController extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<String?>, String?>,
        AsyncValue<String?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
