import 'package:babymom_diary/src/core/types/child_icon.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChildIcon', () {
    group('ラウンドトリップ', () {
      test('すべてのenumのキーからenumへの変換が正しく動作する', () {
        for (final icon in ChildIcon.values) {
          expect(
            childIconFromKey(icon.key),
            icon,
            reason: '${icon.name} のラウンドトリップが失敗',
          );
        }
      });
    });

    group('キー値のスナップショット', () {
      test('各enumのキーが期待通りの文字列である', () {
        expect(ChildIcon.bear.key, 'bear');
        expect(ChildIcon.cat.key, 'cat');
        expect(ChildIcon.dog.key, 'dog');
        expect(ChildIcon.rabbit.key, 'rabbit');
        expect(ChildIcon.snowman.key, 'snowman');
      });

      test('すべてのenumにキーが定義されている', () {
        for (final icon in ChildIcon.values) {
          expect(icon.key, isNotEmpty, reason: '${icon.name} のキーが空');
        }
      });
    });

    group('フォールバック動作', () {
      test('nullの場合はbearにフォールバックする', () {
        expect(childIconFromKey(null), ChildIcon.bear);
      });

      test('空文字の場合はbearにフォールバックする', () {
        expect(childIconFromKey(''), ChildIcon.bear);
      });

      test('不明なキーの場合はbearにフォールバックする', () {
        expect(childIconFromKey('unknown'), ChildIcon.bear);
        expect(childIconFromKey('invalid_icon'), ChildIcon.bear);
        expect(childIconFromKey('BEAR'), ChildIcon.bear); // 大文字小文字
      });
    });

    group('assetPath', () {
      test('すべてのenumに正しいアセットパスが定義されている', () {
        for (final icon in ChildIcon.values) {
          expect(
            icon.assetPath,
            'assets/icons/animals/${icon.key}_normal.png',
            reason: '${icon.name} のアセットパスが不正',
          );
        }
      });
    });

    group('labelJa', () {
      test('各enumに日本語ラベルが定義されている', () {
        expect(ChildIcon.bear.labelJa, 'くま');
        expect(ChildIcon.cat.labelJa, 'ねこ');
        expect(ChildIcon.dog.labelJa, 'いぬ');
        expect(ChildIcon.rabbit.labelJa, 'うさぎ');
        expect(ChildIcon.snowman.labelJa, 'ゆきだるま');
      });

      test('すべてのenumにラベルが定義されている', () {
        for (final icon in ChildIcon.values) {
          expect(icon.labelJa, isNotEmpty, reason: '${icon.name} のラベルが空');
        }
      });
    });
  });
}
