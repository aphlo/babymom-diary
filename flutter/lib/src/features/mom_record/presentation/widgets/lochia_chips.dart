import 'package:flutter/material.dart';

import '../../domain/value_objects/lochia_status.dart';

class LochiaAmountChips extends StatelessWidget {
  const LochiaAmountChips({
    super.key,
    required this.selectedAmount,
    required this.onAmountChanged,
  });

  final LochiaAmount? selectedAmount;
  final ValueChanged<LochiaAmount?> onAmountChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: LochiaAmount.values.map((value) {
        final selected = selectedAmount == value;
        return ChoiceChip(
          label: Text(_lochiaAmountLabel(value)),
          selected: selected,
          showCheckmark: false,
          onSelected: (isSelected) {
            if (selectedAmount == value) {
              // 既に選択されている場合は未選択にする
              onAmountChanged(null);
            } else {
              // 未選択または他の値が選択されている場合は、この値を選択
              onAmountChanged(value);
            }
          },
        );
      }).toList(growable: false),
    );
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
}

class LochiaColorChips extends StatelessWidget {
  const LochiaColorChips({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  final LochiaColor? selectedColor;
  final ValueChanged<LochiaColor?> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: LochiaColor.values.map((value) {
        final selected = selectedColor == value;
        return ChoiceChip(
          label: Text(_lochiaColorLabel(value)),
          selected: selected,
          showCheckmark: false,
          onSelected: (isSelected) {
            if (selectedColor == value) {
              // 既に選択されている場合は未選択にする
              onColorChanged(null);
            } else {
              // 未選択または他の値が選択されている場合は、この値を選択
              onColorChanged(value);
            }
          },
        );
      }).toList(growable: false),
    );
  }

  String _lochiaColorLabel(LochiaColor value) {
    switch (value) {
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
}
