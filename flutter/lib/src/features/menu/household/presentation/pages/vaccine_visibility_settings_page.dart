import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/firebase/household_service.dart';
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
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          ),
        );
        viewModel.clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text('ワクチンの表示・非表示'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.vaccines.length + 1,
              itemBuilder: (context, index) {
                // 最初のアイテムは説明文
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '不要なワクチンを非表示にできます。ボタンをオフにして保存ボタンを押してください',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                    ),
                  );
                }

                // インデックスを調整してワクチンリストにアクセス
                final vaccineIndex = index - 1;
                final vaccine = state.vaccines[vaccineIndex];
                final isVisible = state.visibilitySettings[vaccine.id] ?? true;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SwitchListTile(
                    title: Text(
                      vaccine.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: isVisible,
                    onChanged: (_) => viewModel.toggleVisibility(vaccine.id),
                    activeTrackColor: AppColors.primary,
                  ),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: state.isSaving ? null : () => _saveSettings(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: state.isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('保存'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveSettings(BuildContext context) async {
    final householdIdAsync = ref.read(currentHouseholdIdProvider);
    final householdId = householdIdAsync.value;

    if (householdId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('世帯情報が取得できません'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final viewModel =
        ref.read(vaccineVisibilitySettingsViewModelProvider.notifier);
    final success = await viewModel.saveSettings(householdId: householdId);

    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('設定を保存しました'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }
}
