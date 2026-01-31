import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import '../../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../../menu/children/application/child_context_provider.dart';

class AddIngredientButton extends ConsumerWidget {
  const AddIngredientButton({
    super.key,
    required this.householdId,
    required this.category,
  });

  final String householdId;
  final FoodCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(Icons.add, color: context.accentPink),
      title: Text(
        '食材を追加',
        style: TextStyle(color: context.accentPink),
      ),
      onTap: () {
        final childContext = ref.read(childContextProvider).value;
        if (childContext == null || !childContext.hasSelectedChild) {
          _showChildRequiredDialog(context);
          return;
        }
        _showAddIngredientDialog(context, ref);
      },
    );
  }

  void _showChildRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '子どもを登録してください',
          style: TextStyle(fontSize: 16),
        ),
        content: const Text(
          '記録を行うには、メニューから子どもを登録してください。',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddIngredientDialog(
      BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text('${category.label}に食材を追加'),
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
            child: const Text('追加'),
          ),
        ],
      ),
    );

    if (name != null && name.trim().isNotEmpty && context.mounted) {
      final useCase = ref.read(addCustomIngredientUseCaseProvider(householdId));
      try {
        await useCase.call(name: name.trim(), category: category);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('「$name」を追加しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('追加に失敗しました: $e')),
          );
        }
      }
    }
  }
}
