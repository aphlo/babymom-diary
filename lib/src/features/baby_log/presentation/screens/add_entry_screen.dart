import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../baby_log.dart';
import '../controllers/log_controller.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryState();
}

class _AddEntryState extends ConsumerState<AddEntryScreen> {
  EntryType type = EntryType.feeding;
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  DateTime at = DateTime.now();

  @override
  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('記録')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<EntryType>(
              value: type,
              items: EntryType.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                  .toList(),
              onChanged: (v) => setState(() => type = v ?? type),
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: type.amountLabel),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: noteCtrl,
              decoration: const InputDecoration(labelText: 'メモ'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  final amt = double.tryParse(amountCtrl.text);
                  final entry = Entry(type: type, at: at, amount: amt, note: noteCtrl.text);
                  await ref.read(logControllerProvider.notifier).add(entry);
                  if (context.mounted) Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
