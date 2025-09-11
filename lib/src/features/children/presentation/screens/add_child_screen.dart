import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../../core/types/gender.dart';
import '../../../children/data/sources/child_firestore_data_source.dart';

class AddChildScreen extends ConsumerStatefulWidget {
  const AddChildScreen({super.key});

  @override
  ConsumerState<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends ConsumerState<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  Gender _gender = Gender.unknown;
  DateTime? _birthday;
  final _birthWeightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _headCtrl = TextEditingController();
  final _chestCtrl = TextEditingController();
  final _birthdayCtrl = TextEditingController();
  Color _pickedColor = Colors.blueAccent;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _birthWeightCtrl.dispose();
    _heightCtrl.dispose();
    _headCtrl.dispose();
    _chestCtrl.dispose();
    _birthdayCtrl.dispose();
    super.dispose();
  }

  String _toHex(Color c) => '#${c.value.toRadixString(16).padLeft(8, '0').substring(2)}';

  double? _parseDouble(String s) {
    if (s.trim().isEmpty) return null;
    return double.tryParse(s);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthday == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('誕生日を選択してください')),
      );
      return;
    }

    final householdId = await ref.read(currentHouseholdIdProvider.future);
    final db = ref.read(firebaseFirestoreProvider);
    final ds = ChildFirestoreDataSource(db, householdId);

    try {
      await ds.addChild(
        name: _nameCtrl.text.trim(),
        gender: _gender,
        birthday: _birthday!,
        birthWeight: _parseDouble(_birthWeightCtrl.text),
        height: _parseDouble(_heightCtrl.text),
        headCircumference: _parseDouble(_headCtrl.text),
        chestCircumference: _parseDouble(_chestCtrl.text),
        color: _toHex(_pickedColor),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('子供を追加しました')),
        );
        context.pop();
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存に失敗しました: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存に失敗しました: $e')),
      );
    }
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10);
    final last = now;
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? now,
      firstDate: first,
      lastDate: last,
    );
    if (picked != null) {
      setState(() {
        _birthday = picked;
        _birthdayCtrl.text = '${picked.year}/${picked.month}/${picked.day}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('子供を追加'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: '名前',
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? '名前を入力してください'
                      : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Gender>(
                  value: _gender,
                  decoration: const InputDecoration(labelText: '性別'),
                  items: const [
                    DropdownMenuItem(value: Gender.unknown, child: Text('未選択')),
                    DropdownMenuItem(value: Gender.male, child: Text('男の子')),
                    DropdownMenuItem(value: Gender.female, child: Text('女の子')),
                  ],
                  onChanged: (v) => setState(() => _gender = v ?? Gender.unknown),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _birthdayCtrl,
                  readOnly: true,
                  showCursor: false,
                  decoration: const InputDecoration(
                    labelText: '誕生日',
                    hintText: '未選択',
                  ),
                  onTap: _pickBirthday,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _birthWeightCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '出生体重 (g)',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _heightCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '身長 (cm)',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _headCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '頭囲 (cm)',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _chestCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '胸囲 (cm)',
                  ),
                ),
                const SizedBox(height: 16),
                Text('カラー', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final c in [
                      Colors.redAccent,
                      Colors.pinkAccent,
                      Colors.orangeAccent,
                      Colors.amber,
                      Colors.greenAccent,
                      Colors.lightBlueAccent,
                      Colors.purpleAccent,
                      Colors.teal,
                    ])
                      GestureDetector(
                        onTap: () => setState(() => _pickedColor = c),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _pickedColor == c
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.save),
                    label: const Text('保存'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
