// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(acceptInvitationUseCase)
const acceptInvitationUseCaseProvider = AcceptInvitationUseCaseProvider._();

final class AcceptInvitationUseCaseProvider extends $FunctionalProvider<
    AcceptInvitation,
    AcceptInvitation,
    AcceptInvitation> with $Provider<AcceptInvitation> {
  const AcceptInvitationUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'acceptInvitationUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$acceptInvitationUseCaseHash();

  @$internal
  @override
  $ProviderElement<AcceptInvitation> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AcceptInvitation create(Ref ref) {
    return acceptInvitationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcceptInvitation value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcceptInvitation>(value),
    );
  }
}

String _$acceptInvitationUseCaseHash() =>
    r'5cf33af5f0cfac722c81a737c8ec7d3fa4fd13a7';

@ProviderFor(removeMemberUseCase)
const removeMemberUseCaseProvider = RemoveMemberUseCaseProvider._();

final class RemoveMemberUseCaseProvider
    extends $FunctionalProvider<RemoveMember, RemoveMember, RemoveMember>
    with $Provider<RemoveMember> {
  const RemoveMemberUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'removeMemberUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$removeMemberUseCaseHash();

  @$internal
  @override
  $ProviderElement<RemoveMember> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoveMember create(Ref ref) {
    return removeMemberUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoveMember value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoveMember>(value),
    );
  }
}

String _$removeMemberUseCaseHash() =>
    r'17bc79ba58dacb04b049d85b28ac2c0ac459ce7c';

@ProviderFor(householdMembersDataSource)
const householdMembersDataSourceProvider =
    HouseholdMembersDataSourceProvider._();

final class HouseholdMembersDataSourceProvider extends $FunctionalProvider<
        HouseholdMembersFirestoreDataSource,
        HouseholdMembersFirestoreDataSource,
        HouseholdMembersFirestoreDataSource>
    with $Provider<HouseholdMembersFirestoreDataSource> {
  const HouseholdMembersDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'householdMembersDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$householdMembersDataSourceHash();

  @$internal
  @override
  $ProviderElement<HouseholdMembersFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HouseholdMembersFirestoreDataSource create(Ref ref) {
    return householdMembersDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HouseholdMembersFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<HouseholdMembersFirestoreDataSource>(value),
    );
  }
}

String _$householdMembersDataSourceHash() =>
    r'424e9d7fb2241ae1d528d1855444ec263920bcd6';

@ProviderFor(householdMembers)
const householdMembersProvider = HouseholdMembersFamily._();

final class HouseholdMembersProvider extends $FunctionalProvider<
        AsyncValue<List<HouseholdMember>>,
        List<HouseholdMember>,
        Stream<List<HouseholdMember>>>
    with
        $FutureModifier<List<HouseholdMember>>,
        $StreamProvider<List<HouseholdMember>> {
  const HouseholdMembersProvider._(
      {required HouseholdMembersFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'householdMembersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$householdMembersHash();

  @override
  String toString() {
    return r'householdMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<HouseholdMember>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<HouseholdMember>> create(Ref ref) {
    final argument = this.argument as String;
    return householdMembers(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HouseholdMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$householdMembersHash() => r'12329a9af9dac4f883a0e3c98a766bf07660eb40';

final class HouseholdMembersFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<HouseholdMember>>, String> {
  const HouseholdMembersFamily._()
      : super(
          retry: null,
          name: r'householdMembersProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  HouseholdMembersProvider call(
    String householdId,
  ) =>
      HouseholdMembersProvider._(argument: householdId, from: this);

  @override
  String toString() => r'householdMembersProvider';
}
