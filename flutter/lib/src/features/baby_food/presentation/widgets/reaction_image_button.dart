import 'package:flutter/material.dart';

import '../../../../core/types/child_icon.dart';
import '../../domain/value_objects/baby_food_reaction.dart';

/// 反応選択用の画像ボタン
class ReactionImageButton extends StatelessWidget {
  const ReactionImageButton({
    super.key,
    required this.childIcon,
    required this.reaction,
    required this.isSelected,
    required this.onTap,
  });

  final ChildIcon childIcon;
  final BabyFoodReaction reaction;
  final bool isSelected;
  final VoidCallback onTap;

  String get _imagePath {
    return switch (reaction) {
      BabyFoodReaction.good => childIcon.goodReactionPath,
      BabyFoodReaction.normal => childIcon.normalReactionPath,
      BabyFoodReaction.bad => childIcon.badReactionPath,
    };
  }

  String get _label {
    return switch (reaction) {
      BabyFoodReaction.good => 'すき',
      BabyFoodReaction.normal => 'ふつう',
      BabyFoodReaction.bad => 'にがて',
    };
  }

  Color get _borderColor {
    if (!isSelected) return Colors.grey.shade300;
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green,
      BabyFoodReaction.normal => Colors.orange,
      BabyFoodReaction.bad => Colors.red,
    };
  }

  Color get _backgroundColor {
    if (!isSelected) return Colors.transparent;
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.withValues(alpha: 0.1),
      BabyFoodReaction.normal => Colors.orange.withValues(alpha: 0.1),
      BabyFoodReaction.bad => Colors.red.withValues(alpha: 0.1),
    };
  }

  Color get _labelColor {
    if (!isSelected) return Colors.grey.shade500;
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.shade700,
      BabyFoodReaction.normal => Colors.orange.shade700,
      BabyFoodReaction.bad => Colors.red.shade700,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: Border.all(
                color: _borderColor,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Opacity(
              opacity: isSelected ? 1.0 : 0.5,
              child: Image.asset(
                _imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: _labelColor,
            ),
          ),
        ],
      ),
    );
  }
}
