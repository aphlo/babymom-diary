/// 離乳食の量の単位
enum AmountUnit {
  tablespoon, // 大さじ
  teaspoon, // 小さじ
  ml, // ml
  gram, // g
}

extension AmountUnitLabel on AmountUnit {
  String get label => switch (this) {
        AmountUnit.tablespoon => '大さじ',
        AmountUnit.teaspoon => '小さじ',
        AmountUnit.ml => 'ml',
        AmountUnit.gram => 'g',
      };

  String get shortLabel => switch (this) {
        AmountUnit.tablespoon => '大さじ',
        AmountUnit.teaspoon => '小さじ',
        AmountUnit.ml => 'ml',
        AmountUnit.gram => 'g',
      };
}
