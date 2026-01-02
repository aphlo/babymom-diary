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
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
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
    const iconButtonConstraints =
        BoxConstraints.tightFor(width: 32, height: 32);
    return Container(
      decoration: decoration,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        title: Text(ingredient.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              constraints: iconButtonConstraints,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.edit, color: Colors.red, size: 20),
              onPressed: () => _showEditDialog(context, ref),
            ),
            IconButton(
              constraints: iconButtonConstraints,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.close, color: Colors.grey.shade600),
              onPressed: () => _hideIngredient(context, ref),
            ),
          ],
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

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: ingredient.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text('食材を編集'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '食材名を入力',
              border: OutlineInputBorder(),
            ),
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
}
