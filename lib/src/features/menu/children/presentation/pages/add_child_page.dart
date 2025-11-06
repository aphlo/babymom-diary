import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../application/selected_child_provider.dart';
import '../../data/infrastructure/child_firestore_data_source.dart';
import '../widgets/child_form.dart';

class AddChildPage extends ConsumerStatefulWidget {
  const AddChildPage({super.key});

  @override
  ConsumerState<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends ConsumerState<AddChildPage> {
  String _toHex(Color c) =>
      '#${c.value.toRadixString(16).padLeft(8, '0').substring(2)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('子どもを追加'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ChildForm(
            onSubmit: (data) async {
              final householdId =
                  await ref.read(currentHouseholdIdProvider.future);
              final db = ref.read(firebaseFirestoreProvider);
              final ds = ChildFirestoreDataSource(db, householdId);

              try {
                final childId = await ds.addChild(
                  name: data.name,
                  gender: data.gender,
                  birthday: data.birthday,
                  dueDate: data.dueDate,
                  color: _toHex(data.color),
                );

                // 追加した子供を自動的に選択状態にする
                await ref
                    .read(selectedChildControllerProvider.notifier)
                    .select(childId);

                if (context.mounted) {
                  context.pop();
                }
              } on FirebaseException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('保存に失敗しました: ${e.message}')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('保存に失敗しました: $e')),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
