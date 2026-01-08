import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../../../../core/types/child_icon.dart';
import '../../../../../core/types/gender.dart';
import '../../application/child_color_provider.dart';
import '../../application/children_local_provider.dart';
import '../../application/selected_child_provider.dart';
import '../../application/selected_child_snapshot_provider.dart';
import '../../data/infrastructure/child_firestore_data_source.dart';
import '../../domain/entities/child_summary.dart';
import '../widgets/child_form.dart';

class EditChildPage extends ConsumerStatefulWidget {
  const EditChildPage({super.key, required this.childId});
  final String childId;

  @override
  ConsumerState<EditChildPage> createState() => _EditChildPageState();
}

class _EditChildPageState extends ConsumerState<EditChildPage> {
  bool _loading = true;
  ChildFormData? _initial;

  Future<void> _load() async {
    final hid = await ref.read(currentHouseholdIdProvider.future);
    if (!mounted) return;
    final ds =
        ChildFirestoreDataSource(ref.read(firebaseFirestoreProvider), hid);
    final doc = await ds.getChild(widget.childId);
    if (!mounted) return;
    final data = doc.data();
    if (data != null) {
      final ts = data['birthday'] as Timestamp?;
      final due = data['dueDate'] as Timestamp?;
      final birthday = ts?.toDate() ?? DateTime.now();
      final dueDate = due?.toDate();

      // 色をSharedPreferencesから取得
      final color =
          ref.read(childColorProvider.notifier).getColor(widget.childId);

      _initial = ChildFormData(
        name: (data['name'] as String?) ?? '',
        gender: genderFromKey(data['gender'] as String?),
        birthday: birthday,
        dueDate: dueDate,
        color: color,
        icon: childIconFromKey(data['icon'] as String?),
      );
    }
    if (!mounted) return;
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('子どもを編集'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ChildForm(
                initial: _initial,
                onSubmit: (form) async {
                  final hid = await ref.read(currentHouseholdIdProvider.future);
                  final ds = ChildFirestoreDataSource(
                      ref.read(firebaseFirestoreProvider), hid);
                  try {
                    await ds.updateChild(
                      id: widget.childId,
                      name: form.name,
                      gender: form.gender,
                      birthday: form.birthday,
                      dueDate: form.dueDate,
                      icon: form.icon,
                    );

                    // 色をSharedPreferencesに保存
                    await ref
                        .read(childColorProvider.notifier)
                        .setColor(widget.childId, form.color);

                    final summary = ChildSummary(
                      id: widget.childId,
                      name: form.name,
                      birthday: form.birthday,
                      dueDate: form.dueDate,
                      gender: form.gender,
                      icon: form.icon,
                    );
                    await ref
                        .read(childrenLocalProvider(hid).notifier)
                        .upsertChild(summary);
                    final selectedId =
                        ref.read(selectedChildControllerProvider).value;
                    if (selectedId == widget.childId) {
                      await ref
                          .read(selectedChildSnapshotProvider(hid).notifier)
                          .save(summary);
                    }

                    if (!context.mounted) return;
                    context.pop();
                  } on FirebaseException catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('保存に失敗しました: ${e.message}')),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('保存に失敗しました: $e')),
                    );
                  }
                },
              ),
            ),
    );
  }
}
