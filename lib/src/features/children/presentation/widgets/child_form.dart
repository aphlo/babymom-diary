import 'package:flutter/material.dart';

import '../../../../core/types/gender.dart';

class ChildFormData {
  final String name;
  final Gender gender;
  final DateTime? birthday;
  final DateTime? dueDate;
  final Color color;

  const ChildFormData({
    this.name = '',
    this.gender = Gender.unknown,
    this.birthday,
    this.dueDate,
    this.color = Colors.blueAccent,
  });

  ChildFormData copyWith({
    String? name,
    Gender? gender,
    DateTime? birthday,
    DateTime? dueDate,
    Color? color,
  }) {
    return ChildFormData(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      dueDate: dueDate ?? this.dueDate,
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
  static const List<Color> _palette = <Color>[
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.amber,
    Colors.lightBlueAccent,
    Colors.purpleAccent,
    Colors.teal,
  ];
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _birthdayCtrl = TextEditingController();
  final _dueDateCtrl = TextEditingController();

  late Gender _gender;
  DateTime? _birthday;
  DateTime? _dueDate;
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
    _dueDate = i.dueDate;
    if (_dueDate != null) {
      _dueDateCtrl.text = '${_dueDate!.year}/${_dueDate!.month}/${_dueDate!.day}';
    }
    // no measurement fields
    if (widget.initial == null) {
      _pickedColor = Colors.redAccent;
    } else {
      final inPalette = _palette.any((c) => c.value == i.color.value);
      _pickedColor = inPalette ? i.color : Colors.redAccent;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _birthdayCtrl.dispose();
    _dueDateCtrl.dispose();
    super.dispose();
  }

  // no numeric parsing needed

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

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10);
    final last = DateTime(now.year + 1);
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? _birthday ?? now,
      firstDate: first,
      lastDate: last,
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dueDateCtrl.text = '${picked.year}/${picked.month}/${picked.day}';
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
      dueDate: _dueDate,
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
            controller: _dueDateCtrl,
            readOnly: true,
            showCursor: false,
            decoration: InputDecoration(
              labelText: '出産予定日',
              hintText: '未選択',
              suffixIcon: _dueDate != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _dueDate = null;
                          _dueDateCtrl.clear();
                        });
                      },
                    )
                  : null,
            ),
            onTap: _pickDueDate,
          ),
          // measurement fields removed
          const SizedBox(height: 16),
          Text('カラー', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c in _palette)
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
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
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
