import 'package:flutter/material.dart';

import '../../../../core/types/gender.dart';

class ChildFormData {
  final String name;
  final Gender gender;
  final DateTime? birthday;
  final double? birthWeight;
  final double? height;
  final double? headCircumference;
  final double? chestCircumference;
  final Color color;

  const ChildFormData({
    this.name = '',
    this.gender = Gender.unknown,
    this.birthday,
    this.birthWeight,
    this.height,
    this.headCircumference,
    this.chestCircumference,
    this.color = Colors.blueAccent,
  });

  ChildFormData copyWith({
    String? name,
    Gender? gender,
    DateTime? birthday,
    double? birthWeight,
    double? height,
    double? headCircumference,
    double? chestCircumference,
    Color? color,
  }) {
    return ChildFormData(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      birthWeight: birthWeight ?? this.birthWeight,
      height: height ?? this.height,
      headCircumference: headCircumference ?? this.headCircumference,
      chestCircumference: chestCircumference ?? this.chestCircumference,
      color: color ?? this.color,
    );
  }
}

class ChildForm extends StatefulWidget {
  final ChildFormData? initial;
  final Future<void> Function(ChildFormData data) onSubmit;
  const ChildForm({super.key, this.initial, required this.onSubmit});

  @override
  State<ChildForm> createState() => _ChildFormState();
}

class _ChildFormState extends State<ChildForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _birthWeightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _headCtrl = TextEditingController();
  final _chestCtrl = TextEditingController();
  final _birthdayCtrl = TextEditingController();

  late Gender _gender;
  DateTime? _birthday;
  Color _pickedColor = Colors.blueAccent;

  @override
  void initState() {
    super.initState();
    final i = widget.initial ?? const ChildFormData();
    _nameCtrl.text = i.name;
    _gender = i.gender;
    _birthday = i.birthday;
    if (_birthday != null) {
      _birthdayCtrl.text = '${_birthday!.year}/${_birthday!.month}/${_birthday!.day}';
    }
    _birthWeightCtrl.text = i.birthWeight?.toString() ?? '';
    _heightCtrl.text = i.height?.toString() ?? '';
    _headCtrl.text = i.headCircumference?.toString() ?? '';
    _chestCtrl.text = i.chestCircumference?.toString() ?? '';
    _pickedColor = i.color;
  }

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

  double? _parseDouble(String s) => s.trim().isEmpty ? null : double.tryParse(s);

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthday == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('誕生日を選択してください')),
      );
      return;
    }

    final data = ChildFormData(
      name: _nameCtrl.text.trim(),
      gender: _gender,
      birthday: _birthday,
      birthWeight: _parseDouble(_birthWeightCtrl.text),
      height: _parseDouble(_heightCtrl.text),
      headCircumference: _parseDouble(_headCtrl.text),
      chestCircumference: _parseDouble(_chestCtrl.text),
      color: _pickedColor,
    );

    await widget.onSubmit(data);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            decoration: InputDecoration(
              labelText: '誕生日',
              hintText: '未選択',
              suffixIcon: _birthday != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _birthday = null;
                          _birthdayCtrl.clear();
                        });
                      },
                    )
                  : null,
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
          Builder(
            builder: (context) {
              final palette = <Color>[
                Colors.redAccent,
                Colors.pinkAccent,
                Colors.orangeAccent,
                Colors.amber,
                Colors.greenAccent,
                Colors.lightBlueAccent,
                Colors.purpleAccent,
                Colors.teal,
              ];
              final colors = List<Color>.from(palette);
              if (!colors.any((c) => c.value == _pickedColor.value)) {
                colors.insert(0, _pickedColor);
              }
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final c in colors)
                    GestureDetector(
                      onTap: () => setState(() => _pickedColor = c),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _pickedColor.value == c.value
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
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
    );
  }
}
