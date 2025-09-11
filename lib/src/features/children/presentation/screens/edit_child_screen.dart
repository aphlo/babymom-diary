import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../../core/types/gender.dart';
import '../../data/sources/child_firestore_data_source.dart';

class EditChildScreen extends ConsumerStatefulWidget {
  const EditChildScreen({super.key, required this.childId});
  final String childId;

  @override
  ConsumerState<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends ConsumerState<EditChildScreen> {
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
  bool _loading = true;

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
  double? _parseDouble(String? s) => (s == null || s.trim().isEmpty) ? null : double.tryParse(s);

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

  Future<void> _load() async {
    final hid = await ref.read(currentHouseholdIdProvider.future);
    final ds = ChildFirestoreDataSource(ref.read(firebaseFirestoreProvider), hid);
    final doc = await ds.getChild(widget.childId);
    final data = doc.data();
    if (data != null) {
      _nameCtrl.text = (data['name'] as String?) ?? '';
      _gender = genderFromKey(data['gender'] as String?);
      final ts = data['birthday'] as Timestamp?;
      if (ts != null) {
        _birthday = ts.toDate();
        _birthdayCtrl.text = '${_birthday!.year}/${_birthday!.month}/${_birthday!.day}';
      }
      _birthWeightCtrl.text = (data['birthWeight']?.toString() ?? '');
      _heightCtrl.text = (data['height']?.toString() ?? '');
      _headCtrl.text = (data['headCircumference']?.toString() ?? '');
      _chestCtrl.text = (data['chestCircumference']?.toString() ?? '');
      final colorHex = (data['color'] as String?) ?? '#42a5f5';
      final cleaned = colorHex.replaceFirst('#', '');
      final value = int.tryParse(cleaned, radix: 16) ?? 0x42a5f5;
      _pickedColor = Color(0xFF000000 | value);
    }
    setState(() => _loading = false);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthday == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('誕生日を選択してください')),
      );
      return;
    }
    final hid = await ref.read(currentHouseholdIdProvider.future);
    final ds = ChildFirestoreDataSource(ref.read(firebaseFirestoreProvider), hid);
    try {
      await ds.updateChild(
        id: widget.childId,
        name: _nameCtrl.text.trim(),
        gender: _gender,
        birthday: _birthday!,
        birthWeight: _parseDouble(_birthWeightCtrl.text),
        height: _parseDouble(_heightCtrl.text),
        headCircumference: _parseDouble(_headCtrl.text),
        chestCircumference: _parseDouble(_chestCtrl.text),
        color: _toHex(_pickedColor),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('更新しました')),
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

  @override
  void initState() {
    super.initState();
    // ignore: discarded_futures
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(labelText: '名前'),
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
                        decoration: const InputDecoration(labelText: '出生体重 (g)'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _heightCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: '身長 (cm)'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _headCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: '頭囲 (cm)'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _chestCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: '胸囲 (cm)'),
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
                                    color: _pickedColor == c ? Colors.black : Colors.transparent,
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
