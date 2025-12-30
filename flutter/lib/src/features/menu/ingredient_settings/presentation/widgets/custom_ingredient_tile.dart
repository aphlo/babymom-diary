import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/presentation/providers/baby_food_providers.dart';

/// カスタム食材のタイル
class CustomIngredientTile extends ConsumerWidget {
  const CustomIngredientTile({
    super.key,
    required this.householdId,
    required this.ingredient,
    required this.isHidden,
  });

  final String householdId;
  final CustomIngredient ingredient;
  final bool isHidden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decoration = BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200),
      ),
    );

    if (isHidden) {
      // 非表示の食材: タップで復元
      return Container(
        decoration: decoration,
        child: ListTile(
          title: Text(
            ingredient.name,
            style: TextStyle(color: Colors.grey.shade500),
          ),
          trailing: TextButton.icon(
            onPressed: () => _unhideIngredient(context, ref),
            icon: const Icon(Icons.restore, size: 18),
            label: const Text('復元'),
          ),
        ),
      );
    }

    // 表示中の食材: 非表示ボタン付き
    return Container(
      decoration: decoration,
      child: ListTile(
        title: Text(ingredient.name),
        trailing: IconButton(
          icon: Icon(Icons.close, color: Colors.grey.shade600),
          onPressed: () => _hideIngredient(context, ref),
        ),
      ),
    );
  }

  Future<void> _hideIngredient(BuildContext context, WidgetRef ref) async {
    final dataSource =
        ref.read(hiddenIngredientsDataSourceProvider(householdId));
    try {
      await dataSource.hide(ingredient.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「${ingredient.name}」を非表示にしました')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('非表示に失敗しました: $e')),
        );
      }
    }
  }

  Future<void> _unhideIngredient(BuildContext context, WidgetRef ref) async {
    final dataSource =
        ref.read(hiddenIngredientsDataSourceProvider(householdId));
    try {
      await dataSource.unhide(ingredient.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「${ingredient.name}」を復元しました')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('復元に失敗しました: $e')),
        );
      }
    }
  }
}
