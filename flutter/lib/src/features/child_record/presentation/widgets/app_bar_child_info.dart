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
  /// 年齢計算の基準日。
  ///
  /// 画面ごとに異なる基準日で年齢を表示するために使用:
  /// - null（デフォルト）: ベビーの記録画面で使用。選択された日付（selectedDate）を基準に年齢を表示
  /// - DateTime.now(): 予防接種画面で使用。常に現在日付を基準に年齢を表示
  final DateTime? referenceDate;

  const AppBarChildInfo({super.key, this.referenceDate});

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
    final years = months ~/ 12;
    if (years > 0) {
      final remainingMonths = months % 12;
      return '$years才$remainingMonthsヶ月';
    }
    return '$monthsか月$days日目';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    final selectedId = ref.watch(selectedChildControllerProvider).value;
    final selectedDate =
        referenceDate ?? ref.watch(recordViewModelProvider).selectedDate;

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
            // 子どもリストが空になった場合、スナップショットもクリアする
            if (children.isEmpty) {
              snapshotNotifier.save(null);
            }
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
            if (children.isEmpty || children.length <= 1) return;
            final next = (index + 1) % children.length;
            ref
                .read(selectedChildControllerProvider.notifier)
                .select(children[next].id);
          }

          // 複数子供がいる場合のみタップ可能
          final canTap = children.length > 1;

          return InkWell(
            onTap: canTap ? toNext : null,
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

        // ストリームでデータを受信済みの場合、それを優先（空リストも含む）
        final streamValue = streamChildren.value;
        if (streamValue != null) {
          return buildWithChildren(streamValue);
        }

        // ストリームがまだロード中の場合、ローカルキャッシュを使用
        final localChildren = localChildrenState.value;
        if (localChildren != null && localChildren.isNotEmpty) {
          return buildWithChildren(localChildren);
        }

        // ローカルキャッシュも空の場合、スナップショットを使用
        final snapshotValue = snapshotState.value;
        if (snapshotValue != null) {
          return buildWithChildren([snapshotValue]);
        }

        // ローカルキャッシュが空リストをロード済みの場合
        final localEmptyLoaded = localChildrenState.maybeWhen(
            data: (value) => value.isEmpty, orElse: () => false);
        if (localEmptyLoaded) {
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
