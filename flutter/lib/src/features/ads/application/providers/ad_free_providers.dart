import 'dart:async';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/preferences/shared_preferences_provider.dart';
import '../../domain/repositories/ad_free_repository.dart';
import '../../infrastructure/repositories/ad_free_repository_impl.dart';

part 'ad_free_providers.g.dart';

@riverpod
AdFreeRepository adFreeRepository(Ref ref) {
  // テスト環境の場合は FakeAdFreeRepository を返す
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return const FakeAdFreeRepository();
  }

  final prefs = ref.watch(sharedPreferencesProvider);
  return AdFreeRepositoryImpl(prefs);
}

/// 広告非表示期限（DateTime?）を管理するNotifier
@riverpod
class AdFreeUntil extends _$AdFreeUntil {
  @override
  DateTime? build() {
    final repository = ref.watch(adFreeRepositoryProvider);
    final ms = repository.getAdFreeUntil();
    if (ms != null) {
      return DateTime.fromMillisecondsSinceEpoch(ms);
    }
    return null;
  }

  /// 広告非表示期間（Duration）を設定する
  Future<void> setAdFreeDuration(Duration duration) async {
    final repository = ref.read(adFreeRepositoryProvider);
    final until = DateTime.now().add(duration);
    await repository.setAdFreeUntil(until.millisecondsSinceEpoch);
    state = until;
  }

  /// 広告非表示期間をクリアする
  Future<void> clearAdFree() async {
    final repository = ref.read(adFreeRepositoryProvider);
    await repository.clearAdFreeUntil();
    state = null;
  }
}

/// 広告非表示期限までの残り時間をリアルタイムに提供するStreamProvider
/// 1秒ごとに更新され、期限が切れた場合は null を返します
@riverpod
Stream<Duration?> adFreeRemainingTime(Ref ref) async* {
  final adFreeUntil = ref.watch(adFreeUntilProvider);
  if (adFreeUntil == null) {
    yield null;
    return;
  }

  final now = DateTime.now();
  if (now.isAfter(adFreeUntil)) {
    yield null;
    return;
  }

  yield adFreeUntil.difference(now);

  // 1秒周期のStreamで残り時間を更新
  yield* Stream.periodic(const Duration(seconds: 1), (_) {
    final current = DateTime.now();
    if (current.isAfter(adFreeUntil)) {
      return null;
    }
    return adFreeUntil.difference(current);
  });
}

/// 現在、広告非表示期間が有効であるかどうかを判定するProvider
@riverpod
bool isAdFreeActive(Ref ref) {
  final adFreeUntil = ref.watch(adFreeUntilProvider);
  if (adFreeUntil == null) return false;

  final now = DateTime.now();
  if (now.isAfter(adFreeUntil)) return false;

  // 残り時間Streamを監視し、期限が切れたタイミングで再評価されるようにする
  final remainingVal = ref.watch(adFreeRemainingTimeProvider);
  if (remainingVal.hasValue && remainingVal.value == null) {
    return false;
  }

  return true;
}
