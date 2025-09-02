enum EntryType { feeding, sleep }

extension EntryTypeLabel on EntryType {
  String get label => switch (this) {
        EntryType.feeding => '授乳',
        EntryType.sleep => '睡眠',
      };
}

extension EntryTypeAmountLabel on EntryType {
  /// Label for the amount/duration input field per type.
  ///
  /// Adding a new enum will trigger a compile-time error here
  /// until its label is defined, improving maintainability.
  String get amountLabel => switch (this) {
        EntryType.feeding => '合計 (ml)',
        EntryType.sleep => '時間',
      };
}
