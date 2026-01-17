import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_settings.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/vaccine_settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/child_record/presentation/widgets/app_bar_child_info.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/children_stream_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';

import '../../domain/entities/dose_record.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../components/vaccines_list_view.dart';
import '../components/vaccines_schedule_table.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../models/vaccines_view_data.dart';
import '../viewmodels/vaccines_view_model.dart';
import '../widgets/vaccines_legend.dart';
import 'vaccine_detail_page.dart';

class VaccinesPage extends ConsumerStatefulWidget {
  const VaccinesPage({super.key});

  @override
  ConsumerState<VaccinesPage> createState() => _VaccinesPageState();
}

class _VaccinesPageState extends ConsumerState<VaccinesPage> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<VaccinesViewData> state =
        ref.watch(vaccinesViewModelProvider);
    final settingsState = ref.watch(vaccineSettingsViewModelProvider);
    final viewMode = settingsState.settings.viewMode;
    final DateTime? childBirthday = _resolveSelectedChildBirthday(ref);

    return Scaffold(
      appBar: AppBar(
        // 予防接種画面では常に現在の年齢を表示（日付選択の影響を受けない）
        title: AppBarChildInfo(referenceDate: DateTime.now()),
        actions: [
          IconButton(
            icon: Icon(
              viewMode == VaccineViewMode.table
                  ? Icons.view_list
                  : Icons.view_timeline_outlined,
            ),
            tooltip: viewMode == VaccineViewMode.table ? 'リスト表示' : '表形式表示',
            onPressed: () {
              final newMode = viewMode == VaccineViewMode.table
                  ? VaccineViewMode.list
                  : VaccineViewMode.table;
              ref
                  .read(vaccineSettingsViewModelProvider.notifier)
                  .updateViewMode(newMode);
            },
          ),
        ],
      ),
      body: state.when(
        data: (data) => _VaccinesContent(
          data: data,
          viewMode: viewMode,
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
          onDoseReservationTap: (vaccine, doseNumber) {
            context.push('/vaccines/reservation', extra: {
              'vaccine': vaccine,
              'doseNumber': doseNumber,
            });
          },
          onScheduledDoseTap: (vaccine, doseNumber, statusInfo) {
            if (statusInfo.status == DoseStatus.completed) {
              context.push('/vaccines/scheduled-details', extra: {
                'vaccine': vaccine,
                'doseNumber': doseNumber,
                'statusInfo': statusInfo,
              });
            } else {
              // 予約済みの場合は詳細ページに遷移してそこで処理
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => VaccineDetailPage(
                    vaccine: vaccine,
                    childBirthday: childBirthday,
                  ),
                ),
              );
            }
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _VaccinesErrorView(
          onRetry: () => ref.read(vaccinesViewModelProvider.notifier).refresh(),
        ),
      ),
    );
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
}

class _VaccinesContent extends StatelessWidget {
  const _VaccinesContent({
    required this.data,
    required this.viewMode,
    required this.childBirthday,
    required this.onVaccineTap,
    this.onDoseReservationTap,
    this.onScheduledDoseTap,
  });

  final VaccinesViewData data;
  final VaccineViewMode viewMode;
  final DateTime? childBirthday;
  final ValueChanged<VaccineInfo> onVaccineTap;
  final void Function(VaccineInfo vaccine, int doseNumber)?
      onDoseReservationTap;
  final void Function(
          VaccineInfo vaccine, int doseNumber, DoseStatusInfo statusInfo)?
      onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: viewMode == VaccineViewMode.table
              ? VaccinesScheduleTable(
                  periods: data.periodLabels,
                  vaccines: data.vaccines,
                  childBirthday: childBirthday,
                  onVaccineTap: onVaccineTap,
                )
              : VaccinesListView(
                  vaccines: data.vaccines,
                  recordsByVaccine: data.recordsByVaccine,
                  onVaccineTap: onVaccineTap,
                  onDoseReservationTap: onDoseReservationTap,
                  onScheduledDoseTap: onScheduledDoseTap,
                ),
        ),
        if (viewMode == VaccineViewMode.table) const VaccinesLegend(),
        const BannerAdWidget(slot: BannerAdSlot.vaccines),
      ],
    );
  }
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
