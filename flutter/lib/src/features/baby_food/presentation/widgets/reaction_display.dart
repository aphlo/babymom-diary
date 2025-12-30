import 'package:flutter/material.dart';

import '../../../../core/types/child_icon.dart';
import '../../domain/value_objects/baby_food_reaction.dart';

/// 反応表示ウィジェット
class ReactionDisplay extends StatelessWidget {
  const ReactionDisplay({
    super.key,
    required this.reaction,
    required this.childIcon,
  });

  final BabyFoodReaction reaction;
  final ChildIcon childIcon;

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

  Color get _backgroundColor {
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.withValues(alpha: 0.1),
      BabyFoodReaction.normal => Colors.orange.withValues(alpha: 0.1),
      BabyFoodReaction.bad => Colors.red.withValues(alpha: 0.1),
    };
  }

  Color get _labelColor {
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.shade700,
      BabyFoodReaction.normal => Colors.orange.shade700,
      BabyFoodReaction.bad => Colors.red.shade700,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            _imagePath,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          _label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _labelColor,
          ),
        ),
      ],
    );
  }
}
