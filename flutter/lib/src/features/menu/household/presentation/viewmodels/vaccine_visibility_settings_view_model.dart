import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../../../vaccines/application/vaccine_catalog_providers.dart';
import '../../application/usecases/get_vaccine_visibility_settings.dart';
import '../../application/usecases/update_vaccine_visibility_settings.dart';
import '../../application/usecases/remove_vaccine_from_reservation_groups.dart';
import '../../application/vaccine_visibility_settings_provider.dart';
import '../../domain/entities/vaccine_visibility_settings.dart';
import 'vaccine_visibility_settings_state.dart';

part 'vaccine_visibility_settings_view_model.g.dart';

/// ワクチン表示設定画面のViewModel
@riverpod
class VaccineVisibilitySettingsViewModel
    extends _$VaccineVisibilitySettingsViewModel {
  String? _householdId;

  @override
  VaccineVisibilitySettingsState build() {
    return const VaccineVisibilitySettingsState();
  }

  /// 初期化
  Future<void> initialize({
    required String householdId,
  }) async {
    _householdId = householdId;
    state = state.clearError().copyWith(isLoading: true);

    try {
      final repository = ref.read(vaccineVisibilitySettingsRepositoryProvider);
      final vaccineMasterRepository = ref.read(vaccineMasterRepositoryProvider);

      final getVaccineVisibilitySettings =
          GetVaccineVisibilitySettings(repository: repository);

      // 全てのワクチンマスターデータを取得
      final allVaccines = await vaccineMasterRepository.getAllVaccines();

      // 現在の表示設定を取得
      final settings = await getVaccineVisibilitySettings(
        householdId: householdId,
      );

      // ワクチン表示情報リストを作成
      final vaccineInfos = allVaccines
          .map((vaccine) => VaccineDisplayInfo(
                id: vaccine.id,
                name: vaccine.name,
              ))
          .toList();

      state = state.copyWith(
        isLoading: false,
        visibilitySettings: settings.visibilityMap,
        vaccines: vaccineInfos,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: 'データの取得に失敗しました: $error',
      );
    }
  }

  /// ワクチンの表示・非表示を切り替え（即時保存）
  Future<void> toggleVisibility(String vaccineId) async {
    final householdId = _householdId;
    if (householdId == null) return;

    final currentVisibility = state.visibilitySettings[vaccineId] ?? true;
    final newVisibility = !currentVisibility;

    final updatedSettings = Map<String, bool>.from(state.visibilitySettings);
    updatedSettings[vaccineId] = newVisibility;

    // 即座にUIを更新
    state = state.copyWith(visibilitySettings: updatedSettings);

    // バックグラウンドで保存
    await _saveSettings(householdId, updatedSettings, vaccineId, newVisibility);
  }

  /// 設定を保存（内部メソッド）
  Future<void> _saveSettings(
    String householdId,
    Map<String, bool> visibilitySettings,
    String changedVaccineId,
    bool isVisible,
  ) async {
    try {
      final repository = ref.read(vaccineVisibilitySettingsRepositoryProvider);

      final updateVaccineVisibilitySettings =
          UpdateVaccineVisibilitySettings(repository: repository);

      // 設定を更新
      final settings = VaccineVisibilitySettings(
        householdId: householdId,
        visibilityMap: visibilitySettings,
      );

      await updateVaccineVisibilitySettings(settings: settings);

      // OFFに設定された場合のみreservation_groupsから削除
      if (!isVisible) {
        await _removeFromReservationGroups(householdId, changedVaccineId);
      }
    } catch (error) {
      state = state.copyWith(
        error: '設定の保存に失敗しました',
      );
    }
  }

  /// reservation_groupsから削除
  Future<void> _removeFromReservationGroups(
    String householdId,
    String vaccineId,
  ) async {
    try {
      final firestore = ref.read(firebaseFirestoreProvider);
      final vaccinationRecordRepository =
          ref.read(vaccinationRecordRepositoryProvider);

      final removeVaccineFromReservationGroups =
          RemoveVaccineFromReservationGroups(
        firestore: firestore,
        vaccinationRecordRepository: vaccinationRecordRepository,
      );

      await removeVaccineFromReservationGroups(
        householdId: householdId,
        vaccineId: vaccineId,
      );
    } catch (e) {
      // エラーが発生してもログに記録して続行
      // ignore: avoid_print
      print('Failed to remove vaccine $vaccineId from reservation groups: $e');
    }
  }

  /// エラーをクリア
  void clearError() {
    state = state.clearError();
  }
}
