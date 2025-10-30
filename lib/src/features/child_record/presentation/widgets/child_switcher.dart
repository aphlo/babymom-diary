import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../children/data/infrastructure/child_firestore_data_source.dart';
import '../../../children/application/selected_child_provider.dart';

class ChildSwitcher extends ConsumerWidget {
  const ChildSwitcher({super.key});

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.grey;
    final cleaned = hex.replaceFirst('#', '');
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return Colors.grey;
    return Color(0xFF000000 | value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    final selectedId = ref.watch(selectedChildControllerProvider).value;

    return asyncHid.when(
      loading: () => const SizedBox(
          height: 40,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
      error: (e, __) => Text('error: $e'),
      data: (hid) {
        final ds =
            ChildFirestoreDataSource(ref.watch(firebaseFirestoreProvider), hid);
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ds.childrenQuery().snapshots(),
          builder: (context, snap) {
            final items = snap.data?.docs ?? const [];
            return DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                value: items.any((d) => d.id == selectedId) ? selectedId : null,
                hint: const Text('子どもを選択'),
                items: [
                  for (final d in items)
                    DropdownMenuItem(
                      value: d.id,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: _parseColor(d['color'] as String?),
                          ),
                          const SizedBox(width: 8),
                          Text((d['name'] as String?) ?? '未設定'),
                        ],
                      ),
                    ),
                ],
                onChanged: (v) => ref
                    .read(selectedChildControllerProvider.notifier)
                    .select(v),
                icon: const Icon(Icons.expand_more),
              ),
            );
          },
        );
      },
    );
  }
}
