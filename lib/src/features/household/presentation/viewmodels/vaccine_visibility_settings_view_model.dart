import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/usecases/get_vaccine_visibility_settings.dart';
import '../../application/usecases/update_vaccine_visibility_settings.dart';
import '../../application/usecases/remove_vaccine_from_reservation_groups.dart';
import '../../domain/entities/vaccine_visibility_settings.dart';
import '../../../vaccines/domain/repositories/vaccine_master_repository.dart';
import 'vaccine_visibility_settings_state.dart';

/// ワクチン表示設定画面のViewModel
class VaccineVisibilitySettingsViewModel
    extends StateNotifier<VaccineVisibilitySettingsState> {
  VaccineVisibilitySettingsViewModel({
    required GetVaccineVisibilitySettings getVaccineVisibilitySettings,
    required UpdateVaccineVisibilitySettings updateVaccineVisibilitySettings,
    required RemoveVaccineFromReservationGroups
        removeVaccineFromReservationGroups,
    required VaccineMasterRepository vaccineMasterRepository,
  })  : _getVaccineVisibilitySettings = getVaccineVisibilitySettings,
        _updateVaccineVisibilitySettings = updateVaccineVisibilitySettings,
        _removeVaccineFromReservationGroups =
            removeVaccineFromReservationGroups,
        _vaccineMasterRepository = vaccineMasterRepository,
        super(const VaccineVisibilitySettingsState());

  final GetVaccineVisibilitySettings _getVaccineVisibilitySettings;
  final UpdateVaccineVisibilitySettings _updateVaccineVisibilitySettings;
  final RemoveVaccineFromReservationGroups _removeVaccineFromReservationGroups;
  final VaccineMasterRepository _vaccineMasterRepository;

  /// 初期化
  Future<void> initialize({
    required String householdId,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // 全てのワクチンマスターデータを取得
      final allVaccines = await _vaccineMasterRepository.getAllVaccines();

      // 現在の表示設定を取得
      final settings = await _getVaccineVisibilitySettings(
        householdId: householdId,
      );

      // ワクチン表示情報リストを作成
      final vaccineInfos = allVaccines
          .map((vaccine) => VaccineDisplayInfo(
                id: vaccine.id,
                name: vaccine.name,
              ))
          .toList();

      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        visibilitySettings: settings.visibilityMap,
        vaccines: vaccineInfos,
      );
    } catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: 'データの取得に失敗しました: $error',
      );
    }
  }

  /// ワクチンの表示・非表示を切り替え
  void toggleVisibility(String vaccineId) {
    final currentVisibility = state.visibilitySettings[vaccineId] ?? true;
    final newVisibility = !currentVisibility;

    final updatedSettings = Map<String, bool>.from(state.visibilitySettings);
    updatedSettings[vaccineId] = newVisibility;

    state = state.copyWith(visibilitySettings: updatedSettings);
  }

  /// 設定を保存
  Future<bool> saveSettings({
    required String householdId,
  }) async {
    state = state.copyWith(isSaving: true, clearError: true);

    try {
      // 設定を更新
      final settings = VaccineVisibilitySettings(
        householdId: householdId,
        visibilityMap: state.visibilitySettings,
      );

      await _updateVaccineVisibilitySettings(settings: settings);

      // OFFに設定されたワクチンをreservation_groupsから削除
      final hiddenVaccineIds = settings.hiddenVaccineIds;
      for (final vaccineId in hiddenVaccineIds) {
        try {
          await _removeVaccineFromReservationGroups(
            householdId: householdId,
            vaccineId: vaccineId,
          );
        } catch (e) {
          // エラーが発生してもログに記録して続行
          // ignore: avoid_print
          print(
              'Failed to remove vaccine $vaccineId from reservation groups: $e');
        }
      }

      if (!mounted) return false;
      state = state.copyWith(isSaving: false);
      return true;
    } catch (error) {
      if (!mounted) return false;
      state = state.copyWith(
        isSaving: false,
        error: '設定の保存に失敗しました: $error',
      );
      return false;
    }
  }

  /// エラーをクリア
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}
