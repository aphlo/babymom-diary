import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../../../core/firebase/household_service.dart';
import '../../../../ads/application/services/banner_ad_manager.dart';
import '../../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../viewmodels/vaccine_visibility_settings_view_model.dart';

/// ワクチン表示設定画面
class VaccineVisibilitySettingsPage extends ConsumerStatefulWidget {
  const VaccineVisibilitySettingsPage({super.key});

  @override
  ConsumerState<VaccineVisibilitySettingsPage> createState() =>
      _VaccineVisibilitySettingsPageState();
}

class _VaccineVisibilitySettingsPageState
    extends ConsumerState<VaccineVisibilitySettingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final householdIdAsync = ref.read(currentHouseholdIdProvider);
    householdIdAsync.when(
      data: (householdId) {
        ref
            .read(vaccineVisibilitySettingsViewModelProvider.notifier)
            .initialize(householdId: householdId);
      },
      loading: () {},
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('世帯情報の取得に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vaccineVisibilitySettingsViewModelProvider);
    final viewModel =
        ref.read(vaccineVisibilitySettingsViewModelProvider.notifier);

    // エラー表示
    ref.listen(vaccineVisibilitySettingsViewModelProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            behavior: SnackBarBehavior.floating,
          ),
        );
        viewModel.clearError();
      }
    });

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: const Text('ワクチンの表示・非表示'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.vaccines.length + 1,
                    itemBuilder: (context, index) {
                      // 最初のアイテムは説明文
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            '不要なワクチンを非表示にできます。',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: context.textSecondary,
                                ),
                          ),
                        );
                      }

                      // インデックスを調整してワクチンリストにアクセス
                      final vaccineIndex = index - 1;
                      final vaccine = state.vaccines[vaccineIndex];
                      final isVisible =
                          state.visibilitySettings[vaccine.id] ?? true;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        color: context.cardBackground,
                        child: SwitchListTile(
                          title: Text(
                            vaccine.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          value: isVisible,
                          onChanged: (_) =>
                              viewModel.toggleVisibility(vaccine.id),
                          activeTrackColor: context.primaryColor,
                        ),
                      );
                    },
                  ),
                ),
                const BannerAdWidget(
                    slot: BannerAdSlot.vaccineVisibilitySettings),
              ],
            ),
    );
  }
}
