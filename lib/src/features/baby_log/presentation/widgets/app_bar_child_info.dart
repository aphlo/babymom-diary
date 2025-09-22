import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../children/data/sources/child_firestore_data_source.dart';
import '../../../children/application/selected_child_provider.dart';
import '../controllers/selected_log_date_provider.dart';

class AppBarChildInfo extends ConsumerWidget {
  const AppBarChildInfo({super.key});

  String _ageString(DateTime birthday, DateTime on) {
    if (on.isBefore(birthday)) return '--';
    int months = (on.year - birthday.year) * 12 + (on.month - birthday.month);
    DateTime anchor = DateTime(birthday.year, birthday.month + months, birthday.day);
    if (on.isBefore(anchor)) {
      months -= 1;
      anchor = DateTime(birthday.year, birthday.month + months, birthday.day);
    }
    final days = on.difference(anchor).inDays;
    return '$monthsか月$days日目';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    final selectedId = ref.watch(selectedChildControllerProvider).value;
    final selectedDate = ref.watch(selectedLogDateProvider);

    return asyncHid.when(
      loading: () => const SizedBox.shrink(),
      error: (e, __) => const SizedBox.shrink(),
      data: (hid) {
        final ds = ChildFirestoreDataSource(ref.watch(firebaseFirestoreProvider), hid);
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ds.childrenQuery().snapshots(),
          builder: (context, snap) {
            final children = snap.data?.docs ?? const [];
            if (children.isEmpty) {
              return const Text('子ども未登録');
            }
            int index = children.indexWhere((d) => d.id == selectedId);
            if (index < 0) index = 0; // default to first
            final d = children[index];
            final name = (d['name'] as String?) ?? '未設定';
            final birthdayTs = d['birthday'] as Timestamp?;
            final birthday = birthdayTs?.toDate();
            final age = birthday == null ? '' : _ageString(birthday, selectedDate);

            void toNext() {
              if (children.isEmpty) return;
              final next = (index + 1) % children.length;
              ref.read(selectedChildControllerProvider.notifier).select(children[next].id);
            }

            return InkWell(
              onTap: toNext,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text('$name  $age',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12)),
              ),
            );
          },
        );
      },
    );
  }
}
