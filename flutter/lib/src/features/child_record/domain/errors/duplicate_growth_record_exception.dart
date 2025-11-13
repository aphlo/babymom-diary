enum GrowthRecordType { height, weight }

class DuplicateGrowthRecordException implements Exception {
  const DuplicateGrowthRecordException({
    required this.recordType,
    required this.recordedAt,
  });

  final GrowthRecordType recordType;
  final DateTime recordedAt;

  String get _typeName {
    switch (recordType) {
      case GrowthRecordType.height:
        return '身長';
      case GrowthRecordType.weight:
        return '体重';
    }
  }

  String get message {
    final dateStr = '${recordedAt.year}年${recordedAt.month}月${recordedAt.day}日';
    return '${dateStr}には既に${_typeName}の記録があります。\n同じ日付に複数の記録を保存することはできません。';
  }

  @override
  String toString() => 'DuplicateGrowthRecordException: $message';
}
