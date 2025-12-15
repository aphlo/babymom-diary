import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/core/deeplink/deep_link_service.dart';

void main() {
  group('UriDeduplicator', () {
    test('ignores duplicate within window', () {
      final dedup = UriDeduplicator();
      final now = DateTime(2024, 1, 1, 12, 0, 0);

      expect(
          dedup.shouldHandle(
              'milu://record/add?type=pee', now, const Duration(seconds: 2)),
          isTrue);
      expect(
        dedup.shouldHandle(
            'milu://record/add?type=pee',
            now.add(const Duration(milliseconds: 500)),
            const Duration(seconds: 2)),
        isFalse,
      );
    });

    test('allows duplicate after window', () {
      final dedup = UriDeduplicator();
      final now = DateTime(2024, 1, 1, 12, 0, 0);

      expect(
          dedup.shouldHandle(
              'milu://record/add?type=pee', now, const Duration(seconds: 2)),
          isTrue);
      expect(
        dedup.shouldHandle('milu://record/add?type=pee',
            now.add(const Duration(seconds: 3)), const Duration(seconds: 2)),
        isTrue,
      );
    });

    test('allows different URIs regardless of timing', () {
      final dedup = UriDeduplicator();
      final now = DateTime(2024, 1, 1, 12, 0, 0);

      expect(
          dedup.shouldHandle(
              'milu://record/add?type=pee', now, const Duration(seconds: 2)),
          isTrue);
      expect(
        dedup.shouldHandle(
            'milu://record/add?type=poop',
            now.add(const Duration(milliseconds: 500)),
            const Duration(seconds: 2)),
        isTrue,
      );
    });
  });
}
