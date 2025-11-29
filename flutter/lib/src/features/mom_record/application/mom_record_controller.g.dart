// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mom_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(momRecordFirestoreDataSource)
const momRecordFirestoreDataSourceProvider =
    MomRecordFirestoreDataSourceFamily._();

final class MomRecordFirestoreDataSourceProvider extends $FunctionalProvider<
    MomRecordFirestoreDataSource,
    MomRecordFirestoreDataSource,
    MomRecordFirestoreDataSource> with $Provider<MomRecordFirestoreDataSource> {
  const MomRecordFirestoreDataSourceProvider._(
      {required MomRecordFirestoreDataSourceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'momRecordFirestoreDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$momRecordFirestoreDataSourceHash();

  @override
  String toString() {
    return r'momRecordFirestoreDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<MomRecordFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MomRecordFirestoreDataSource create(Ref ref) {
    final argument = this.argument as String;
    return momRecordFirestoreDataSource(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MomRecordFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MomRecordFirestoreDataSource>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MomRecordFirestoreDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$momRecordFirestoreDataSourceHash() =>
    r'cef95d247edbb3e28c9de17fcaa27f161bf98511';

final class MomRecordFirestoreDataSourceFamily extends $Family
    with $FunctionalFamilyOverride<MomRecordFirestoreDataSource, String> {
  const MomRecordFirestoreDataSourceFamily._()
      : super(
          retry: null,
          name: r'momRecordFirestoreDataSourceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  MomRecordFirestoreDataSourceProvider call(
    String householdId,
  ) =>
      MomRecordFirestoreDataSourceProvider._(argument: householdId, from: this);

  @override
  String toString() => r'momRecordFirestoreDataSourceProvider';
}

@ProviderFor(momRecordRepository)
const momRecordRepositoryProvider = MomRecordRepositoryFamily._();

final class MomRecordRepositoryProvider extends $FunctionalProvider<
    MomRecordRepository,
    MomRecordRepository,
    MomRecordRepository> with $Provider<MomRecordRepository> {
  const MomRecordRepositoryProvider._(
      {required MomRecordRepositoryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'momRecordRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$momRecordRepositoryHash();

  @override
  String toString() {
    return r'momRecordRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<MomRecordRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MomRecordRepository create(Ref ref) {
    final argument = this.argument as String;
    return momRecordRepository(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MomRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MomRecordRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MomRecordRepositoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$momRecordRepositoryHash() =>
    r'991b2c01faa622904962ca1e180cea9356053f79';

final class MomRecordRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<MomRecordRepository, String> {
  const MomRecordRepositoryFamily._()
      : super(
          retry: null,
          name: r'momRecordRepositoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  MomRecordRepositoryProvider call(
    String householdId,
  ) =>
      MomRecordRepositoryProvider._(argument: householdId, from: this);

  @override
  String toString() => r'momRecordRepositoryProvider';
}

@ProviderFor(getMomMonthlyRecordsUseCase)
const getMomMonthlyRecordsUseCaseProvider =
    GetMomMonthlyRecordsUseCaseFamily._();

final class GetMomMonthlyRecordsUseCaseProvider extends $FunctionalProvider<
    GetMomMonthlyRecords,
    GetMomMonthlyRecords,
    GetMomMonthlyRecords> with $Provider<GetMomMonthlyRecords> {
  const GetMomMonthlyRecordsUseCaseProvider._(
      {required GetMomMonthlyRecordsUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'getMomMonthlyRecordsUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getMomMonthlyRecordsUseCaseHash();

  @override
  String toString() {
    return r'getMomMonthlyRecordsUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GetMomMonthlyRecords> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetMomMonthlyRecords create(Ref ref) {
    final argument = this.argument as String;
    return getMomMonthlyRecordsUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMomMonthlyRecords value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMomMonthlyRecords>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetMomMonthlyRecordsUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getMomMonthlyRecordsUseCaseHash() =>
    r'81e2cf6c700d461565b947bf88b3e79ad807145e';

final class GetMomMonthlyRecordsUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<GetMomMonthlyRecords, String> {
  const GetMomMonthlyRecordsUseCaseFamily._()
      : super(
          retry: null,
          name: r'getMomMonthlyRecordsUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  GetMomMonthlyRecordsUseCaseProvider call(
    String householdId,
  ) =>
      GetMomMonthlyRecordsUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'getMomMonthlyRecordsUseCaseProvider';
}

@ProviderFor(watchMomRecordForDateUseCase)
const watchMomRecordForDateUseCaseProvider =
    WatchMomRecordForDateUseCaseFamily._();

final class WatchMomRecordForDateUseCaseProvider extends $FunctionalProvider<
    WatchMomRecordForDate,
    WatchMomRecordForDate,
    WatchMomRecordForDate> with $Provider<WatchMomRecordForDate> {
  const WatchMomRecordForDateUseCaseProvider._(
      {required WatchMomRecordForDateUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'watchMomRecordForDateUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$watchMomRecordForDateUseCaseHash();

  @override
  String toString() {
    return r'watchMomRecordForDateUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WatchMomRecordForDate> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchMomRecordForDate create(Ref ref) {
    final argument = this.argument as String;
    return watchMomRecordForDateUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchMomRecordForDate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchMomRecordForDate>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WatchMomRecordForDateUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchMomRecordForDateUseCaseHash() =>
    r'f6d97f9fd53c1c45732d9e31af4d122bf276c8e4';

final class WatchMomRecordForDateUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<WatchMomRecordForDate, String> {
  const WatchMomRecordForDateUseCaseFamily._()
      : super(
          retry: null,
          name: r'watchMomRecordForDateUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  WatchMomRecordForDateUseCaseProvider call(
    String householdId,
  ) =>
      WatchMomRecordForDateUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'watchMomRecordForDateUseCaseProvider';
}

@ProviderFor(saveMomDailyRecordUseCase)
const saveMomDailyRecordUseCaseProvider = SaveMomDailyRecordUseCaseFamily._();

final class SaveMomDailyRecordUseCaseProvider extends $FunctionalProvider<
    SaveMomDailyRecord,
    SaveMomDailyRecord,
    SaveMomDailyRecord> with $Provider<SaveMomDailyRecord> {
  const SaveMomDailyRecordUseCaseProvider._(
      {required SaveMomDailyRecordUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'saveMomDailyRecordUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$saveMomDailyRecordUseCaseHash();

  @override
  String toString() {
    return r'saveMomDailyRecordUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<SaveMomDailyRecord> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveMomDailyRecord create(Ref ref) {
    final argument = this.argument as String;
    return saveMomDailyRecordUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveMomDailyRecord value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveMomDailyRecord>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SaveMomDailyRecordUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$saveMomDailyRecordUseCaseHash() =>
    r'c7824cde7c409fb1721837e42fe58742c72e1e80';

final class SaveMomDailyRecordUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<SaveMomDailyRecord, String> {
  const SaveMomDailyRecordUseCaseFamily._()
      : super(
          retry: null,
          name: r'saveMomDailyRecordUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  SaveMomDailyRecordUseCaseProvider call(
    String householdId,
  ) =>
      SaveMomDailyRecordUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'saveMomDailyRecordUseCaseProvider';
}

@ProviderFor(momDiaryFirestoreDataSource)
const momDiaryFirestoreDataSourceProvider =
    MomDiaryFirestoreDataSourceFamily._();

final class MomDiaryFirestoreDataSourceProvider extends $FunctionalProvider<
    MomDiaryFirestoreDataSource,
    MomDiaryFirestoreDataSource,
    MomDiaryFirestoreDataSource> with $Provider<MomDiaryFirestoreDataSource> {
  const MomDiaryFirestoreDataSourceProvider._(
      {required MomDiaryFirestoreDataSourceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'momDiaryFirestoreDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$momDiaryFirestoreDataSourceHash();

  @override
  String toString() {
    return r'momDiaryFirestoreDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<MomDiaryFirestoreDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MomDiaryFirestoreDataSource create(Ref ref) {
    final argument = this.argument as String;
    return momDiaryFirestoreDataSource(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MomDiaryFirestoreDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MomDiaryFirestoreDataSource>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MomDiaryFirestoreDataSourceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$momDiaryFirestoreDataSourceHash() =>
    r'7c800edb8aa47767c95b402ef18026404ad7916c';

final class MomDiaryFirestoreDataSourceFamily extends $Family
    with $FunctionalFamilyOverride<MomDiaryFirestoreDataSource, String> {
  const MomDiaryFirestoreDataSourceFamily._()
      : super(
          retry: null,
          name: r'momDiaryFirestoreDataSourceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  MomDiaryFirestoreDataSourceProvider call(
    String householdId,
  ) =>
      MomDiaryFirestoreDataSourceProvider._(argument: householdId, from: this);

  @override
  String toString() => r'momDiaryFirestoreDataSourceProvider';
}

@ProviderFor(momDiaryRepository)
const momDiaryRepositoryProvider = MomDiaryRepositoryFamily._();

final class MomDiaryRepositoryProvider extends $FunctionalProvider<
    MomDiaryRepository,
    MomDiaryRepository,
    MomDiaryRepository> with $Provider<MomDiaryRepository> {
  const MomDiaryRepositoryProvider._(
      {required MomDiaryRepositoryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'momDiaryRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$momDiaryRepositoryHash();

  @override
  String toString() {
    return r'momDiaryRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<MomDiaryRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MomDiaryRepository create(Ref ref) {
    final argument = this.argument as String;
    return momDiaryRepository(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MomDiaryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MomDiaryRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MomDiaryRepositoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$momDiaryRepositoryHash() =>
    r'e957c778d06f869204197f97bffc02ead1e0dd66';

final class MomDiaryRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<MomDiaryRepository, String> {
  const MomDiaryRepositoryFamily._()
      : super(
          retry: null,
          name: r'momDiaryRepositoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  MomDiaryRepositoryProvider call(
    String householdId,
  ) =>
      MomDiaryRepositoryProvider._(argument: householdId, from: this);

  @override
  String toString() => r'momDiaryRepositoryProvider';
}

@ProviderFor(getMomDiaryMonthlyEntriesUseCase)
const getMomDiaryMonthlyEntriesUseCaseProvider =
    GetMomDiaryMonthlyEntriesUseCaseFamily._();

final class GetMomDiaryMonthlyEntriesUseCaseProvider
    extends $FunctionalProvider<
        GetMomDiaryMonthlyEntries,
        GetMomDiaryMonthlyEntries,
        GetMomDiaryMonthlyEntries> with $Provider<GetMomDiaryMonthlyEntries> {
  const GetMomDiaryMonthlyEntriesUseCaseProvider._(
      {required GetMomDiaryMonthlyEntriesUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'getMomDiaryMonthlyEntriesUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getMomDiaryMonthlyEntriesUseCaseHash();

  @override
  String toString() {
    return r'getMomDiaryMonthlyEntriesUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GetMomDiaryMonthlyEntries> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetMomDiaryMonthlyEntries create(Ref ref) {
    final argument = this.argument as String;
    return getMomDiaryMonthlyEntriesUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMomDiaryMonthlyEntries value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMomDiaryMonthlyEntries>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetMomDiaryMonthlyEntriesUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getMomDiaryMonthlyEntriesUseCaseHash() =>
    r'b72884a4560a47743d538567dc2915177d18a114';

final class GetMomDiaryMonthlyEntriesUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<GetMomDiaryMonthlyEntries, String> {
  const GetMomDiaryMonthlyEntriesUseCaseFamily._()
      : super(
          retry: null,
          name: r'getMomDiaryMonthlyEntriesUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  GetMomDiaryMonthlyEntriesUseCaseProvider call(
    String householdId,
  ) =>
      GetMomDiaryMonthlyEntriesUseCaseProvider._(
          argument: householdId, from: this);

  @override
  String toString() => r'getMomDiaryMonthlyEntriesUseCaseProvider';
}

@ProviderFor(watchMomDiaryForDateUseCase)
const watchMomDiaryForDateUseCaseProvider =
    WatchMomDiaryForDateUseCaseFamily._();

final class WatchMomDiaryForDateUseCaseProvider extends $FunctionalProvider<
    WatchMomDiaryForDate,
    WatchMomDiaryForDate,
    WatchMomDiaryForDate> with $Provider<WatchMomDiaryForDate> {
  const WatchMomDiaryForDateUseCaseProvider._(
      {required WatchMomDiaryForDateUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'watchMomDiaryForDateUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$watchMomDiaryForDateUseCaseHash();

  @override
  String toString() {
    return r'watchMomDiaryForDateUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WatchMomDiaryForDate> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchMomDiaryForDate create(Ref ref) {
    final argument = this.argument as String;
    return watchMomDiaryForDateUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchMomDiaryForDate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchMomDiaryForDate>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WatchMomDiaryForDateUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchMomDiaryForDateUseCaseHash() =>
    r'5bd899c82fecb6af7e10f36bcf0a1bedb381d3de';

final class WatchMomDiaryForDateUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<WatchMomDiaryForDate, String> {
  const WatchMomDiaryForDateUseCaseFamily._()
      : super(
          retry: null,
          name: r'watchMomDiaryForDateUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  WatchMomDiaryForDateUseCaseProvider call(
    String householdId,
  ) =>
      WatchMomDiaryForDateUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'watchMomDiaryForDateUseCaseProvider';
}

@ProviderFor(saveMomDiaryEntryUseCase)
const saveMomDiaryEntryUseCaseProvider = SaveMomDiaryEntryUseCaseFamily._();

final class SaveMomDiaryEntryUseCaseProvider extends $FunctionalProvider<
    SaveMomDiaryEntry,
    SaveMomDiaryEntry,
    SaveMomDiaryEntry> with $Provider<SaveMomDiaryEntry> {
  const SaveMomDiaryEntryUseCaseProvider._(
      {required SaveMomDiaryEntryUseCaseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'saveMomDiaryEntryUseCaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$saveMomDiaryEntryUseCaseHash();

  @override
  String toString() {
    return r'saveMomDiaryEntryUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<SaveMomDiaryEntry> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveMomDiaryEntry create(Ref ref) {
    final argument = this.argument as String;
    return saveMomDiaryEntryUseCase(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveMomDiaryEntry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveMomDiaryEntry>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SaveMomDiaryEntryUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$saveMomDiaryEntryUseCaseHash() =>
    r'c13591b58cf793f0e3b576e144aa7f1127f2660f';

final class SaveMomDiaryEntryUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<SaveMomDiaryEntry, String> {
  const SaveMomDiaryEntryUseCaseFamily._()
      : super(
          retry: null,
          name: r'saveMomDiaryEntryUseCaseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  SaveMomDiaryEntryUseCaseProvider call(
    String householdId,
  ) =>
      SaveMomDiaryEntryUseCaseProvider._(argument: householdId, from: this);

  @override
  String toString() => r'saveMomDiaryEntryUseCaseProvider';
}
