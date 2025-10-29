import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../viewmodels/growth_chart_view_model.dart';

Future<void> showHeightRecordSheet({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => HeightRecordSheet(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
    ),
  );
}

Future<void> showWeightRecordSheet({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => WeightRecordSheet(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
    ),
  );
}

class HeightRecordSheet extends ConsumerStatefulWidget {
  const HeightRecordSheet({
    super.key,
    required this.initialDate,
    this.minimumDate,
    this.maximumDate,
  });

  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  ConsumerState<HeightRecordSheet> createState() => _HeightRecordSheetState();
}

class _HeightRecordSheetState extends ConsumerState<HeightRecordSheet> {
  late DateTime _selectedDate = widget.initialDate;
  final TextEditingController _heightController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  DateTime get _firstDate {
    final minDate = widget.minimumDate ?? DateTime(2000, 1, 1);
    final lastDate = _lastDate;
    if (minDate.isAfter(lastDate)) {
      return lastDate;
    }
    return minDate;
  }

  DateTime get _lastDate {
    final today = DateTime.now();
    final maxDate = widget.maximumDate ?? today;
    return maxDate.isAfter(today) ? today : maxDate;
  }

  double? get _parsedHeight {
    final raw = _heightController.text.trim().replaceAll(',', '.');
    if (raw.isEmpty) {
      return null;
    }
    final value = double.tryParse(raw);
    if (value == null || value <= 0) {
      return null;
    }
    return value;
  }

  Future<void> _pickDate() async {
    if (_isSaving) {
      return;
    }
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (selected != null) {
      setState(() {
        _selectedDate = DateTime(selected.year, selected.month, selected.day);
      });
    }
  }

  Future<void> _submit() async {
    final height = _parsedHeight;
    if (height == null) {
      return;
    }
    setState(() {
      _isSaving = true;
    });
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(growthChartViewModelProvider.notifier)
          .addHeightRecord(recordedAt: _selectedDate, heightCm: height);
      if (mounted) {
        Navigator.of(context).maybePop();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('身長の保存に失敗しました: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final dateFormat = DateFormat('yyyy/MM/dd');
    final canSubmit = !_isSaving && _parsedHeight != null;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, padding + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '身長を記録',
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '記録日',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isSaving ? null : _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(dateFormat.format(_selectedDate)),
            ),
            const SizedBox(height: 16),
            Text(
              '身長 (cm)',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '例: 60.5',
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) {
                if (canSubmit) {
                  _submit();
                }
              },
              enabled: !_isSaving,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: canSubmit ? _submit : null,
                child: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _WeightUnit { kg, g }

class WeightRecordSheet extends ConsumerStatefulWidget {
  const WeightRecordSheet({
    super.key,
    required this.initialDate,
    this.minimumDate,
    this.maximumDate,
  });

  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  ConsumerState<WeightRecordSheet> createState() => _WeightRecordSheetState();
}

class _WeightRecordSheetState extends ConsumerState<WeightRecordSheet> {
  late DateTime _selectedDate = widget.initialDate;
  final TextEditingController _weightController = TextEditingController();
  _WeightUnit _unit = _WeightUnit.kg;
  bool _isSaving = false;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  DateTime get _firstDate {
    final minDate = widget.minimumDate ?? DateTime(2000, 1, 1);
    final lastDate = _lastDate;
    if (minDate.isAfter(lastDate)) {
      return lastDate;
    }
    return minDate;
  }

  DateTime get _lastDate {
    final today = DateTime.now();
    final maxDate = widget.maximumDate ?? today;
    return maxDate.isAfter(today) ? today : maxDate;
  }

  double? get _parsedWeightGrams {
    final raw = _weightController.text.trim().replaceAll(',', '.');
    if (raw.isEmpty) {
      return null;
    }
    final value = double.tryParse(raw);
    if (value == null || value <= 0) {
      return null;
    }
    switch (_unit) {
      case _WeightUnit.kg:
        return value * 1000;
      case _WeightUnit.g:
        return value;
    }
  }

  Future<void> _pickDate() async {
    if (_isSaving) {
      return;
    }
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (selected != null) {
      setState(() {
        _selectedDate = DateTime(selected.year, selected.month, selected.day);
      });
    }
  }

  Future<void> _submit() async {
    final weight = _parsedWeightGrams;
    if (weight == null) {
      return;
    }
    setState(() {
      _isSaving = true;
    });
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(growthChartViewModelProvider.notifier)
          .addWeightRecord(recordedAt: _selectedDate, weightGrams: weight);
      if (mounted) {
        Navigator.of(context).maybePop();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('体重の保存に失敗しました: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final dateFormat = DateFormat('yyyy/MM/dd');
    final canSubmit = !_isSaving && _parsedWeightGrams != null;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, padding + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '体重を記録',
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '記録日',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isSaving ? null : _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(dateFormat.format(_selectedDate)),
            ),
            const SizedBox(height: 16),
            Text(
              '体重',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '例: 3.1',
                    ),
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) {
                      if (canSubmit) {
                        _submit();
                      }
                    },
                    enabled: !_isSaving,
                  ),
                ),
                const SizedBox(width: 12),
                ToggleButtons(
                  isSelected: _weightUnitSelection,
                  onPressed: _isSaving
                      ? null
                      : (index) {
                          setState(() {
                            _unit = _WeightUnit.values[index];
                          });
                        },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('kg'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('g'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            if (_unit == _WeightUnit.kg)
              Text(
                '保存時に g に変換されます',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: canSubmit ? _submit : null,
                child: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<bool> get _weightUnitSelection {
    return _WeightUnit.values.map((unit) => unit == _unit).toList();
  }
}
