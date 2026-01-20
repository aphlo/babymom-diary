import 'package:freezed_annotation/freezed_annotation.dart';

part 'vaccine_settings.freezed.dart';

enum VaccineViewMode {
  table,
  list,
}

@freezed
sealed class VaccineSettings with _$VaccineSettings {
  const factory VaccineSettings({
    @Default(VaccineViewMode.table) VaccineViewMode viewMode,
  }) = _VaccineSettings;
}
