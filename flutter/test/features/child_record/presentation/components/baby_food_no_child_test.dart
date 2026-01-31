import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/core/types/child_icon.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';
import 'package:babymom_diary/src/features/child_record/presentation/components/baby_food/add_ingredient_button.dart';
import 'package:babymom_diary/src/features/child_record/presentation/components/baby_food/baby_food_ingredient_list.dart';
import 'package:babymom_diary/src/features/child_record/presentation/components/baby_food/ingredient_list_tiles.dart';
import 'package:babymom_diary/src/features/menu/children/application/child_context_provider.dart';

void main() {
  group('IngredientListTile - 子供未選択時の動作', () {
    testWidgets('子供未選択時にタップすると「子どもを登録してください」ダイアログが表示される',
        (WidgetTester tester) async {
      // 子供未選択の ChildContext を作成
      final childContextWithNoChild = ChildContext(
        householdId: 'test-household',
        selectedChildId: null, // 子供未選択
        children: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // childContextProvider を AsyncValue.data でオーバーライド
            childContextProvider.overrideWith(() {
              return _MockChildContextNotifier(childContextWithNoChild);
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: IngredientListTile(
                ingredientId: 'rice',
                ingredientName: 'お米',
                category: FoodCategory.grains,
                hasEaten: false,
                reaction: null,
                hasAllergy: false,
                childIcon: ChildIcon.bear,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 食材タイルが表示されていることを確認
      expect(find.text('お米'), findsOneWidget);

      // 食材タイルをタップ
      await tester.tap(find.byType(IngredientListTile));
      await tester.pumpAndSettle();

      // ダイアログが表示されていることを確認
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('子どもを登録してください'), findsOneWidget);
      expect(find.text('記録を行うには、メニューから子どもを登録してください。'), findsOneWidget);

      // OKボタンでダイアログを閉じる
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // ダイアログが閉じていることを確認
      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  group('AddIngredientButton - 子供未選択時の動作', () {
    testWidgets('子供未選択時にタップすると「子どもを登録してください」ダイアログが表示される',
        (WidgetTester tester) async {
      final childContextWithNoChild = ChildContext(
        householdId: 'test-household',
        selectedChildId: null, // 子供未選択
        children: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            childContextProvider.overrideWith(() {
              return _MockChildContextNotifier(childContextWithNoChild);
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  AddIngredientButton(
                    householdId: 'test-household',
                    category: FoodCategory.grains,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 食材追加ボタンが表示されていることを確認
      expect(find.text('食材を追加'), findsOneWidget);

      // 食材追加ボタンをタップ
      await tester.tap(find.byType(AddIngredientButton));
      await tester.pumpAndSettle();

      // ダイアログが表示されていることを確認
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('子どもを登録してください'), findsOneWidget);
    });
  });

  group('BabyFoodIngredientList - 子供未選択時の動作', () {
    testWidgets('子供未選択時でも空のデータでUIが表示される', (WidgetTester tester) async {
      final childContextWithNoChild = ChildContext(
        householdId: 'test-household',
        selectedChildId: null, // 子供未選択
        children: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            childContextProvider.overrideWith(() {
              return _MockChildContextNotifier(childContextWithNoChild);
            }),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: BabyFoodIngredientList(
                householdId: 'test-household',
                records: [], // 空のレコード
                customIngredients: [],
                hiddenIngredients: {},
                childIcon: ChildIcon.bear,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // ローディングスピナーが表示されていないことを確認
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // TabBar（カテゴリタブ）が表示されていることを確認
      expect(find.byType(TabBar), findsOneWidget);

      // 各カテゴリのラベルが表示されていることを確認
      expect(find.text('米・パン・麺'), findsOneWidget);
    });
  });
}

/// テスト用のモック ChildContextNotifier
class _MockChildContextNotifier extends ChildContextNotifier {
  _MockChildContextNotifier(this._mockContext);

  final ChildContext _mockContext;

  @override
  Future<ChildContext> build() async {
    return _mockContext;
  }
}
