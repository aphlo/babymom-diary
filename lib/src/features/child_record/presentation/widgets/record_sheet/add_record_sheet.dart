import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../child_record.dart';
import '../../controllers/other_tags_controller.dart';

class AddRecordSheet extends ConsumerStatefulWidget {
  const AddRecordSheet({
    super.key,
    required this.type,
    required this.initialDateTime,
  });

  final RecordType type;
  final DateTime initialDateTime;

  @override
  ConsumerState<AddRecordSheet> createState() => _AddRecordSheetState();
}

class _AddRecordSheetState extends ConsumerState<AddRecordSheet> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay _timeOfDay;

  final _minutesController = TextEditingController(text: '0');
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  ExcretionVolume? _selectedVolume;
  final Set<String> _selectedTags = {};

  String? _durationError;
  String? _volumeError;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialDateTime.toLocal();
    _timeOfDay = TimeOfDay(hour: initial.hour, minute: initial.minute);
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
      ...switch (widget.type) {
        RecordType.breastLeft || RecordType.breastRight => _buildBreastFields(),
        RecordType.formula => _buildFormulaFields(),
        RecordType.pump => _buildPumpFields(),
        RecordType.pee || RecordType.poop => _buildExcretionFields(),
        RecordType.other => _buildOtherFields(),
      },
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

  List<Widget> _buildBreastFields() {
    return [
      Text(
        '授乳時間',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _minutesController,
        decoration: const InputDecoration(
          labelText: '分',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
      if (_durationError != null) ...[
        const SizedBox(height: 4),
        Text(
          _durationError!,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ],
    ];
  }

  List<Widget> _buildFormulaFields() {
    return [
      Text(
        'ミルク量',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _amountController,
        decoration: const InputDecoration(
          labelText: 'ml',
          border: OutlineInputBorder(),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '量を入力してください';
          }
          final parsed = double.tryParse(value);
          if (parsed == null || parsed <= 0) {
            return '正しい値を入力してください';
          }
          return null;
        },
      ),
    ];
  }

  List<Widget> _buildPumpFields() {
    return [
      Text(
        '搾母乳量',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _amountController,
        decoration: const InputDecoration(
          labelText: 'ml',
          border: OutlineInputBorder(),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '量を入力してください';
          }
          final parsed = double.tryParse(value);
          if (parsed == null || parsed <= 0) {
            return '正しい値を入力してください';
          }
          return null;
        },
      ),
    ];
  }

  List<Widget> _buildExcretionFields() {
    return [
      Text(
        '量の目安',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: [
          for (final volume in ExcretionVolume.values)
            ChoiceChip(
              label: Text(volume.label),
              selected: _selectedVolume == volume,
              onSelected: (selected) {
                setState(() {
                  _selectedVolume = selected ? volume : null;
                  _volumeError = null;
                });
              },
            ),
        ],
      ),
      if (_volumeError != null) ...[
        const SizedBox(height: 4),
        Text(
          _volumeError!,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ],
      const SizedBox(height: 16),
      TextFormField(
        controller: _noteController,
        decoration: const InputDecoration(
          labelText: 'メモ',
          hintText: '自由記述',
          border: OutlineInputBorder(),
        ),
        maxLines: 4,
      ),
    ];
  }

  List<Widget> _buildOtherFields() {
    final tagState = ref.watch(otherTagsControllerProvider);
    final tags = tagState.valueOrNull ?? const <String>[];
    final tagChildren = [
      for (final tag in tags)
        FilterChip(
          label: Text(tag),
          selected: _selectedTags.contains(tag),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedTags.add(tag);
              } else {
                _selectedTags.remove(tag);
              }
            });
          },
        ),
    ];

    return [
      Row(
        children: [
          Text(
            'タグ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: tagState.isLoading ? null : _openManageTagsDialog,
            icon: const Icon(Icons.edit),
            label: const Text('編集'),
          ),
        ],
      ),
      const SizedBox(height: 8),
      if (tagState.isLoading)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Center(child: CircularProgressIndicator()),
        )
      else if (tagState.hasError)
        const Text('タグの読み込みに失敗しました')
      else if (tagChildren.isEmpty)
        const Text('タグがまだ登録されていません')
      else
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tagChildren,
        ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _noteController,
        decoration: const InputDecoration(
          labelText: 'メモ',
          hintText: '自由記述',
          border: OutlineInputBorder(),
        ),
        maxLines: 4,
      ),
    ];
  }

  Future<void> _openManageTagsDialog() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _ManageOtherTagsDialog(),
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

    Record? record;
    switch (widget.type) {
      case RecordType.breastLeft:
      case RecordType.breastRight:
        final minutes = int.tryParse(_minutesController.text) ?? 0;
        if (minutes <= 0) {
          setState(() {
            _durationError = '1分以上の値を入力してください';
          });
          return;
        }
        final totalSeconds = minutes * 60;
        final totalMinutes = minutes.toDouble();
        record = Record(
          type: widget.type,
          at: at,
          amount: totalMinutes,
          durationSeconds: totalSeconds,
        );
        break;
      case RecordType.formula:
      case RecordType.pump:
        final amount = double.tryParse(_amountController.text) ?? 0;
        record = Record(
          type: widget.type,
          at: at,
          amount: amount,
        );
        break;
      case RecordType.pee:
      case RecordType.poop:
        if (_selectedVolume == null) {
          setState(() {
            _volumeError = '量の目安を選択してください';
          });
          return;
        }
        record = Record(
          type: widget.type,
          at: at,
          excretionVolume: _selectedVolume,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        );
        break;
      case RecordType.other:
        final tagState = ref.read(otherTagsControllerProvider);
        final availableTags = tagState.valueOrNull;
        final selectedTags = availableTags == null
            ? _selectedTags.toList(growable: false)
            : _selectedTags
                .where((tag) => availableTags.contains(tag))
                .toList(growable: false);
        record = Record(
          type: widget.type,
          at: at,
          tags: selectedTags,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        );
        break;
    }

    Navigator.of(context).pop(record);
  }
}

class _ManageOtherTagsDialog extends ConsumerStatefulWidget {
  const _ManageOtherTagsDialog();

  @override
  ConsumerState<_ManageOtherTagsDialog> createState() =>
      _ManageOtherTagsDialogState();
}

class _ManageOtherTagsDialogState
    extends ConsumerState<_ManageOtherTagsDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;
  String? _inputError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleAdd() async {
    if (_isSubmitting) {
      return;
    }
    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      setState(() => _inputError = '文字を入力してください');
      return;
    }

    final existing =
        ref.read(otherTagsControllerProvider).valueOrNull ?? const <String>[];
    if (existing.contains(raw)) {
      setState(() => _inputError = '既に登録されています');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _inputError = null;
    });

    try {
      await ref.read(otherTagsControllerProvider.notifier).addTag(raw);
      if (!mounted) return;
      _controller.clear();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('タグの追加に失敗しました')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _handleRemove(String tag) async {
    if (_isSubmitting) {
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref.read(otherTagsControllerProvider.notifier).removeTag(tag);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('タグの削除に失敗しました')));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagState = ref.watch(otherTagsControllerProvider);
    final tags = tagState.valueOrNull ?? const <String>[];

    return AlertDialog(
      title: const Text('タグを編集'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              enabled: !_isSubmitting,
              decoration: InputDecoration(
                labelText: 'タグ名',
                border: const OutlineInputBorder(),
                errorText: _inputError,
              ),
              onSubmitted: (_) => _handleAdd(),
            ),
            const SizedBox(height: 12),
            if (tagState.isLoading)
              const SizedBox(
                height: 72,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (tags.isEmpty)
              const Text('登録済みのタグがありません')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in tags)
                    InputChip(
                      label: Text(tag),
                      onDeleted:
                          _isSubmitting ? null : () => _handleRemove(tag),
                    ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              _isSubmitting ? null : () => Navigator.of(context).maybePop(),
          child: const Text('閉じる'),
        ),
        FilledButton.icon(
          onPressed: _isSubmitting || tagState.isLoading ? null : _handleAdd,
          icon: const Icon(Icons.add),
          label: const Text('追加'),
        ),
      ],
    );
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
          final picked = await showTimePicker(
            context: context,
            initialTime: value,
            initialEntryMode: TimePickerEntryMode.inputOnly,
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
