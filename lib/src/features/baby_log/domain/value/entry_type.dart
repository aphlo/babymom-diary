enum EntryType {
  breastRight,
  breastLeft,
  formula,
  pump,
  pee,
  poop,
  other,
}

extension EntryTypeLabel on EntryType {
  String get label => switch (this) {
        EntryType.breastRight => '母乳(右)',
        EntryType.breastLeft => '母乳(左)',
        EntryType.formula => 'ミルク',
        EntryType.pump => '搾母乳',
        EntryType.pee => '尿',
        EntryType.poop => '便',
        EntryType.other => 'その他',
      };
}

extension EntryTypeMeta on EntryType {
  /// Whether this entry type typically has an amount value.
  bool get needsAmount => switch (this) {
        EntryType.breastRight || EntryType.breastLeft => true, // minutes
        EntryType.formula || EntryType.pump => true, // ml
        EntryType.pee || EntryType.poop || EntryType.other => false,
      };

  /// Label for the amount/duration input field per type.
  /// Adding a new enum will trigger a compile-time error here
  /// until its label is defined, improving maintainability.
  String get amountLabel => switch (this) {
        EntryType.breastRight || EntryType.breastLeft => '分',
        EntryType.formula || EntryType.pump => 'ml',
        EntryType.pee || EntryType.poop || EntryType.other => '数量',
      };
}
