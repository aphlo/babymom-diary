import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_settings.dart';

part 'vaccine_settings_state.freezed.dart';

@freezed
sealed class VaccineSettingsState with _$VaccineSettingsState {
  const factory VaccineSettingsState({
    required VaccineSettings settings,
    @Default(false) bool isLoading,
    String? error,
  }) = _VaccineSettingsState;
}
