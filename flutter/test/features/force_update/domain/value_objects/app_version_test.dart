import 'package:babymom_diary/src/features/force_update/domain/value_objects/app_version.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppVersion.parse', () {
    test('正常なバージョン文字列をパースできる', () {
      final version = AppVersion.parse('1.2.3');
      expect(version.major, 1);
      expect(version.minor, 2);
      expect(version.patch, 3);
    });

    test('minor, patchが省略された場合は0になる', () {
      final versionMajorOnly = AppVersion.parse('2');
      expect(versionMajorOnly.major, 2);
      expect(versionMajorOnly.minor, 0);
      expect(versionMajorOnly.patch, 0);

      final versionMajorMinor = AppVersion.parse('3.4');
      expect(versionMajorMinor.major, 3);
      expect(versionMajorMinor.minor, 4);
      expect(versionMajorMinor.patch, 0);
    });

    test('空文字列の場合はFormatExceptionをスローする', () {
      expect(
        () => AppVersion.parse(''),
        throwsA(isA<FormatException>()),
      );
    });

    test('不正な形式の場合はFormatExceptionをスローする', () {
      expect(
        () => AppVersion.parse('1.2.3.4'),
        throwsA(isA<FormatException>()),
      );
    });

    test('数値以外を含む場合はFormatExceptionをスローする', () {
      expect(
        () => AppVersion.parse('1.2.x'),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => AppVersion.parse('abc'),
        throwsA(isA<FormatException>()),
      );
    });

    test('負の数を含む場合はFormatExceptionをスローする', () {
      expect(
        () => AppVersion.parse('-1.0.0'),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('AppVersion comparison', () {
    test('majorバージョンで比較できる', () {
      final v1 = AppVersion.parse('1.0.0');
      final v2 = AppVersion.parse('2.0.0');
      expect(v1 < v2, isTrue);
      expect(v2 > v1, isTrue);
    });

    test('minorバージョンで比較できる', () {
      final v1 = AppVersion.parse('1.1.0');
      final v2 = AppVersion.parse('1.2.0');
      expect(v1 < v2, isTrue);
    });

    test('patchバージョンで比較できる', () {
      final v1 = AppVersion.parse('1.0.1');
      final v2 = AppVersion.parse('1.0.2');
      expect(v1 < v2, isTrue);
    });

    test('同じバージョンは等しい', () {
      final v1 = AppVersion.parse('1.2.3');
      final v2 = AppVersion.parse('1.2.3');
      expect(v1 == v2, isTrue);
      expect(v1 <= v2, isTrue);
      expect(v1 >= v2, isTrue);
    });

    test('compareToが正しく動作する', () {
      final v1 = AppVersion.parse('1.0.0');
      final v2 = AppVersion.parse('2.0.0');
      final v3 = AppVersion.parse('1.0.0');

      expect(v1.compareTo(v2), lessThan(0));
      expect(v2.compareTo(v1), greaterThan(0));
      expect(v1.compareTo(v3), equals(0));
    });
  });

  group('AppVersion.toString', () {
    test('バージョン文字列に変換できる', () {
      final version = AppVersion(major: 1, minor: 2, patch: 3);
      expect(version.toString(), '1.2.3');
    });
  });

  group('AppVersion equality', () {
    test('同じ値のインスタンスは等しい', () {
      final v1 = AppVersion(major: 1, minor: 2, patch: 3);
      final v2 = AppVersion(major: 1, minor: 2, patch: 3);
      expect(v1, equals(v2));
      expect(v1.hashCode, equals(v2.hashCode));
    });

    test('異なる値のインスタンスは等しくない', () {
      final v1 = AppVersion(major: 1, minor: 2, patch: 3);
      final v2 = AppVersion(major: 1, minor: 2, patch: 4);
      expect(v1, isNot(equals(v2)));
    });
  });
}
