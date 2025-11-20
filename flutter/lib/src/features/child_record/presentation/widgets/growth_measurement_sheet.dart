import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../child_record.dart';
import '../models/growth_measurement_point.dart';
import '../viewmodels/growth_chart_view_model.dart';

Future<void> showHeightRecordSheet({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
  GrowthMeasurementPoint? record,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (ctx) => HeightRecordSheet(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      record: record,
    ),
  );
}

Future<void> showWeightRecordSheet({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
  GrowthMeasurementPoint? record,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (ctx) => WeightRecordSheet(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      record: record,
    ),
  );
}

class HeightRecordSheet extends ConsumerStatefulWidget {
  const HeightRecordSheet({
    super.key,
    required this.initialDate,
    this.minimumDate,
    this.maximumDate,
    this.record,
  });

  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final GrowthMeasurementPoint? record;

  @override
  ConsumerState<HeightRecordSheet> createState() => _HeightRecordSheetState();
}

class _HeightRecordSheetState extends ConsumerState<HeightRecordSheet> {
  late DateTime _selectedDate = widget.initialDate;
  final TextEditingController _heightController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.record?.recordedAt ?? widget.initialDate;
    if (widget.record?.height != null) {
      _heightController.text = widget.record!.height!.toStringAsFixed(1);
    }
  }

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
      final notifier = ref.read(growthChartViewModelProvider.notifier);
      if (widget.record != null) {
        await notifier.updateHeightRecord(
          recordId: widget.record!.id,
          recordedAt: _selectedDate,
          heightCm: height,
          note: widget.record?.note,
        );
      } else {
        await notifier.addHeightRecord(
            recordedAt: _selectedDate, heightCm: height);
      }

      if (mounted) {
        Navigator.of(context).maybePop();
      }
    } on DuplicateGrowthRecordException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
      });
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('記録の重複'),
          content: Text(error.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
                  widget.record == null ? '身長を記録' : '身長を編集',
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

class WeightRecordSheet extends ConsumerStatefulWidget {
  const WeightRecordSheet({
    super.key,
    required this.initialDate,
    this.minimumDate,
    this.maximumDate,
    this.record,
  });

  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final GrowthMeasurementPoint? record;

  @override
  ConsumerState<WeightRecordSheet> createState() => _WeightRecordSheetState();
}

class _WeightRecordSheetState extends ConsumerState<WeightRecordSheet> {
  late DateTime _selectedDate = widget.initialDate;
  final TextEditingController _weightController = TextEditingController();
  WeightUnit _unit = WeightUnit.kilograms;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.record?.recordedAt ?? widget.initialDate;
    final record = widget.record;
    if (record?.hasWeight ?? false) {
      _unit = record!.resolvedWeightUnit;
      final value = record.weightDisplayValue;
      if (value != null) {
        _weightController.text = _formatWeightInputValue(value);
      }
    }
  }

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
      case WeightUnit.kilograms:
        return value * 1000;
      case WeightUnit.grams:
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
      final notifier = ref.read(growthChartViewModelProvider.notifier);
      if (widget.record != null) {
        await notifier.updateWeightRecord(
          recordId: widget.record!.id,
          recordedAt: _selectedDate,
          weightGrams: weight,
          weightUnit: _unit,
          note: widget.record?.note,
        );
      } else {
        await notifier.addWeightRecord(
            recordedAt: _selectedDate, weightGrams: weight, weightUnit: _unit);
      }

      if (mounted) {
        Navigator.of(context).maybePop();
      }
    } on DuplicateGrowthRecordException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
      });
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('記録の重複'),
          content: Text(error.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
    final unitOptions = WeightUnit.values;

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
                  widget.record == null ? '体重を記録' : '体重を編集',
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
                            _unit = unitOptions[index];
                          });
                        },
                  children: unitOptions
                      .map(
                        (unit) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(unit.label),
                        ),
                      )
                      .toList(),
                ),
              ],
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
    return WeightUnit.values.map((unit) => unit == _unit).toList();
  }

  String _formatWeightInputValue(double value) {
    var text = value.toStringAsFixed(3);
    if (text.contains('.')) {
      text = text.replaceFirst(RegExp('\\.?0+\$'), '');
    }
    return text;
  }
}
