import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/baby_food/presentation/providers/baby_food_providers.dart';

import '../widgets/tabbed_ingredient_settings.dart';

/// 離乳食の食材管理ページ
class IngredientSettingsPage extends ConsumerWidget {
  const IngredientSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);

    return asyncHid.when(
      loading: () => _buildLoadingScaffold(context),
      error: (e, __) => _buildErrorScaffold(context, e),
      data: (hid) => _IngredientSettingsBody(householdId: hid),
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('離乳食の食材管理'),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorScaffold(BuildContext context, Object error) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('離乳食の食材管理'),
      ),
      body: Center(child: Text('読み込みに失敗しました\n$error')),
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
      loading: () => _buildLoadingScaffold(context),
      error: (e, __) => _buildErrorScaffold(context, e),
      data: (customIngredients) => hiddenIngredientsAsync.when(
        loading: () => _buildLoadingScaffold(context),
        error: (e, __) => _buildErrorScaffold(context, e),
        data: (hiddenIngredients) => TabbedIngredientSettings(
          householdId: householdId,
          customIngredients: customIngredients,
          hiddenIngredients: hiddenIngredients,
        ),
      ),
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('離乳食の食材管理'),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorScaffold(BuildContext context, Object error) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('離乳食の食材管理'),
      ),
      body: Center(child: Text('読み込みに失敗しました\n$error')),
    );
  }
}
