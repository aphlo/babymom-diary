/// 離乳食に対する子供の反応
enum BabyFoodReaction {
  good,
  normal,
  bad,
}

extension BabyFoodReactionLabel on BabyFoodReaction {
  String get label => switch (this) {
        BabyFoodReaction.good => '好き',
        BabyFoodReaction.normal => '普通',
        BabyFoodReaction.bad => '苦手',
      };

  /// Firestoreに保存する文字列値
  String get firestoreValue => switch (this) {
        BabyFoodReaction.good => 'good',
        BabyFoodReaction.normal => 'normal',
        BabyFoodReaction.bad => 'bad',
      };

  /// Firestore文字列から変換
  static BabyFoodReaction? fromFirestoreValue(String? value) {
    if (value == null) return null;
    return switch (value) {
      'good' => BabyFoodReaction.good,
      'normal' => BabyFoodReaction.normal,
      'bad' => BabyFoodReaction.bad,
      _ => null,
    };
  }
}
