import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babymom_diary/src/features/ads/application/providers/ad_free_providers.dart';
import 'package:babymom_diary/src/features/ads/infrastructure/repositories/ad_free_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
  });

  ProviderContainer createContainer({bool useFake = true}) {
    final container = ProviderContainer(
      overrides: [
        if (useFake)
          adFreeRepositoryProvider
              .overrideWithValue(const FakeAdFreeRepository())
        else
          adFreeRepositoryProvider.overrideWithValue(
            AdFreeRepositoryImpl(sharedPreferences),
          ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('AdFreeUntil Tests (with FakeAdFreeRepository)', () {
    test('initial state is null', () {
      final container = createContainer(useFake: true);
      expect(container.read(adFreeUntilProvider), isNull);
      expect(container.read(isAdFreeActiveProvider), isFalse);
    });

    test('setting duration updates state', () async {
      final container = createContainer(useFake: true);
      final duration = const Duration(hours: 12);

      final beforeSet = DateTime.now();
      await container
          .read(adFreeUntilProvider.notifier)
          .setAdFreeDuration(duration);
      final afterSet = DateTime.now();

      final until = container.read(adFreeUntilProvider);
      expect(until, isNotNull);

      expect(
        until!.isAfter(beforeSet.add(duration)) ||
            until.isAtSameMomentAs(beforeSet.add(duration)),
        isTrue,
      );
      expect(
        until.isBefore(afterSet.add(duration)) ||
            until.isAtSameMomentAs(afterSet.add(duration)),
        isTrue,
      );
    });
  });

  group('AdFreeUntil Tests (with SharedPreferences / Real Repository)', () {
    test('setting duration updates state and sharedPreferences', () async {
      final container = createContainer(useFake: false);
      final duration = const Duration(hours: 12);

      await container
          .read(adFreeUntilProvider.notifier)
          .setAdFreeDuration(duration);

      final until = container.read(adFreeUntilProvider);
      expect(until, isNotNull);

      // SharedPreferencesに保存されていることを確認
      final savedMs = sharedPreferences.getInt('ad_free_until');
      expect(savedMs, isNotNull);
      expect(savedMs, equals(until!.millisecondsSinceEpoch));
    });

    test('isAdFreeActive is true when limit is in future', () async {
      // 1時間後を期限に設定
      final until = DateTime.now().add(const Duration(hours: 1));
      await sharedPreferences.setInt(
          'ad_free_until', until.millisecondsSinceEpoch);

      final container = createContainer(useFake: false);
      final isActive = container.read(isAdFreeActiveProvider);
      expect(isActive, isTrue);
    });

    test('isAdFreeActive is false when limit is in past', () async {
      // 1時間前を期限に設定
      final until = DateTime.now().subtract(const Duration(hours: 1));
      await sharedPreferences.setInt(
          'ad_free_until', until.millisecondsSinceEpoch);

      final container = createContainer(useFake: false);
      final isActive = container.read(isAdFreeActiveProvider);
      expect(isActive, isFalse);
    });
  });
}
