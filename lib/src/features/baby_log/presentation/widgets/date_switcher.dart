import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/selected_log_date_provider.dart';

class DateSwitcher extends ConsumerWidget {
  const DateSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedLogDateProvider);
    final formatted = '${date.year}/${date.month}/${date.day}';

    void setDate(DateTime d) {
      ref.read(selectedLogDateProvider.notifier).state =
          DateTime(d.year, d.month, d.day);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: '前日',
          onPressed: () => setDate(date.subtract(const Duration(days: 1))),
          icon: const Icon(Icons.chevron_left),
        ),
        TextButton.icon(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) setDate(picked);
          },
          icon: const Icon(Icons.calendar_today, size: 18),
          label: Text(formatted),
        ),
        IconButton(
          tooltip: '翌日',
          onPressed: () => setDate(date.add(const Duration(days: 1))),
          icon: const Icon(Icons.chevron_right),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () => setDate(DateTime.now()),
          child: const Text('今日'),
        ),
      ],
    );
  }
}
