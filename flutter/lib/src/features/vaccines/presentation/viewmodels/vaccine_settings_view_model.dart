import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_settings.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_settings_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/vaccine_settings_repository_impl.dart';

import 'vaccine_settings_state.dart';

part 'vaccine_settings_view_model.g.dart';

@Riverpod(keepAlive: true)
class VaccineSettingsViewModel extends _$VaccineSettingsViewModel {
  VaccineSettingsRepository? _repository;

  @override
  VaccineSettingsState build() {
    _repository = ref.watch(vaccineSettingsRepositoryProvider);

    final initialState = const VaccineSettingsState(
      settings: VaccineSettings(),
    );

    Future.microtask(() => _loadSettings());

    return initialState;
  }

  Future<void> _loadSettings() async {
    final repository = _repository;
    if (repository == null) return;

    try {
      state = state.copyWith(isLoading: true, error: null);
      final settings = await repository.getSettings();
      state = state.copyWith(
        settings: settings,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '設定の読み込みに失敗しました: $e',
      );
    }
  }

  Future<void> updateViewMode(VaccineViewMode viewMode) async {
    final repository = _repository;
    if (repository == null) return;

    try {
      state = state.copyWith(isLoading: true, error: null);
      final newSettings = state.settings.copyWith(
        viewMode: viewMode,
      );
      await repository.saveSettings(newSettings);
      state = state.copyWith(
        settings: newSettings,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '設定の保存に失敗しました: $e',
      );
    }
  }
}
