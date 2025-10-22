import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/record_view_model.dart';

class AppBarDateSwitcher extends ConsumerWidget {
  const AppBarDateSwitcher({super.key});

  String _weekdayJa(DateTime d) {
    const w = ['月', '火', '水', '木', '金', '土', '日'];
    final idx = (d.weekday - 1).clamp(0, 6);
    return w[idx];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recordViewModelProvider);
    final notifier = ref.read(recordViewModelProvider.notifier);
    final date = state.selectedDate;
    final today = DateTime.now();
    final today0 = DateTime(today.year, today.month, today.day);

    Future<void> setDate(DateTime d) async {
      await notifier.onSelectDate(DateTime(d.year, d.month, d.day));
    }

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020, 1, 1),
        lastDate: today0, // 未来は選べない
      );
      if (picked != null) setDate(picked);
    }

    return GestureDetector(
      onTap: pickDate,
      child: Text(
        '${date.year}/${date.month}/${date.day}(${_weekdayJa(date)})',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
