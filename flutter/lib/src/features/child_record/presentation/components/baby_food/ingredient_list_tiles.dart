import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/domain/value_objects/baby_food_reaction.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import '../../../../baby_food/presentation/providers/baby_food_providers.dart';
import 'reaction_icon.dart';

class CustomIngredientListTile extends ConsumerWidget {
  const CustomIngredientListTile({
    super.key,
    required this.householdId,
    required this.ingredient,
    required this.category,
    required this.hasEaten,
    required this.reaction,
    required this.hasAllergy,
    required this.childIcon,
  });

  final String householdId;
  final CustomIngredient ingredient;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? reaction;
  final bool hasAllergy;
  final ChildIcon childIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => context.push(
        '/baby-food/ingredient-detail',
        extra: {
          'ingredientId': ingredient.id,
          'ingredientName': ingredient.name,
          'category': category,
        },
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 72),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: hasEaten ? Colors.green.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      hasEaten ? Colors.green.shade200 : Colors.grey.shade300,
                ),
              ),
              child: Text(
                hasEaten ? '食べた' : 'まだ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      hasEaten ? Colors.green.shade700 : Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      ingredient.name,
                      style: hasAllergy
                          ? const TextStyle(color: Colors.red)
                          : null,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasAllergy) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Text(
                        'アレルギー',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 固定幅で反応アイコンまたは空のスペースを表示
            SizedBox(
              width: 50,
              child: reaction != null
                  ? ReactionIcon(reaction: reaction!, childIcon: childIcon)
                  : null,
            ),
            // 3点リーダーメニュー
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditDialog(context, ref);
                  case 'delete':
                    _showDeleteConfirmation(context, ref);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('編集'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('削除', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: ingredient.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('食材を編集'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '食材名を入力',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('保存'),
          ),
        ],
      ),
    );

    if (newName != null && newName.trim().isNotEmpty && context.mounted) {
      final useCase =
          ref.read(updateCustomIngredientUseCaseProvider(householdId));
      try {
        await useCase.call(
            ingredientId: ingredient.id, newName: newName.trim());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('「$newName」に変更しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('編集に失敗しました: $e')),
          );
        }
      }
    }
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('食材を削除'),
        content: Text('「${ingredient.name}」を削除しますか？\n\n'
            '※過去の記録からは削除されません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final useCase =
          ref.read(deleteCustomIngredientUseCaseProvider(householdId));
      try {
        await useCase.call(ingredientId: ingredient.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('「${ingredient.name}」を削除しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('削除に失敗しました: $e')),
          );
        }
      }
    }
  }
}

class IngredientListTile extends StatelessWidget {
  const IngredientListTile({
    super.key,
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.hasEaten,
    required this.reaction,
    required this.hasAllergy,
    required this.childIcon,
  });

  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? reaction;
  final bool hasAllergy;
  final ChildIcon childIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        '/baby-food/ingredient-detail',
        extra: {
          'ingredientId': ingredientId,
          'ingredientName': ingredientName,
          'category': category,
        },
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 72),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: hasEaten ? Colors.green.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      hasEaten ? Colors.green.shade200 : Colors.grey.shade300,
                ),
              ),
              child: Text(
                hasEaten ? '食べた' : 'まだ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      hasEaten ? Colors.green.shade700 : Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      ingredientName,
                      style: hasAllergy
                          ? const TextStyle(color: Colors.red)
                          : null,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasAllergy) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Text(
                        'アレルギー',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 固定幅で反応アイコンまたは空のスペースを表示
            SizedBox(
              width: 50,
              child: reaction != null
                  ? ReactionIcon(reaction: reaction!, childIcon: childIcon)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
