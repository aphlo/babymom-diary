import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_guideline.dart';
import 'package:babymom_diary/src/features/vaccines/application/vaccine_catalog_providers.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_guideline.dart';

import '../mappers/vaccine_info_mapper.dart';
import 'vaccines_view_data.dart';

final vaccinesViewModelProvider = AutoDisposeStateNotifierProvider<
    VaccinesViewModel, AsyncValue<VaccinesViewData>>((ref) {
  final getGuideline = ref.watch(getVaccineGuidelineProvider);
  final viewModel = VaccinesViewModel(getGuideline: getGuideline);
  viewModel.load();
  return viewModel;
});

class VaccinesViewModel extends StateNotifier<AsyncValue<VaccinesViewData>> {
  VaccinesViewModel({required GetVaccineGuideline getGuideline})
      : _getGuideline = getGuideline,
        super(const AsyncValue.loading());

  final GetVaccineGuideline _getGuideline;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final VaccineGuideline guideline = await _getGuideline();
      state = AsyncValue.data(mapGuidelineToViewData(guideline));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() => load();
}
