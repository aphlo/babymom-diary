import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import 'category_ingredient_list.dart';

/// タブ付きの食材設定ビュー
class TabbedIngredientSettings extends StatelessWidget {
  const TabbedIngredientSettings({
    super.key,
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
                  return CategoryIngredientList(
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
