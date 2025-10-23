import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/mom_daily_record.dart';
import '../../domain/value_objects/breast_condition.dart';
import '../../domain/value_objects/lochia_status.dart';
import '../models/mom_record_ui_model.dart';
import '../viewmodels/mom_record_view_model.dart';

class MomRecordEditorDialog extends ConsumerStatefulWidget {
  const MomRecordEditorDialog({super.key, required this.record});

  final MomDailyRecordUiModel record;

  static Future<bool?> show(
    BuildContext context,
    MomDailyRecordUiModel record,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) => MomRecordEditorDialog(record: record),
    );
  }

  @override
  ConsumerState<MomRecordEditorDialog> createState() =>
      _MomRecordEditorDialogState();
}

class _MomRecordEditorDialogState extends ConsumerState<MomRecordEditorDialog> {
  late final TextEditingController _temperatureController;
  late final TextEditingController _memoController;
  LochiaAmount? _selectedLochiaAmount;
  LochiaColor? _selectedLochiaColor;
  SymptomIntensity? _selectedBreastFirmness;
  SymptomIntensity? _selectedBreastPain;
  SymptomIntensity? _selectedBreastRedness;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final record = widget.record;
    _temperatureController = TextEditingController(
      text: record.temperature != null
          ? record.temperature!.toStringAsFixed(1)
          : '',
    );
    _memoController = TextEditingController(text: record.memo ?? '');
    _selectedLochiaAmount = record.lochiaAmount;
    _selectedLochiaColor = record.lochiaColor;
    _selectedBreastFirmness = record.breastFirmness;
    _selectedBreastPain = record.breastPain;
    _selectedBreastRedness = record.breastRedness;
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = !widget.record.hasData;
    return AlertDialog(
      title: Text(isNew ? '記録を追加' : '記録を編集'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.record.dateLabel,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            _buildTemperatureField(),
            const SizedBox(height: 16),
            _SectionLabel('悪露（量）'),
            const SizedBox(height: 8),
            _buildLochiaAmountChips(),
            const SizedBox(height: 16),
            _SectionLabel('悪露（色）'),
            const SizedBox(height: 8),
            _buildLochiaColorChips(),
            const SizedBox(height: 16),
            _SectionLabel('胸（張り）'),
            const SizedBox(height: 8),
            _buildBreastChips(
              selected: _selectedBreastFirmness,
              onSelected: (value) {
                setState(() => _selectedBreastFirmness = value);
              },
            ),
            const SizedBox(height: 16),
            _SectionLabel('胸（痛み）'),
            const SizedBox(height: 8),
            _buildBreastChips(
              selected: _selectedBreastPain,
              onSelected: (value) {
                setState(() => _selectedBreastPain = value);
              },
            ),
            const SizedBox(height: 16),
            _SectionLabel('胸（赤み）'),
            const SizedBox(height: 8),
            _buildBreastChips(
              selected: _selectedBreastRedness,
              onSelected: (value) {
                setState(() => _selectedBreastRedness = value);
              },
            ),
            const SizedBox(height: 16),
            _SectionLabel('メモ'),
            const SizedBox(height: 8),
            TextField(
              controller: _memoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'メモを入力（任意）',
              ),
              maxLines: 4,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _handleSave,
          child: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('保存'),
        ),
      ],
    );
  }

  Widget _buildTemperatureField() {
    return TextField(
      controller: _temperatureController,
      decoration: const InputDecoration(
        labelText: '体温 (℃)',
        hintText: '36.8',
        helperText: '小数第1位まで入力できます（任意）',
      ),
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
    );
  }

  Widget _buildLochiaAmountChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: LochiaAmount.values.map((value) {
        final selected = _selectedLochiaAmount == value;
        return ChoiceChip(
          label: Text(_lochiaAmountLabel(value)),
          selected: selected,
          onSelected: (isSelected) {
            setState(
              () => _selectedLochiaAmount = isSelected ? value : null,
            );
          },
        );
      }).toList(growable: false),
    );
  }

  Widget _buildLochiaColorChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: LochiaColor.values.map((value) {
        final selected = _selectedLochiaColor == value;
        return ChoiceChip(
          label: Text(_lochiaColorLabel(value)),
          selected: selected,
          onSelected: (isSelected) {
            setState(
              () => _selectedLochiaColor = isSelected ? value : null,
            );
          },
        );
      }).toList(growable: false),
    );
  }

  Widget _buildBreastChips({
    required SymptomIntensity? selected,
    required ValueChanged<SymptomIntensity?> onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SymptomIntensity.values.map((value) {
        final isSelected = selected == value;
        return ChoiceChip(
          label: Text(_intensityLabel(value)),
          selected: isSelected,
          onSelected: (selected) {
            onSelected(selected ? value : null);
          },
        );
      }).toList(growable: false),
    );
  }

  Future<void> _handleSave() async {
    FocusScope.of(context).unfocus();
    final temperatureText = _temperatureController.text.trim();
    double? temperature;
    if (temperatureText.isNotEmpty) {
      temperature = double.tryParse(temperatureText);
      if (temperature == null) {
        setState(() {
          _errorMessage = '体温は数値で入力してください';
        });
        return;
      }
    }
    final memoText = _memoController.text.trim();
    final record = MomDailyRecord(
      date: DateTime(
        widget.record.date.year,
        widget.record.date.month,
        widget.record.date.day,
      ),
      temperatureCelsius: temperature,
      lochia: _selectedLochiaAmount != null && _selectedLochiaColor != null
          ? LochiaStatus(
              amount: _selectedLochiaAmount!,
              color: _selectedLochiaColor!,
            )
          : null,
      breast: _selectedBreastFirmness != null &&
              _selectedBreastPain != null &&
              _selectedBreastRedness != null
          ? BreastCondition(
              firmness: _selectedBreastFirmness!,
              pain: _selectedBreastPain!,
              redness: _selectedBreastRedness!,
            )
          : null,
      memo: memoText.isEmpty ? null : memoText,
    );

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    final notifier = ref.read(momRecordViewModelProvider.notifier);
    try {
      await notifier.saveRecord(record);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (error) {
      setState(() {
        _isSaving = false;
        _errorMessage = '保存に失敗しました';
      });
    }
  }

  String _lochiaAmountLabel(LochiaAmount value) {
    switch (value) {
      case LochiaAmount.low:
        return '少';
      case LochiaAmount.medium:
        return '中';
      case LochiaAmount.high:
        return '多';
    }
  }

  String _lochiaColorLabel(LochiaColor value) {
    switch (value) {
      case LochiaColor.white:
        return '白';
      case LochiaColor.yellow:
        return '黄';
      case LochiaColor.brown:
        return '茶';
      case LochiaColor.pink:
        return 'ピンク';
      case LochiaColor.red:
        return '赤';
    }
  }

  String _intensityLabel(SymptomIntensity value) {
    switch (value) {
      case SymptomIntensity.none:
        return 'なし';
      case SymptomIntensity.slight:
        return 'すこし';
      case SymptomIntensity.normal:
        return 'ふつう';
      case SymptomIntensity.strong:
        return 'つよい';
    }
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
