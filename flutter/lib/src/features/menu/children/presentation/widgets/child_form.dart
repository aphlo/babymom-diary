import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/core/widgets/bottom_save_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../../core/types/gender.dart';
import 'child_icon_picker.dart';

class ChildFormData {
  final String name;
  final Gender gender;
  final DateTime birthday;
  final DateTime? dueDate;
  final Color color;
  final ChildIcon icon;

  const ChildFormData({
    required this.name,
    required this.gender,
    required this.birthday,
    this.dueDate,
    this.color = Colors.blueAccent,
    this.icon = ChildIcon.bear,
  });
}

class ChildForm extends StatefulWidget {
  final ChildFormData? initial;
  final Future<void> Function(ChildFormData data) onSubmit;

  /// 保存ボタンを表示するかどうか（デフォルト: true）
  /// falseの場合、外部から[ChildFormState.submit]を呼び出して保存を実行する
  final bool showSaveButton;

  const ChildForm({
    super.key,
    this.initial,
    required this.onSubmit,
    this.showSaveButton = true,
  });

  @override
  State<ChildForm> createState() => ChildFormState();
}

class ChildFormState extends State<ChildForm> {
  static const List<Color> _palette = <Color>[
    AppColors.primary,
    Colors.orangeAccent,
    Colors.lightBlueAccent,
    Colors.purpleAccent,
    Colors.teal,
  ];
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _birthdayCtrl = TextEditingController();
  final _dueDateCtrl = TextEditingController();

  Gender? _gender;
  DateTime? _birthday;
  DateTime? _dueDate;
  Color _pickedColor = AppColors.primary;
  ChildIcon _pickedIcon = ChildIcon.bear;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      final i = widget.initial!;
      _nameCtrl.text = i.name;
      _gender = i.gender;
      _birthday = i.birthday;
      _birthdayCtrl.text =
          '${i.birthday.year}/${i.birthday.month}/${i.birthday.day}';
      _dueDate = i.dueDate;
      if (i.dueDate != null) {
        _dueDateCtrl.text =
            '${i.dueDate!.year}/${i.dueDate!.month}/${i.dueDate!.day}';
      }
      final inPalette = _palette.any((c) => c.toARGB32() == i.color.toARGB32());
      _pickedColor = inPalette ? i.color : AppColors.primary;
      _pickedIcon = i.icon;
    } else {
      // 新規追加の場合、デフォルト値を設定
      _nameCtrl.text = '';
      _gender = null;
      _birthday = null;
      _dueDate = null;
      _pickedColor = AppColors.primary;
      _pickedIcon = ChildIcon.bear;
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

  /// フォームをバリデーションし、有効な場合はonSubmitを呼び出す
  /// 外部から呼び出す場合は`GlobalKey<ChildFormState>`を使用する
  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    // バリデーションが通った後なので、_birthdayと_genderは必ずnon-null（dueDateはoptional）
    final data = ChildFormData(
      name: _nameCtrl.text.trim(),
      gender: _gender!,
      birthday: _birthday!,
      dueDate: _dueDate,
      color: _pickedColor,
      icon: _pickedIcon,
    );

    await widget.onSubmit(data);
  }

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 16);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: horizontalPadding,
            child: TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: '名前',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '名前を入力してください' : null,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: horizontalPadding,
            child: DropdownButtonFormField<Gender>(
              initialValue: _gender,
              decoration: const InputDecoration(labelText: '性別'),
              items: const [
                DropdownMenuItem(value: Gender.male, child: Text('男の子')),
                DropdownMenuItem(value: Gender.female, child: Text('女の子')),
              ],
              validator: (v) => v == null ? '性別を選択してください' : null,
              onChanged: (v) => setState(() => _gender = v),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: horizontalPadding,
            child: TextFormField(
              controller: _birthdayCtrl,
              readOnly: true,
              showCursor: false,
              decoration: const InputDecoration(
                labelText: '誕生日',
                hintText: '選択してください',
              ),
              validator: (v) => _birthday == null ? '誕生日を選択してください' : null,
              onTap: _pickBirthday,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: horizontalPadding,
            child: TextFormField(
              controller: _dueDateCtrl,
              readOnly: true,
              showCursor: false,
              decoration: InputDecoration(
                labelText: '出産予定日（任意）',
                hintText: '選択してください',
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 28),
            child: Text(
              '出産予定日は修正月齢で早産児の成長曲線を表示するために使用します。',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: horizontalPadding,
            child: Text('カラー', style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: horizontalPadding,
            child: Wrap(
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
                          color: _pickedColor.toARGB32() == c.toARGB32()
                              ? Colors.black
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 28),
            child: Text(
              'カラーの設定は共有されません。',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: horizontalPadding,
            child: Text('アイコン', style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: 8),
          ChildIconPicker(
            selectedIcon: _pickedIcon,
            onChanged: (icon) => setState(() => _pickedIcon = icon),
          ),
          if (widget.showSaveButton) ...[
            const SizedBox(height: 24),
            Padding(
              padding: horizontalPadding,
              child: SaveButton(
                onPressed: submit,
              ),
            ),
            const SizedBox(height: 16),
          ]
        ],
      ),
    );
  }
}
