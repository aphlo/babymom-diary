import 'package:flutter/material.dart';

import '../../domain/value_objects/breast_condition.dart';

class BreastConditionChips extends StatelessWidget {
  const BreastConditionChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final SymptomIntensity? selected;
  final ValueChanged<SymptomIntensity?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SymptomIntensity.values.map((value) {
        final isSelected = selected == value;
        return ChoiceChip(
          label: Text(_intensityLabel(value)),
          selected: isSelected,
          showCheckmark: false,
          backgroundColor: Colors.white,
          onSelected: (selected) {
            if (isSelected) {
              // 既に選択されている場合は未選択にする
              onSelected(null);
            } else {
              // 未選択または他の値が選択されている場合は、この値を選択
              onSelected(value);
            }
          },
        );
      }).toList(growable: false),
    );
  }

  String _intensityLabel(SymptomIntensity value) {
    switch (value) {
      case SymptomIntensity.slight:
        return 'すこし';
      case SymptomIntensity.normal:
        return 'ふつう';
      case SymptomIntensity.strong:
        return 'つよい';
    }
  }
}
