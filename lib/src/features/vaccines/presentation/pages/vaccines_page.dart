import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/child_record/presentation/widgets/app_bar_child_info.dart';

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

    return Scaffold(
      appBar: AppBar(title: const AppBarChildInfo()),
      body: state.when(
        data: (data) => _VaccinesContent(
          data: data,
          onVaccineTap: (vaccine) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => VaccineDetailPage(vaccine: vaccine),
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
    required this.onVaccineTap,
  });

  final VaccinesViewData data;
  final ValueChanged<VaccineInfo> onVaccineTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: VaccinesScheduleTable(
            periods: data.periodLabels,
            vaccines: data.vaccines,
            onVaccineTap: onVaccineTap,
          ),
        ),
        const VaccinesLegend(),
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
