/// 離乳食の食材カテゴリ
enum FoodCategory {
  grains, // 米・パン・麺
  fish, // 魚
  meat, // 肉
  vegetables, // 野菜
  fruits, // 果物
  dairy, // 乳製品
  soy, // 大豆製品
  other, // その他
}

extension FoodCategoryLabel on FoodCategory {
  String get label => switch (this) {
        FoodCategory.grains => '米・パン・麺',
        FoodCategory.fish => '魚',
        FoodCategory.meat => '肉',
        FoodCategory.vegetables => '野菜',
        FoodCategory.fruits => '果物',
        FoodCategory.dairy => '乳製品',
        FoodCategory.soy => '大豆製品',
        FoodCategory.other => 'その他',
      };

  String get emoji => switch (this) {
        FoodCategory.grains => '🍚',
        FoodCategory.fish => '🐟',
        FoodCategory.meat => '🥩',
        FoodCategory.vegetables => '🥬',
        FoodCategory.fruits => '🍎',
        FoodCategory.dairy => '🥛',
        FoodCategory.soy => '🫘',
        FoodCategory.other => '📦',
      };
}

extension FoodCategoryPresets on FoodCategory {
  /// 各カテゴリのプリセット食材リスト
  List<String> get presetIngredients => switch (this) {
        FoodCategory.grains => [
            '米',
            'パン粥',
            'うどん',
            'そば',
            'そうめん',
            'マカロニ',
            'スパゲッティ',
            '中華麺',
          ],
        FoodCategory.fish => [
            'タラ',
            'タイ',
            'しらす',
            'カジキ',
            'マグロ',
            'ツナ',
            'あじ',
            'いわし',
            'さば',
            'さわら',
            'さんま',
            'ぶり',
            'さけ',
            'えび',
          ],
        FoodCategory.meat => [
            '鶏肉',
            '豚肉',
          ],
        FoodCategory.vegetables => [
            'じゃがいも',
            'さつまいも',
            'さといも',
            'やまいも',
            'かぼちゃ',
            'にんじん',
            '大根',
            'かぶ',
            '玉ねぎ',
            '小松菜',
            'ほうれん草',
            'トマト',
            'ブロッコリー',
            'キャベツ',
            'ピーマン',
            'なす',
            'きゅうり',
            'いんげん',
            'にら',
            'ねぎ',
            '枝豆',
            'とうもろこし',
            'れんこん',
            'オクラ',
            'きのこ類',
          ],
        FoodCategory.fruits => [
            'バナナ',
            'りんご',
            'みかん',
            'ぶどう',
            'いちご',
            '柿',
            '梨',
            'すいか',
            'メロン',
            'もも',
          ],
        FoodCategory.dairy => [
            'ヨーグルト',
            '牛乳（調理用）',
            '牛乳（飲料用）',
          ],
        FoodCategory.soy => [
            '豆腐',
            'きな粉',
            '納豆',
            '豆乳',
            'チーズ',
          ],
        FoodCategory.other => [
            'たまご',
            '海苔',
            'わかめ',
            'こんにゃく',
            'ひじき',
            '春雨',
            'ゼリー',
          ],
      };
}
