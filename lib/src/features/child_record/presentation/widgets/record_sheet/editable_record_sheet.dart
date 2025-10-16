import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../child_record.dart';
import '../../controllers/other_tags_controller.dart';
import 'manage_other_tags_dialog.dart';
import 'record_fields_sections.dart';

class EditableRecordSheet extends ConsumerStatefulWidget {
  const EditableRecordSheet({
    super.key,
    required this.type,
    required this.initialDateTime,
    this.initialRecord,
  });

  final RecordType type;
  final DateTime initialDateTime;
  final Record? initialRecord;

  @override
  ConsumerState<EditableRecordSheet> createState() =>
      _EditableRecordSheetState();
}

class _EditableRecordSheetState extends ConsumerState<EditableRecordSheet> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay _timeOfDay;

  final _minutesController = TextEditingController(text: '0');
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  ExcretionVolume? _selectedVolume;
  final Set<String> _selectedTags = {};

  String? _durationError;
  String? _volumeError;

  bool get _isEditing => widget.initialRecord != null;

  @override
  void initState() {
    super.initState();
    final initial =
        widget.initialRecord?.at.toLocal() ?? widget.initialDateTime.toLocal();
    _timeOfDay = TimeOfDay(hour: initial.hour, minute: initial.minute);

    final record = widget.initialRecord;
    if (record == null) {
      return;
    }

    switch (record.type) {
      case RecordType.breastLeft:
      case RecordType.breastRight:
        final minutes = (record.durationSeconds ?? 0) ~/ 60;
        _minutesController.text = minutes.toString();
        break;
      case RecordType.formula:
      case RecordType.pump:
        final amount = record.amount;
        if (amount != null) {
          _amountController.text = amount == amount.roundToDouble()
              ? amount.toStringAsFixed(0)
              : '$amount';
        }
        break;
      case RecordType.pee:
      case RecordType.poop:
        _selectedVolume = record.excretionVolume;
        final note = record.note;
        if (note != null) {
          _noteController.text = note;
        }
        break;
      case RecordType.other:
        _selectedTags.addAll(record.tags);
        final note = record.note;
        if (note != null) {
          _noteController.text = note;
        }
        break;
    }
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typeLabel = widget.type.label;
    final tagState = ref.watch(otherTagsControllerProvider);
    final typeSpecificFields = switch (widget.type) {
      RecordType.breastLeft || RecordType.breastRight => BreastRecordFields(
          controller: _minutesController,
          errorText: _durationError,
        ),
      RecordType.formula => AmountRecordFields(
          controller: _amountController,
        ),
      RecordType.pump => AmountRecordFields(
          controller: _amountController,
        ),
      RecordType.pee || RecordType.poop => ExcretionRecordFields(
          selectedVolume: _selectedVolume,
          errorText: _volumeError,
          noteController: _noteController,
          onVolumeChanged: (volume) {
            setState(() {
              _selectedVolume = volume;
              _volumeError = null;
            });
          },
        ),
      RecordType.other => OtherRecordFields(
          isLoading: tagState.isLoading,
          hasError: tagState.hasError,
          tags: tagState.valueOrNull ?? const <String>[],
          selectedTags: _selectedTags,
          onTagToggled: (tag, selected) {
            setState(() {
              if (selected) {
                _selectedTags.add(tag);
              } else {
                _selectedTags.remove(tag);
              }
            });
          },
          onManageTagsPressed:
              tagState.isLoading ? null : _openManageTagsDialog,
          noteController: _noteController,
        ),
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
        value: _timeOfDay,
        onChanged: (value) => setState(() => _timeOfDay = value),
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

  Future<void> _openManageTagsDialog() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const ManageOtherTagsDialog(),
    );
    if (!mounted) return;
    final tagState = ref.read(otherTagsControllerProvider);
    final availableTags = tagState.valueOrNull;
    if (availableTags != null) {
      setState(() {
        _selectedTags.removeWhere((tag) => !availableTags.contains(tag));
      });
    }
  }

  void _handleSubmit() {
    setState(() {
      _durationError = null;
      _volumeError = null;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final selectedDate = widget.initialDateTime;
    final at = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      _timeOfDay.hour,
      _timeOfDay.minute,
    );

    final record = _buildRecord(at);
    if (record == null) {
      return;
    }
    Navigator.of(context).pop(record);
  }

  Record? _buildRecord(DateTime at) {
    switch (widget.type) {
      case RecordType.breastLeft:
      case RecordType.breastRight:
        return _buildBreastRecord(at);
      case RecordType.formula:
      case RecordType.pump:
        return _buildAmountRecord(at);
      case RecordType.pee:
      case RecordType.poop:
        return _buildExcretionRecord(at);
      case RecordType.other:
        return _buildOtherRecord(at);
    }
  }

  Record? _buildBreastRecord(DateTime at) {
    final minutes = int.tryParse(_minutesController.text) ?? 0;
    if (minutes < 0) {
      setState(() {
        _durationError = '0以上の値を入力してください';
      });
      return null;
    }
    final totalSeconds = minutes * 60;
    final totalMinutes = minutes.toDouble();
    if (_isEditing) {
      return widget.initialRecord!.copyWith(
        at: at,
        amount: totalMinutes,
        durationSeconds: totalSeconds,
      );
    }
    return Record(
      type: widget.type,
      at: at,
      amount: totalMinutes,
      durationSeconds: totalSeconds,
    );
  }

  Record? _buildAmountRecord(DateTime at) {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      return null;
    }
    if (_isEditing) {
      return widget.initialRecord!.copyWith(
        at: at,
        amount: amount,
      );
    }
    return Record(
      type: widget.type,
      at: at,
      amount: amount,
    );
  }

  Record? _buildExcretionRecord(DateTime at) {
    final volume = _selectedVolume;
    if (volume == null) {
      setState(() {
        _volumeError = '量の目安を選択してください';
      });
      return null;
    }
    final note = _noteOrNull();
    if (_isEditing) {
      return widget.initialRecord!.copyWith(
        at: at,
        excretionVolume: volume,
        note: note,
      );
    }
    return Record(
      type: widget.type,
      at: at,
      excretionVolume: volume,
      note: note,
    );
  }

  Record _buildOtherRecord(DateTime at) {
    final tagState = ref.read(otherTagsControllerProvider);
    final availableTags = tagState.valueOrNull;
    final selectedTags = availableTags == null
        ? _selectedTags.toList(growable: false)
        : _selectedTags
            .where((tag) => availableTags.contains(tag))
            .toList(growable: false);
    final note = _noteOrNull();
    if (_isEditing) {
      return widget.initialRecord!.copyWith(
        at: at,
        tags: selectedTags,
        note: note,
      );
    }
    return Record(
      type: widget.type,
      at: at,
      tags: selectedTags,
      note: note,
    );
  }

  String? _noteOrNull() {
    final note = _noteController.text.trim();
    return note.isEmpty ? null : note;
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
          final now = DateTime.now();
          final reference = DateTime(
            now.year,
            now.month,
            now.day,
            value.hour,
            value.minute,
          );
          final picked = await DatePicker.showTimePicker(
            context,
            currentTime: reference,
            showTitleActions: true,
            showSecondsColumn: false,
            locale: LocaleType.jp,
          );
          if (picked != null) {
            onChanged(
              TimeOfDay(
                hour: picked.hour,
                minute: picked.minute,
              ),
            );
          }
        },
        icon: const Icon(Icons.access_time),
        label: Text(formatted),
      ),
    );
  }
}
