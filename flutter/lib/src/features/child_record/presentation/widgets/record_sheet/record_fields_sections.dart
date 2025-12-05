import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../child_record.dart';

/// 授乳に関する記録用のフォーム
class BreastRecordFields extends StatelessWidget {
  const BreastRecordFields({
    super.key,
    required this.controller,
    required this.selectedType,
    required this.onTypeChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final String? errorText;
  final RecordType selectedType;
  final ValueChanged<RecordType> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<RecordType>(
            segments: const [
              ButtonSegment(
                value: RecordType.breastLeft,
                label: Text('左'),
              ),
              ButtonSegment(
                value: RecordType.breastRight,
                label: Text('右'),
              ),
            ],
            selected: {selectedType},
            onSelectionChanged: (newSelection) {
              onTypeChanged(newSelection.first);
            },
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '授乳時間(分)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}

/// ミルク・搾母乳に関する記録用のフォーム
class AmountRecordFields extends StatelessWidget {
  const AmountRecordFields({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '量(ml)',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
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
      ],
    );
  }
}

/// 尿・便に関する記録用のフォーム
class ExcretionRecordFields extends StatelessWidget {
  const ExcretionRecordFields({
    super.key,
    required this.selectedVolume,
    required this.onVolumeChanged,
    required this.noteController,
    this.errorText,
  });

  final ExcretionVolume? selectedVolume;
  final ValueChanged<ExcretionVolume?> onVolumeChanged;
  final TextEditingController noteController;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                selected: selectedVolume == volume,
                showCheckmark: false,
                onSelected: (selected) =>
                    onVolumeChanged(selected ? volume : null),
              ),
          ],
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox(height: 16),
        NoteField(controller: noteController),
      ],
    );
  }
}

/// その他に関する記録用のフォーム
class OtherRecordFields extends StatelessWidget {
  const OtherRecordFields({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.tags,
    required this.selectedTags,
    required this.onTagToggled,
    required this.onManageTagsPressed,
    required this.noteController,
  });

  final bool isLoading;
  final bool hasError;
  final List<String> tags;
  final Set<String> selectedTags;
  final void Function(String tag, bool selected) onTagToggled;
  final VoidCallback? onManageTagsPressed;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    Widget tagContent;
    if (isLoading) {
      tagContent = const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (hasError) {
      tagContent = const Text('タグの読み込みに失敗しました');
    } else if (tags.isEmpty) {
      tagContent = const Text('タグがまだ登録されていません');
    } else {
      tagContent = Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final tag in tags)
            FilterChip(
              label: Text(tag),
              selected: selectedTags.contains(tag),
              showCheckmark: false,
              onSelected: (selected) => onTagToggled(tag, selected),
            ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'タグ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onManageTagsPressed,
              icon: const Icon(Icons.edit),
              label: const Text('編集'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        tagContent,
        const SizedBox(height: 16),
        NoteField(controller: noteController),
      ],
    );
  }
}

/// 体温に関する記録用のフォーム
class TemperatureRecordFields extends StatelessWidget {
  const TemperatureRecordFields({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '体温(℃)',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '体温を入力してください';
            }
            final parsed = double.tryParse(value);
            if (parsed == null || parsed <= 0 || parsed > 50) {
              return '正しい体温を入力してください';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class NoteField extends StatelessWidget {
  const NoteField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'メモ',
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
    );
  }
}
