import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/log_controller.dart';
import '../components/entry_tile.dart';

class LogListScreen extends ConsumerWidget {
  const LogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(logControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Baby Log (Today)')),
      body: state.when(
        data: (list) => list.isEmpty
            ? const Center(child: Text('No entries yet.'))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => EntryTile(entry: list[i]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed('add'),
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}