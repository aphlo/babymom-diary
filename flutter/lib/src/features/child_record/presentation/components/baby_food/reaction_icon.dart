import 'package:flutter/material.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../baby_food/domain/value_objects/baby_food_reaction.dart';

class ReactionIcon extends StatelessWidget {
  const ReactionIcon({
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

  Color get _backgroundColor {
    return switch (reaction) {
      BabyFoodReaction.good => Colors.green.withValues(alpha: 0.1),
      BabyFoodReaction.normal => Colors.orange.withValues(alpha: 0.1),
      BabyFoodReaction.bad => Colors.red.withValues(alpha: 0.1),
    };
  }

  String get _label {
    return switch (reaction) {
      BabyFoodReaction.good => 'すき',
      BabyFoodReaction.normal => 'ふつう',
      BabyFoodReaction.bad => 'にがて',
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
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
        const SizedBox(height: 2),
        Text(
          _label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: _labelColor,
          ),
        ),
      ],
    );
  }
}
