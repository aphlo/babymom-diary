import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_settings_view_model.dart';

class CalendarSettingsPage extends ConsumerWidget {
  const CalendarSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarSettingsViewModelProvider);
    final viewModel = ref.read(calendarSettingsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー設定'),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.error != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        state.error!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  const Text(
                    '週の開始曜日',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: RadioGroup<bool>(
                      groupValue: state.settings.startingDayOfWeek,
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.updateStartingDayOfWeek(value);
                        }
                      },
                      child: Column(
                        children: [
                          RadioListTile<bool>(
                            title: const Text('月曜日'),
                            subtitle: const Text('月曜日から週が始まります'),
                            value: true,
                          ),
                          const Divider(height: 1),
                          RadioListTile<bool>(
                            title: const Text('日曜日'),
                            subtitle: const Text('日曜日から週が始まります'),
                            value: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '設定は自動的に保存されます',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
