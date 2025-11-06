import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../menu/children/application/children_local_provider.dart';
import '../../../menu/children/application/children_stream_provider.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../../menu/children/application/selected_child_snapshot_provider.dart';
import '../../../menu/children/domain/entities/child_summary.dart';
import '../viewmodels/record_view_model.dart';

class AppBarChildInfo extends ConsumerWidget {
  const AppBarChildInfo({super.key});

  String _ageString(DateTime birthday, DateTime on) {
    if (on.isBefore(birthday)) return '--';
    int months = (on.year - birthday.year) * 12 + (on.month - birthday.month);
    DateTime anchor =
        DateTime(birthday.year, birthday.month + months, birthday.day);
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
    final selectedDate = ref.watch(recordViewModelProvider).selectedDate;

    return asyncHid.when(
      loading: () => const SizedBox.shrink(),
      error: (e, __) => const SizedBox.shrink(),
      data: (hid) {
        final localChildrenState = ref.watch(childrenLocalProvider(hid));
        final streamChildren = ref.watch(childrenStreamProvider(hid));
        final snapshotState = ref.watch(selectedChildSnapshotProvider(hid));
        final snapshotNotifier =
            ref.read(selectedChildSnapshotProvider(hid).notifier);

        streamChildren.whenData((children) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ref
                .read(childrenLocalProvider(hid).notifier)
                .replaceChildren(children);
          });
        });

        Widget buildWithChildren(List<ChildSummary> children) {
          if (children.isEmpty) {
            return const Text(
              '子ども未登録',
              style: TextStyle(fontSize: 10),
            );
          }
          int index = children.indexWhere((d) => d.id == selectedId);
          if (index < 0) index = 0; // default to first
          final d = children[index];
          final name = d.name;
          final birthday = d.birthday;
          final age = _ageString(birthday, selectedDate);

          final snapshotValue = snapshotState.value;
          final shouldSaveSnapshot =
              snapshotValue == null || !snapshotValue.isSameAs(d);
          if (shouldSaveSnapshot) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              snapshotNotifier.save(d);
            });
          }

          void toNext() {
            if (children.isEmpty) return;
            final next = (index + 1) % children.length;
            ref
                .read(selectedChildControllerProvider.notifier)
                .select(children[next].id);
          }

          return InkWell(
            onTap: toNext,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: Text(
                '$name  $age',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        }

        final localChildren = localChildrenState.value;
        if (localChildren != null && localChildren.isNotEmpty) {
          return buildWithChildren(localChildren);
        }

        final streamValue = streamChildren.value;
        if (streamValue != null && streamValue.isNotEmpty) {
          return buildWithChildren(streamValue);
        }

        final snapshotValue = snapshotState.value;
        if (snapshotValue != null) {
          return buildWithChildren([snapshotValue]);
        }

        final streamEmptyLoaded = streamChildren.maybeWhen(
            data: (value) => value.isEmpty, orElse: () => false);
        final streamHasValue = streamChildren is AsyncData<List<ChildSummary>>;
        final localEmptyLoaded = localChildrenState.maybeWhen(
            data: (value) => value.isEmpty, orElse: () => false);
        final localHasValue =
            localChildrenState is AsyncData<List<ChildSummary>>;

        if (streamHasValue && streamEmptyLoaded) {
          return const Text(
            '子ども未登録',
            style: TextStyle(fontSize: 10),
          );
        }

        if (localHasValue && localEmptyLoaded && !streamChildren.isLoading) {
          return const Text(
            '子ども未登録',
            style: TextStyle(fontSize: 10),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
