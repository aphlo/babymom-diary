import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../child_record/presentation/providers/child_record_providers.dart';
import '../../domain/entities/widget_settings.dart';
import '../../domain/repositories/widget_data_repository.dart';
import '../../infrastructure/repositories/widget_data_repository_impl.dart';
import '../../infrastructure/services/widget_data_sync_service.dart';

part 'widget_providers.g.dart';

/// SharedPreferencesプロバイダー（アプリ起動時に初期化が必要）
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferencesが初期化されていません');
});

/// WidgetDataRepositoryプロバイダー
@Riverpod(keepAlive: true)
WidgetDataRepository widgetDataRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return WidgetDataRepositoryImpl(prefs);
}

/// WidgetDataSyncServiceプロバイダー（householdIdごと）
@riverpod
WidgetDataSyncService widgetDataSyncService(Ref ref, String householdId) {
  final widgetRepo = ref.watch(widgetDataRepositoryProvider);
  final recordRepo = ref.watch(childRecordRepositoryProvider(householdId));
  return WidgetDataSyncService(
    widgetRepository: widgetRepo,
    recordRepository: recordRepo,
  );
}

/// ウィジェット設定プロバイダー
@riverpod
class WidgetSettingsNotifier extends _$WidgetSettingsNotifier {
  @override
  Future<WidgetSettings> build() async {
    final repo = ref.watch(widgetDataRepositoryProvider);
    return repo.getWidgetSettings();
  }

  Future<void> updateMediumWidgetSettings(MediumWidgetSettings settings) async {
    final repo = ref.read(widgetDataRepositoryProvider);
    final current = await repo.getWidgetSettings();
    final updated = current.copyWith(mediumWidget: settings);
    await repo.saveWidgetSettings(updated);
    ref.invalidateSelf();
  }

  Future<void> updateSmallWidgetSettings(SmallWidgetSettings settings) async {
    final repo = ref.read(widgetDataRepositoryProvider);
    final current = await repo.getWidgetSettings();
    final updated = current.copyWith(smallWidget: settings);
    await repo.saveWidgetSettings(updated);
    ref.invalidateSelf();
  }
}
