import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/child_record/presentation/widgets/app_bar_child_info.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_stream_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';

import '../components/vaccines_schedule_table.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccines_view_data.dart';
import '../viewmodels/vaccines_view_model.dart';
import '../widgets/vaccines_legend.dart';
import 'vaccine_detail_page.dart';

class VaccinesPage extends ConsumerWidget {
  const VaccinesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<VaccinesViewData> state =
        ref.watch(vaccinesViewModelProvider);
    final DateTime? childBirthday = _resolveSelectedChildBirthday(ref);

    return Scaffold(
      appBar: AppBar(title: const AppBarChildInfo()),
      body: state.when(
        data: (data) => _VaccinesContent(
          data: data,
          childBirthday: childBirthday,
          onVaccineTap: (vaccine) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => VaccineDetailPage(
                  vaccine: vaccine,
                  childBirthday: childBirthday,
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _VaccinesErrorView(
          onRetry: () => ref.read(vaccinesViewModelProvider.notifier).refresh(),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _VaccinesContent extends StatelessWidget {
  const _VaccinesContent({
    required this.data,
    required this.childBirthday,
    required this.onVaccineTap,
  });

  final VaccinesViewData data;
  final DateTime? childBirthday;
  final ValueChanged<VaccineInfo> onVaccineTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: VaccinesScheduleTable(
            periods: data.periodLabels,
            vaccines: data.vaccines,
            childBirthday: childBirthday,
            onVaccineTap: onVaccineTap,
          ),
        ),
        const VaccinesLegend(),
      ],
    );
  }
}

DateTime? _resolveSelectedChildBirthday(WidgetRef ref) {
  final AsyncValue<String> householdIdAsync =
      ref.watch(currentHouseholdIdProvider);

  return householdIdAsync.maybeWhen<DateTime?>(
    data: (householdId) {
      final AsyncValue<String?> selectedIdAsync =
          ref.watch(selectedChildControllerProvider);
      final String? selectedId = selectedIdAsync.value;
      if (selectedId == null) {
        return null;
      }

      final AsyncValue<List<ChildSummary>> localChildren =
          ref.watch(childrenLocalProvider(householdId));
      final AsyncValue<List<ChildSummary>> streamChildren =
          ref.watch(childrenStreamProvider(householdId));
      final AsyncValue<ChildSummary?> snapshotChild =
          ref.watch(selectedChildSnapshotProvider(householdId));

      ChildSummary? child;
      final List<ChildSummary>? local = localChildren.value;
      if (local != null && local.isNotEmpty) {
        child = _findChildById(local, selectedId);
      }
      if (child == null) {
        final List<ChildSummary>? streamed = streamChildren.value;
        if (streamed != null && streamed.isNotEmpty) {
          child = _findChildById(streamed, selectedId);
        }
      }
      if (child == null) {
        final ChildSummary? snapshot = snapshotChild.value;
        if (snapshot != null && snapshot.id == selectedId) {
          child = snapshot;
        }
      }

      return child?.birthday;
    },
    orElse: () => null,
  );
}

ChildSummary? _findChildById(List<ChildSummary> source, String id) {
  for (final ChildSummary child in source) {
    if (child.id == id) {
      return child;
    }
  }
  return null;
}

class _VaccinesErrorView extends StatelessWidget {
  const _VaccinesErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ワクチン情報の読み込みに失敗しました',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('再試行'),
          ),
        ],
      ),
    );
  }
}
