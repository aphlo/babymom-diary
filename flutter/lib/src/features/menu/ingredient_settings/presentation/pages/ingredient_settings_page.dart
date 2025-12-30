import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/custom_ingredient.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';
import 'package:babymom_diary/src/features/baby_food/presentation/providers/baby_food_providers.dart';

/// 離乳食の食材管理ページ
class IngredientSettingsPage extends ConsumerWidget {
  const IngredientSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);

    return asyncHid.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          leading:
              BackButton(onPressed: () => Navigator.of(context).maybePop()),
          title: const Text('離乳食の食材管理'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, __) => Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          leading:
              BackButton(onPressed: () => Navigator.of(context).maybePop()),
          title: const Text('離乳食の食材管理'),
        ),
        body: Center(child: Text('読み込みに失敗しました\n$e')),
      ),
      data: (hid) => _IngredientSettingsBody(householdId: hid),
    );
  }
}

class _IngredientSettingsBody extends ConsumerWidget {
  const _IngredientSettingsBody({required this.householdId});

  final String householdId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customIngredientsAsync =
        ref.watch(customIngredientsProvider(householdId));
    final hiddenIngredientsAsync =
        ref.watch(hiddenIngredientsProvider(householdId));

    return customIngredientsAsync.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          leading:
              BackButton(onPressed: () => Navigator.of(context).maybePop()),
          title: const Text('離乳食の食材管理'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, __) => Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          leading:
              BackButton(onPressed: () => Navigator.of(context).maybePop()),
          title: const Text('離乳食の食材管理'),
        ),
        body: Center(child: Text('読み込みに失敗しました\n$e')),
      ),
      data: (customIngredients) => hiddenIngredientsAsync.when(
        loading: () => Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            leading:
                BackButton(onPressed: () => Navigator.of(context).maybePop()),
            title: const Text('離乳食の食材管理'),
          ),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, __) => Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            leading:
                BackButton(onPressed: () => Navigator.of(context).maybePop()),
            title: const Text('離乳食の食材管理'),
          ),
          body: Center(child: Text('読み込みに失敗しました\n$e')),
        ),
        data: (hiddenIngredients) => _TabbedIngredientSettings(
          householdId: householdId,
          customIngredients: customIngredients,
          hiddenIngredients: hiddenIngredients,
        ),
      ),
    );
  }
}

class _TabbedIngredientSettings extends StatelessWidget {
  const _TabbedIngredientSettings({
    required this.householdId,
    required this.customIngredients,
    required this.hiddenIngredients,
  });

  final String householdId;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: FoodCategory.values.length,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          leading:
              BackButton(onPressed: () => Navigator.of(context).maybePop()),
          title: const Text('離乳食の食材管理'),
        ),
        body: Column(
          children: [
            // カテゴリタブ（白背景）
            Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: FoodCategory.values.map((category) {
                  return Tab(text: category.label);
                }).toList(),
                labelColor: Colors.pink,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.pink,
              ),
            ),
            // 食材リスト
            Expanded(
              child: TabBarView(
                children: FoodCategory.values.map((category) {
                  return _CategoryIngredientList(
                    householdId: householdId,
                    category: category,
                    customIngredients: customIngredients
                        .where((i) => i.category == category)
                        .toList(),
                    hiddenIngredients: hiddenIngredients,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 各カテゴリの食材リスト（タブ内容）
class _CategoryIngredientList extends ConsumerWidget {
  const _CategoryIngredientList({
    required this.householdId,
    required this.category,
    required this.customIngredients,
    required this.hiddenIngredients,
  });

  final String householdId;
  final FoodCategory category;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presetIngredients = category.presetIngredients;
    // プリセット食材のフィルタリング
    final visiblePresetIngredients = presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();
    final hiddenPresetIngredients = presetIngredients
        .where((name) => hiddenIngredients.contains(name))
        .toList();
    // カスタム食材のフィルタリング（IDで非表示判定）
    final visibleCustomIngredients = customIngredients
        .where((i) => !hiddenIngredients.contains(i.id))
        .toList();
    final hiddenCustomIngredients = customIngredients
        .where((i) => hiddenIngredients.contains(i.id))
        .toList();

    final hasHiddenIngredients = hiddenPresetIngredients.isNotEmpty ||
        hiddenCustomIngredients.isNotEmpty;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 食材追加ボタン
        _AddIngredientButton(
          householdId: householdId,
          category: category,
        ),
        // 表示する食材セクション
        const _SectionHeader(title: '表示する食材'),
        // 食材一覧（カスタム + プリセット）
        for (final ingredient in visibleCustomIngredients)
          _CustomIngredientTile(
            householdId: householdId,
            ingredient: ingredient,
            isHidden: false,
          ),
        for (final ingredientName in visiblePresetIngredients)
          _PresetIngredientTile(
            householdId: householdId,
            ingredientName: ingredientName,
            isHidden: false,
          ),
        // 非表示にした食材セクション
        if (hasHiddenIngredients) ...[
          const _SectionHeader(
            title: '非表示の食材（タップで復元）',
          ),
          for (final ingredient in hiddenCustomIngredients)
            _CustomIngredientTile(
              householdId: householdId,
              ingredient: ingredient,
              isHidden: true,
            ),
          for (final ingredientName in hiddenPresetIngredients)
            _PresetIngredientTile(
              householdId: householdId,
              ingredientName: ingredientName,
              isHidden: true,
            ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.pink.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _AddIngredientButton extends ConsumerWidget {
  const _AddIngredientButton({
    required this.householdId,
    required this.category,
  });

  final String householdId;
  final FoodCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.add, color: Colors.pink),
        title: const Text(
          '食材を追加',
          style: TextStyle(color: Colors.pink),
        ),
        onTap: () => _showAddIngredientDialog(context, ref),
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

class _CustomIngredientTile extends ConsumerWidget {
  const _CustomIngredientTile({
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

class _PresetIngredientTile extends ConsumerWidget {
  const _PresetIngredientTile({
    required this.householdId,
    required this.ingredientName,
    required this.isHidden,
  });

  final String householdId;
  final String ingredientName;
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
            ingredientName,
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
        title: Text(ingredientName),
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
      await dataSource.hide(ingredientName);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「$ingredientName」を非表示にしました')),
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
      await dataSource.unhide(ingredientName);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「$ingredientName」を復元しました')),
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
