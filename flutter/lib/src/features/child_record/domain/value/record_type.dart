enum RecordType {
  breastRight,
  breastLeft,
  formula,
  pump,
  babyFood, // 離乳食（搾母乳の後に配置）
  pee,
  poop,
  temperature,
  other,
}

extension RecordTypeLabel on RecordType {
  String get label => switch (this) {
        RecordType.breastRight => '授乳(右)',
        RecordType.breastLeft => '授乳(左)',
        RecordType.formula => 'ミルク',
        RecordType.pump => '搾母乳',
        RecordType.babyFood => '離乳食',
        RecordType.pee => '尿',
        RecordType.poop => '便',
        RecordType.temperature => '体温',
        RecordType.other => 'その他',
      };
}

extension RecordTypeMeta on RecordType {
  /// Whether this record type typically has an amount value.
  bool get needsAmount => switch (this) {
        RecordType.breastRight || RecordType.breastLeft => true, // minutes
        RecordType.formula || RecordType.pump => true, // ml
        RecordType.temperature => true, // celsius
        RecordType.babyFood => false, // 離乳食は別コレクションで管理
        RecordType.pee || RecordType.poop || RecordType.other => false,
      };

  /// Label for the amount/duration input field per type.
  /// Adding a new enum will trigger a compile-time error here
  /// until its label is defined, improving maintainability.
  String get amountLabel => switch (this) {
        RecordType.breastRight || RecordType.breastLeft => '分',
        RecordType.formula || RecordType.pump => 'ml',
        RecordType.temperature => '℃',
        RecordType.babyFood => '', // 離乳食は別画面で詳細入力
        RecordType.pee || RecordType.poop || RecordType.other => '数量',
      };

  /// 離乳食は別コレクションで管理するため、childRecordsには保存しない
  bool get usesSeparateCollection => this == RecordType.babyFood;
}

extension RecordTypeAssets on RecordType {
  String get _baseName => switch (this) {
        RecordType.breastRight || RecordType.breastLeft => 'jyunyuu',
        RecordType.formula => 'milk',
        RecordType.pump => 'sakubonyuu',
        RecordType.babyFood => 'rinyushoku',
        RecordType.pee => 'nyou',
        RecordType.poop => 'unti',
        RecordType.temperature => 'taion',
        RecordType.other => 'memo',
      };

  String iconAssetPath({required bool isDark}) {
    final suffix = isDark ? 'white' : 'black';
    return 'assets/icons/child_record/${_baseName}_$suffix.png';
  }
}
