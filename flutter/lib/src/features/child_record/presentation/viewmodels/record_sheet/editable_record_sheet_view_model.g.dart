// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_record_sheet_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditableRecordSheetViewModel)
const editableRecordSheetViewModelProvider =
    EditableRecordSheetViewModelFamily._();

final class EditableRecordSheetViewModelProvider extends $NotifierProvider<
    EditableRecordSheetViewModel, EditableRecordSheetState> {
  const EditableRecordSheetViewModelProvider._(
      {required EditableRecordSheetViewModelFamily super.from,
      required EditableRecordSheetViewModelArgs super.argument})
      : super(
          retry: null,
          name: r'editableRecordSheetViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$editableRecordSheetViewModelHash();

  @override
  String toString() {
    return r'editableRecordSheetViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EditableRecordSheetViewModel create() => EditableRecordSheetViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditableRecordSheetState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditableRecordSheetState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EditableRecordSheetViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$editableRecordSheetViewModelHash() =>
    r'04602470b0efc3140e8c863bfef47e9bb419340a';

final class EditableRecordSheetViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
            EditableRecordSheetViewModel,
            EditableRecordSheetState,
            EditableRecordSheetState,
            EditableRecordSheetState,
            EditableRecordSheetViewModelArgs> {
  const EditableRecordSheetViewModelFamily._()
      : super(
          retry: null,
          name: r'editableRecordSheetViewModelProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  EditableRecordSheetViewModelProvider call(
    EditableRecordSheetViewModelArgs args,
  ) =>
      EditableRecordSheetViewModelProvider._(argument: args, from: this);

  @override
  String toString() => r'editableRecordSheetViewModelProvider';
}

abstract class _$EditableRecordSheetViewModel
    extends $Notifier<EditableRecordSheetState> {
  late final _$args = ref.$arg as EditableRecordSheetViewModelArgs;
  EditableRecordSheetViewModelArgs get args => _$args;

  EditableRecordSheetState build(
    EditableRecordSheetViewModelArgs args,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<EditableRecordSheetState, EditableRecordSheetState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<EditableRecordSheetState, EditableRecordSheetState>,
        EditableRecordSheetState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
