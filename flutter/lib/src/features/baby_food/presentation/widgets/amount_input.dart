import 'package:flutter/material.dart';

import '../../../../core/types/child_icon.dart';
import '../../domain/value_objects/amount_unit.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../models/baby_food_draft.dart';
import 'amount_input_card.dart';

/// 量入力ウィジェット
class AmountInput extends StatelessWidget {
  const AmountInput({
    super.key,
    required this.items,
    required this.childIcon,
    required this.onAmountChanged,
    required this.onUnitChanged,
    required this.onReactionChanged,
    required this.onAllergyChanged,
    required this.onMemoChanged,
  });

  final List<BabyFoodItemDraft> items;
  final ChildIcon childIcon;
  final void Function(String ingredientId, double? amount) onAmountChanged;
  final void Function(String ingredientId, AmountUnit unit) onUnitChanged;
  final void Function(String ingredientId, BabyFoodReaction? reaction)
      onReactionChanged;
  final void Function(String ingredientId, bool? hasAllergy) onAllergyChanged;
  final void Function(String ingredientId, String? memo) onMemoChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return AmountInputCard(
          key: ValueKey(item.ingredientId),
          item: item,
          childIcon: childIcon,
          onAmountChanged: (amount) =>
              onAmountChanged(item.ingredientId, amount),
          onUnitChanged: (unit) => onUnitChanged(item.ingredientId, unit),
          onReactionChanged: (reaction) =>
              onReactionChanged(item.ingredientId, reaction),
          onAllergyChanged: (hasAllergy) =>
              onAllergyChanged(item.ingredientId, hasAllergy),
          onMemoChanged: (memo) => onMemoChanged(item.ingredientId, memo),
        );
      },
    );
  }
}
