import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Currently selected date for the record list (day-based).
/// Defaults to today at 00:00 for stable equality.
final selectedRecordDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});
