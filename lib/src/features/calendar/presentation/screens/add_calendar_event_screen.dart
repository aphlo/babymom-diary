import 'package:flutter/material.dart';

class AddCalendarEventResult {
  const AddCalendarEventResult({
    required this.title,
    required this.memo,
    required this.allDay,
    required this.start,
    required this.end,
    required this.iconPath,
  });

  final String title;
  final String memo;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final String iconPath;
}

class AddCalendarEventScreen extends StatefulWidget {
  const AddCalendarEventScreen({
    required this.initialDate,
    super.key,
  });

  final DateTime initialDate;

  @override
  State<AddCalendarEventScreen> createState() => _AddCalendarEventScreenState();
}

const _availableIconPaths = <String>[
  'assets/icons/birthday.png',
  'assets/icons/seven_nights.png',
  'assets/icons/k2_syrup.png',
  'assets/icons/health_check.png',
  'assets/icons/vaccination.png',
  'assets/icons/omiyamairi.png',
  'assets/icons/okuizome.png',
  'assets/icons/medical_consultation.png',
  'assets/icons/half_birthday.png',
  'assets/icons/first_boy_festival.png',
  'assets/icons/first_girl_festival.png',
];

class _AddCalendarEventScreenState extends State<AddCalendarEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  bool _allDay = false;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  late String _selectedIconPath;

  @override
  void initState() {
    super.initState();
    _selectedIconPath = _availableIconPaths.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startTime = picked;
        if (!_allDay && !_isEndAfterStart(_startTime, _endTime)) {
          _endTime = TimeOfDay(
            hour: (_startTime.hour + 1) % 24,
            minute: _startTime.minute,
          );
        }
      } else {
        _endTime = picked;
      }
    });
  }

  bool _isEndAfterStart(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes > startMinutes;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final date = DateTime(widget.initialDate.year, widget.initialDate.month,
        widget.initialDate.day);

    DateTime start;
    DateTime end;

    if (_allDay) {
      start = date;
      end = date.add(const Duration(hours: 23, minutes: 59));
    } else {
      if (!_isEndAfterStart(_startTime, _endTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('終了時間は開始時間より後にしてください。')),
        );
        return;
      }

      start = DateTime(
        date.year,
        date.month,
        date.day,
        _startTime.hour,
        _startTime.minute,
      );
      end = DateTime(
        date.year,
        date.month,
        date.day,
        _endTime.hour,
        _endTime.minute,
      );
    }

    final result = AddCalendarEventResult(
      title: _titleController.text.trim(),
      memo: _memoController.text.trim(),
      allDay: _allDay,
      start: start,
      end: end,
      iconPath: _selectedIconPath,
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予定を追加'),
        actions: [
          TextButton(
            onPressed: _submit,
            child: const Text('保存'),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'タイトルを入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _memoController,
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              SwitchListTile.adaptive(
                title: const Text('終日'),
                value: _allDay,
                onChanged: (value) {
                  setState(() {
                    _allDay = value;
                  });
                },
              ),
              if (!_allDay) ...[
                const SizedBox(height: 12),
                _TimeSelectorTile(
                  label: '開始時間',
                  time: _startTime,
                  onTap: () => _pickTime(isStart: true),
                ),
                const SizedBox(height: 8),
                _TimeSelectorTile(
                  label: '終了時間',
                  time: _endTime,
                  onTap: () => _pickTime(isStart: false),
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                'アイコンを選択',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 112,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemBuilder: (context, index) {
                    final path = _availableIconPaths[index];
                    return _IconChoice(
                      path: path,
                      selected: _selectedIconPath == path,
                      onTap: () {
                        setState(() {
                          _selectedIconPath = path;
                        });
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: _availableIconPaths.length,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeSelectorTile extends StatelessWidget {
  const _TimeSelectorTile({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(time.format(context)),
      trailing: const Icon(Icons.timer),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
    );
  }
}

class _IconChoice extends StatelessWidget {
  const _IconChoice({
    required this.path,
    required this.selected,
    required this.onTap,
  });

  final String path;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 88,
        // height: 88,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
