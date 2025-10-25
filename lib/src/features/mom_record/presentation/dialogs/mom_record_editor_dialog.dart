import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/mom_daily_record.dart';
import '../../domain/value_objects/breast_condition.dart';
import '../../domain/value_objects/lochia_status.dart';
import '../models/mom_record_ui_model.dart';
import '../viewmodels/mom_record_view_model.dart';
import '../widgets/breast_condition_chips.dart';
import '../widgets/labeled_chips_row.dart';
import '../widgets/lochia_chips.dart';
import '../widgets/section_label.dart';
import '../widgets/temperature_field.dart';

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
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 16.0),
              child: Text(
                isNew
                    ? '記録を追加  ${widget.record.dateLabel.replaceAll('\n', '')}'
                    : '記録を編集  ${widget.record.dateLabel.replaceAll('\n', '')}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SectionLabel('体温'),
                    const SizedBox(height: 8),
                    TemperatureField(controller: _temperatureController),
                    const SizedBox(height: 16),
                    const SectionLabel('悪露'),
                    const SizedBox(height: 8),
                    LabeledChipsRow(
                      label: '量：',
                      chips: LochiaAmountChips(
                        selectedAmount: _selectedLochiaAmount,
                        onAmountChanged: (value) {
                          setState(() => _selectedLochiaAmount = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    LabeledChipsRow(
                      label: '色：',
                      chips: LochiaColorChips(
                        selectedColor: _selectedLochiaColor,
                        onColorChanged: (value) {
                          setState(() => _selectedLochiaColor = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SectionLabel('胸'),
                    const SizedBox(height: 8),
                    LabeledChipsRow(
                      label: '張り：',
                      chips: BreastConditionChips(
                        selected: _selectedBreastFirmness,
                        onSelected: (value) {
                          setState(() => _selectedBreastFirmness = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    LabeledChipsRow(
                      label: '痛み：',
                      chips: BreastConditionChips(
                        selected: _selectedBreastPain,
                        onSelected: (value) {
                          setState(() => _selectedBreastPain = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    LabeledChipsRow(
                      label: '赤み：',
                      chips: BreastConditionChips(
                        selected: _selectedBreastRedness,
                        onSelected: (value) {
                          setState(() => _selectedBreastRedness = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SectionLabel('メモ'),
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
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(false),
                    child: const Text('キャンセル'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _isSaving ? null : _handleSave,
                    child: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('保存'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      lochia: LochiaStatus(
        amount: _selectedLochiaAmount,
        color: _selectedLochiaColor,
      ),
      breast: BreastCondition(
        firmness: _selectedBreastFirmness,
        pain: _selectedBreastPain,
        redness: _selectedBreastRedness,
      ),
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
}
