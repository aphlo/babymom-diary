import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_management/application/providers/data_management_providers.dart';
import '../../data_management/presentation/widgets/delete_data_confirmation_dialog.dart';
import 'menu_section.dart';

/// メニューのデータ削除セクション
class MenuDeleteDataSection extends ConsumerWidget {
  const MenuDeleteDataSection({
    super.key,
    required this.householdId,
  });

  final String householdId;

  Future<void> _handleDeleteData(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final confirmed = await DeleteDataConfirmationDialog.show(context);
    if (!confirmed) return;

    if (!context.mounted) return;

    // Show loading snackbar instead of dialog to avoid Navigator issues
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Text('データを削除しています...'),
          ],
        ),
        duration: Duration(days: 1), // Will be dismissed manually
      ),
    );

    try {
      // Execute deletion
      final deleteUseCase = ref.read(deleteAllHouseholdDataProvider);
      await deleteUseCase.execute(householdId);

      if (!context.mounted) return;

      // Clear the loading snackbar
      ScaffoldMessenger.of(context).clearSnackBars();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('データを削除しました'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      // Clear the loading snackbar
      ScaffoldMessenger.of(context).clearSnackBars();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('削除に失敗しました: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 24),
        MenuSection(
          children: [
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text(
                'データの削除',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('すべてのデータを削除'),
              onTap: () => _handleDeleteData(context, ref),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
