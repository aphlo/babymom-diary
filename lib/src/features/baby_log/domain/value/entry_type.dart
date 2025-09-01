enum EntryType { feeding, diaper, sleep }

extension EntryTypeLabel on EntryType {
  String get label => switch (this) {
        EntryType.feeding => 'Feeding',
        EntryType.diaper => 'Diaper',
        EntryType.sleep => 'Sleep',
      };
}