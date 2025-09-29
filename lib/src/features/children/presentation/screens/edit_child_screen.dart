import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../../core/types/gender.dart';
import '../../application/children_local_provider.dart';
import '../../application/selected_child_provider.dart';
import '../../application/selected_child_snapshot_provider.dart';
import '../../data/sources/child_firestore_data_source.dart';
import '../../domain/entities/child_summary.dart';
import '../widgets/child_form.dart';

class EditChildScreen extends ConsumerStatefulWidget {
  const EditChildScreen({super.key, required this.childId});
  final String childId;

  @override
  ConsumerState<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends ConsumerState<EditChildScreen> {
  bool _loading = true;
  ChildFormData? _initial;
  String _toHex(Color c) =>
      '#${c.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.blueAccent;
    final cleaned = hex.replaceFirst('#', '');
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return Colors.blueAccent;
    return Color(0xFF000000 | value);
  }

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
      _initial = ChildFormData(
        name: (data['name'] as String?) ?? '',
        gender: genderFromKey(data['gender'] as String?),
        birthday: ts?.toDate(),
        dueDate: due?.toDate(),
        color: _parseColor(data['color'] as String?),
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
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ChildForm(
                  initial: _initial,
                  onSubmit: (form) async {
                    final hid =
                        await ref.read(currentHouseholdIdProvider.future);
                    final ds = ChildFirestoreDataSource(
                        ref.read(firebaseFirestoreProvider), hid);
                    try {
                      final colorHex = _toHex(form.color);
                      await ds.updateChild(
                        id: widget.childId,
                        name: form.name,
                        gender: form.gender,
                        birthday: form.birthday!,
                        dueDate: form.dueDate,
                        color: colorHex,
                      );

                      final summary = ChildSummary(
                        id: widget.childId,
                        name: form.name,
                        birthday: form.birthday,
                        color: colorHex,
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
            ),
    );
  }
}
