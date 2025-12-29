import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/baby_food/domain/entities/baby_food_item.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/amount_unit.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';

void main() {
  group('BabyFoodItem', () {
    group('amountDisplay', () {
      BabyFoodItem createItem({
        double? amount,
        AmountUnit? unit,
      }) {
        return BabyFoodItem(
          ingredientId: 'test-id',
          ingredientName: 'テスト食材',
          category: FoodCategory.grains,
          amount: amount,
          unit: unit,
        );
      }

      test('大さじの場合は単位を先に表示する', () {
        final item = createItem(amount: 1, unit: AmountUnit.tablespoon);
        expect(item.amountDisplay, '大さじ1');
      });

      test('大さじで小数の場合も単位を先に表示する', () {
        final item = createItem(amount: 1.5, unit: AmountUnit.tablespoon);
        expect(item.amountDisplay, '大さじ1.5');
      });

      test('小さじの場合は単位を先に表示する', () {
        final item = createItem(amount: 2, unit: AmountUnit.teaspoon);
        expect(item.amountDisplay, '小さじ2');
      });

      test('小さじで小数の場合も単位を先に表示する', () {
        final item = createItem(amount: 0.5, unit: AmountUnit.teaspoon);
        expect(item.amountDisplay, '小さじ0.5');
      });

      test('mlの場合は数値を先に表示する', () {
        final item = createItem(amount: 30, unit: AmountUnit.ml);
        expect(item.amountDisplay, '30ml');
      });

      test('mlで小数の場合も数値を先に表示する', () {
        final item = createItem(amount: 15.5, unit: AmountUnit.ml);
        expect(item.amountDisplay, '15.5ml');
      });

      test('gの場合は数値を先に表示する', () {
        final item = createItem(amount: 50, unit: AmountUnit.gram);
        expect(item.amountDisplay, '50g');
      });

      test('gで小数の場合も数値を先に表示する', () {
        final item = createItem(amount: 25.5, unit: AmountUnit.gram);
        expect(item.amountDisplay, '25.5g');
      });

      test('amountがnullの場合はnullを返す', () {
        final item = createItem(amount: null, unit: AmountUnit.tablespoon);
        expect(item.amountDisplay, isNull);
      });

      test('unitがnullの場合はnullを返す', () {
        final item = createItem(amount: 1, unit: null);
        expect(item.amountDisplay, isNull);
      });

      test('amountとunitの両方がnullの場合はnullを返す', () {
        final item = createItem(amount: null, unit: null);
        expect(item.amountDisplay, isNull);
      });
    });

    group('hasAmount', () {
      test('amountとunitの両方が設定されている場合はtrueを返す', () {
        final item = BabyFoodItem(
          ingredientId: 'test-id',
          ingredientName: 'テスト食材',
          category: FoodCategory.grains,
          amount: 1,
          unit: AmountUnit.tablespoon,
        );
        expect(item.hasAmount, isTrue);
      });

      test('amountがnullの場合はfalseを返す', () {
        final item = BabyFoodItem(
          ingredientId: 'test-id',
          ingredientName: 'テスト食材',
          category: FoodCategory.grains,
          amount: null,
          unit: AmountUnit.tablespoon,
        );
        expect(item.hasAmount, isFalse);
      });

      test('unitがnullの場合はfalseを返す', () {
        final item = BabyFoodItem(
          ingredientId: 'test-id',
          ingredientName: 'テスト食材',
          category: FoodCategory.grains,
          amount: 1,
          unit: null,
        );
        expect(item.hasAmount, isFalse);
      });
    });
  });
}
