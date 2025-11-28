// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_record_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ChildRecordRepository の Provider（householdId ごと）

@ProviderFor(childRecordRepository)
const childRecordRepositoryProvider = ChildRecordRepositoryFamily._();

/// ChildRecordRepository の Provider（householdId ごと）

final class ChildRecordRepositoryProvider extends $FunctionalProvider<
    ChildRecordRepository,
    ChildRecordRepository,
    ChildRecordRepository> with $Provider<ChildRecordRepository> {
  /// ChildRecordRepository の Provider（householdId ごと）
  const ChildRecordRepositoryProvider._(
      {required ChildRecordRepositoryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'childRecordRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childRecordRepositoryHash();

  @override
  String toString() {
    return r'childRecordRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ChildRecordRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChildRecordRepository create(Ref ref) {
    final argument = this.argument as String;
    return childRecordRepository(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChildRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChildRecordRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChildRecordRepositoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childRecordRepositoryHash() =>
    r'd9784b9c04a29ce20dcb30724d6fdd814a9717cf';

/// ChildRecordRepository の Provider（householdId ごと）

final class ChildRecordRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<ChildRecordRepository, String> {
  const ChildRecordRepositoryFamily._()
      : super(
          retry: null,
          name: r'childRecordRepositoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// ChildRecordRepository の Provider（householdId ごと）

  ChildRecordRepositoryProvider call(
    String householdId,
  ) =>
      ChildRecordRepositoryProvider._(argument: householdId, from: this);

  @override
  String toString() => r'childRecordRepositoryProvider';
}

/// AddRecord UseCase の Provider（householdId ごと）

@ProviderFor(addRecordUseCase)
const addRecordUseCaseProvider = AddRecordUseCaseFamily._();

/// AddRecord UseCase の Provider（householdId ごと）

final class AddRecordUseCaseProvider
    extends $FunctionalProvider<AddRecord, AddRecord, AddRecord>
    with $Provider<AddRecord> {
  /// AddRecord UseCase の Provider（householdId ごと）
  const AddRecordUseCaseProvider._(
      {required AddRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'addRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$addRecordUseCaseHash();

  @override
  String toString() {
    return r'addRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AddRecord> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddRecord create(Ref ref) {
    final argument = this.argument as String;
    return addRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AddRecordUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addRecordUseCaseHash() => r'e0e35b5389fcf927af78123f11901ff104287a36';

/// AddRecord UseCase の Provider（householdId ごと）

final class AddRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<AddRecord, String> {
  const AddRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'addRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// AddRecord UseCase の Provider（householdId ごと）

  AddRecordUseCaseProvider call(
    String householdId,
  ) =>
      AddRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'addRecordUseCaseProvider';
}

/// DeleteRecord UseCase の Provider（householdId ごと）

@ProviderFor(deleteRecordUseCase)
const deleteRecordUseCaseProvider = DeleteRecordUseCaseFamily._();

/// DeleteRecord UseCase の Provider（householdId ごと）

final class DeleteRecordUseCaseProvider
    extends $FunctionalProvider<DeleteRecord, DeleteRecord, DeleteRecord>
    with $Provider<DeleteRecord> {
  /// DeleteRecord UseCase の Provider（householdId ごと）
  const DeleteRecordUseCaseProvider._(
      {required DeleteRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'deleteRecordUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deleteRecordUseCaseHash();

  @override
  String toString() {
    return r'deleteRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DeleteRecord> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteRecord create(Ref ref) {
    final argument = this.argument as String;
    return deleteRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteRecordUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteRecordUseCaseHash() =>
    r'f3fc12103f7a8d0d22493b110174e6500593c818';

/// DeleteRecord UseCase の Provider（householdId ごと）

final class DeleteRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<DeleteRecord, String> {
  const DeleteRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'deleteRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// DeleteRecord UseCase の Provider（householdId ごと）

  DeleteRecordUseCaseProvider call(
    String householdId,
  ) =>
      DeleteRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'deleteRecordUseCaseProvider';
}
