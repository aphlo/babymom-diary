import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/milu_infinite_time_picker.dart';
import '../../../../menu/children/application/child_context_provider.dart';
import '../../../child_record.dart';
import '../../models/record_draft.dart';
import '../../providers/record_tag_controller.dart';
import '../../viewmodels/record_sheet/editable_record_sheet_view_model.dart';
import 'manage_other_tags_dialog.dart';
import 'record_fields_sections.dart';

class EditableRecordSheet extends ConsumerStatefulWidget {
  const EditableRecordSheet({
    super.key,
    required this.initialDraft,
    required this.isNew,
  });

  final RecordDraft initialDraft;
  final bool isNew;

  @override
  ConsumerState<EditableRecordSheet> createState() =>
      _EditableRecordSheetState();
}

class _EditableRecordSheetState extends ConsumerState<EditableRecordSheet> {
  final _formKey = GlobalKey<FormState>();
  late final EditableRecordSheetViewModelArgs _args;
  late final TextEditingController _minutesController;
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;

  EditableRecordSheetViewModelProvider get _viewModelProvider =>
      editableRecordSheetViewModelProvider(_args);

  @override
  void initState() {
    super.initState();
    _args = EditableRecordSheetViewModelArgs(
      initialDraft: widget.initialDraft,
      isNew: widget.isNew,
    );
    final initialState = ref.read(_viewModelProvider);
    _minutesController = TextEditingController(text: initialState.minutesInput);
    _amountController = TextEditingController(text: initialState.amountInput);
    _noteController = TextEditingController(text: initialState.noteInput);
    _minutesController.addListener(_onMinutesChanged);
    _amountController.addListener(_onAmountChanged);
    _noteController.addListener(_onNoteChanged);
  }

  @override
  void dispose() {
    _minutesController
      ..removeListener(_onMinutesChanged)
      ..dispose();
    _amountController
      ..removeListener(_onAmountChanged)
      ..dispose();
    _noteController
      ..removeListener(_onNoteChanged)
      ..dispose();
    super.dispose();
  }

  void _onMinutesChanged() {
    ref
        .read(_viewModelProvider.notifier)
        .updateMinutesInput(_minutesController.text);
  }

  void _onAmountChanged() {
    ref
        .read(_viewModelProvider.notifier)
        .updateAmountInput(_amountController.text);
  }

  void _onNoteChanged() {
    ref.read(_viewModelProvider.notifier).updateNoteInput(_noteController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_viewModelProvider);
    final viewModel = ref.read(_viewModelProvider.notifier);
    final householdId = ref.watch(childContextProvider).value?.householdId;
    final tagsAsync = householdId != null
        ? ref.watch(recordTagControllerProvider(householdId))
        : const AsyncValue<List<String>>.data(<String>[]);
    final type = state.type;
    final typeLabel = type.label;

    final typeSpecificFields = switch (type) {
      RecordType.breastLeft || RecordType.breastRight => BreastRecordFields(
          controller: _minutesController,
          errorText: state.durationError,
          selectedType: type,
          onTypeChanged: viewModel.updateType,
        ),
      RecordType.formula || RecordType.pump => AmountRecordFields(
          controller: _amountController,
        ),
      RecordType.temperature => TemperatureRecordFields(
          controller: _amountController,
        ),
      RecordType.pee || RecordType.poop => ExcretionRecordFields(
          selectedVolume: state.selectedVolume,
          errorText: state.volumeError,
          noteController: _noteController,
          onVolumeChanged: viewModel.selectVolume,
        ),
      RecordType.other => OtherRecordFields(
          isLoading: tagsAsync.isLoading,
          hasError: tagsAsync.hasError,
          tags: tagsAsync.value ?? const <String>[],
          selectedTags: state.selectedTags,
          onTagToggled: (tag, selected) => viewModel.toggleTag(tag, selected),
          onManageTagsPressed: tagsAsync.isLoading || householdId == null
              ? null
              : () => _openManageTagsDialog(householdId),
          noteController: _noteController,
        ),
      // 離乳食は別シートで管理するためここでは処理しない
      RecordType.babyFood => const SizedBox.shrink(),
    };

    final children = <Widget>[
      Row(
        children: [
          Text(
            '$typeLabelの記録',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      const SizedBox(height: 12),
      _TimePickerField(
        label: '記録時間',
        value: state.timeOfDay,
        onChanged: viewModel.setTimeOfDay,
      ),
      const SizedBox(height: 16),
      typeSpecificFields,
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _handleSubmit,
          icon: const Icon(Icons.save),
          label: const Text('保存'),
        ),
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openManageTagsDialog(String householdId) async {
    await showDialog<void>(
      context: context,
      builder: (_) => ManageOtherTagsDialog(householdId: householdId),
    );
    if (!mounted) return;
    final availableTags =
        ref.read(recordTagControllerProvider(householdId)).value;
    ref.read(_viewModelProvider.notifier).syncSelectedTags(availableTags);
  }

  void _handleSubmit() {
    final viewModel = ref.read(_viewModelProvider.notifier);
    viewModel.resetValidationErrors();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final draft = viewModel.submit();
    if (draft == null) {
      return;
    }
    Navigator.of(context).pop(draft);
  }
}

class _TimePickerField extends StatelessWidget {
  const _TimePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final TimeOfDay value;
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) {
    final formatted = value.format(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: FilledButton.tonalIcon(
        onPressed: () async {
          final picked = await showMiluInfiniteTimePicker(
            context,
            initialTime: value,
          );
          if (picked != null) {
            onChanged(picked);
          }
        },
        icon: const Icon(Icons.access_time),
        label: Text(formatted),
      ),
    );
  }
}
