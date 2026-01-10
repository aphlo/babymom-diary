import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/preferences/shared_preferences_provider.dart';
import '../../../baby_food/presentation/providers/baby_food_providers.dart';
import '../../../child_record/presentation/providers/child_record_providers.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../../domain/entities/widget_settings.dart';
import '../../domain/repositories/widget_data_repository.dart';
import '../../infrastructure/repositories/widget_data_repository_impl.dart';
import '../../infrastructure/services/widget_data_sync_service.dart';

part 'widget_providers.g.dart';

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
  final babyFoodRepo = ref.watch(babyFoodRecordRepositoryProvider(householdId));
  return WidgetDataSyncService(
    widgetRepository: widgetRepo,
    recordRepository: recordRepo,
    babyFoodRepository: babyFoodRepo,
  );
}

/// ウィジェット設定プロバイダー
@Riverpod(keepAlive: true)
class WidgetSettingsNotifier extends _$WidgetSettingsNotifier {
  @override
  Future<WidgetSettings> build() async {
    final repo = ref.watch(widgetDataRepositoryProvider);
    return repo.getWidgetSettings();
  }

  Future<void> updateMediumWidgetSettings(MediumWidgetSettings settings) async {
    final repo = ref.read(widgetDataRepositoryProvider);
    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => await repo.getWidgetSettings(),
    };
    final updated = current.copyWith(mediumWidget: settings);
    await repo.saveWidgetSettings(updated);
    state = AsyncData(updated);
  }

  Future<void> updateSmallWidgetSettings(SmallWidgetSettings settings) async {
    final repo = ref.read(widgetDataRepositoryProvider);
    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => await repo.getWidgetSettings(),
    };
    final updated = current.copyWith(smallWidget: settings);
    await repo.saveWidgetSettings(updated);
    state = AsyncData(updated);
  }
}

/// ウィジェットデータ自動同期プロバイダー
///
/// ChildContextの変更を監視し、自動的にウィジェットデータを同期します。
/// アプリのルートウィジェットでwatchすることで、アプリ起動時から監視を開始します。
@Riverpod(keepAlive: true)
class WidgetAutoSync extends _$WidgetAutoSync {
  String? _lastSyncedHouseholdId;
  String? _lastSyncedChildId;
  int _lastSyncedChildrenCount = -1;

  @override
  Future<void> build() async {
    // ChildContextを監視
    ref.listen<AsyncValue<ChildContext>>(
      childContextProvider,
      (previous, next) {
        next.whenData((context) {
          _syncIfNeeded(context);
        });
      },
      fireImmediately: true,
    );
  }

  Future<void> _syncIfNeeded(ChildContext context) async {
    // 初回または変更があった場合のみ同期
    final needsSync = _lastSyncedHouseholdId != context.householdId ||
        _lastSyncedChildId != context.selectedChildId ||
        _lastSyncedChildrenCount != context.children.length;

    if (!needsSync) return;

    _lastSyncedHouseholdId = context.householdId;
    _lastSyncedChildId = context.selectedChildId;
    _lastSyncedChildrenCount = context.children.length;

    try {
      final syncService =
          ref.read(widgetDataSyncServiceProvider(context.householdId));
      await syncService.syncAllData(
        householdId: context.householdId,
        children: context.children,
        selectedChildId: context.selectedChildId,
      );
    } catch (e) {
      // ウィジェット同期の失敗はサイレントに処理（アプリの動作に影響を与えない）
    }
  }

  /// 手動で同期を実行
  Future<void> syncNow() async {
    final contextAsync = ref.read(childContextProvider);
    final context = contextAsync.value;
    if (context == null) return;

    _lastSyncedHouseholdId = null; // 強制的に同期を実行
    await _syncIfNeeded(context);
  }
}
