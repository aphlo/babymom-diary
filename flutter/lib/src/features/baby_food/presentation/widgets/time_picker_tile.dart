import 'package:flutter/material.dart';

import '../../../../core/widgets/milu_infinite_time_picker.dart';

/// 時刻選択タイル
class TimePickerTile extends StatelessWidget {
  const TimePickerTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final TimeOfDay value;
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) {
    final formatted = value.format(context);
    return ListTile(
      leading: const Icon(Icons.access_time),
      title: const Text('記録時間'),
      trailing: FilledButton.tonalIcon(
        onPressed: () async {
          final picked = await showMiluInfiniteTimePicker(
            context,
            initialTime: value,
          );
          if (picked != null) {
            onChanged(picked);
          }
        },
        icon: const Icon(Icons.edit, size: 18),
        label: Text(formatted),
      ),
    );
  }
}
