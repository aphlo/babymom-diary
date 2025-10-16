import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

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
  late DateTime _startDate;
  late DateTime _endDate;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  late String _selectedIconPath;

  @override
  void initState() {
    super.initState();
    final initialDate = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      widget.initialDate.day,
    );
    _startDate = initialDate;
    _endDate = initialDate;
    _selectedIconPath = _availableIconPaths.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final current = isStart ? _startDate : _endDate;
    final pickedDate = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      currentTime: current,
      locale: LocaleType.jp,
    );
    if (pickedDate == null) {
      return;
    }
    final normalizedDate = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
    );

    setState(() {
      if (isStart) {
        _startDate = normalizedDate;
        if (_allDay) {
          _endDate = normalizedDate;
          return;
        }
        _ensureEndAfterStart(_combine(_startDate, _startTime));
      } else {
        _endDate = normalizedDate;
        if (_allDay) {
          return;
        }
        if (!_isEndAfterStart(
          _combine(_startDate, _startTime),
          _combine(_endDate, _endTime),
        )) {
          _ensureEndAfterStart(_combine(_startDate, _startTime));
        }
      }
    });
  }

  Future<void> _pickTime({required bool isStart}) async {
    if (_allDay) return;

    final referenceDate = isStart ? _startDate : _endDate;
    final referenceTime = isStart ? _startTime : _endTime;
    final current = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      referenceTime.hour,
      referenceTime.minute,
    );

    final picked = await DatePicker.showTimePicker(
      context,
      currentTime: current,
      showTitleActions: true,
      showSecondsColumn: false,
      locale: LocaleType.jp,
    );
    if (picked == null) return;

    final selectedTime = TimeOfDay(
      hour: picked.hour,
      minute: picked.minute,
    );

    setState(() {
      if (isStart) {
        _startTime = selectedTime;
        _ensureEndAfterStart(_combine(_startDate, _startTime));
      } else {
        _endTime = selectedTime;
        if (!_isEndAfterStart(
          _combine(_startDate, _startTime),
          _combine(_endDate, _endTime),
        )) {
          _ensureEndAfterStart(_combine(_startDate, _startTime));
        }
      }
    });
  }

  DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _ensureEndAfterStart(DateTime newStart) {
    final currentEnd = _combine(_endDate, _endTime);
    if (!currentEnd.isAfter(newStart)) {
      final fallback = newStart.add(const Duration(hours: 1));
      _endDate = DateTime(fallback.year, fallback.month, fallback.day);
      _endTime = TimeOfDay(hour: fallback.hour, minute: fallback.minute);
    }
  }

  bool _isEndAfterStart(DateTime start, DateTime end) {
    return end.isAfter(start);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    DateTime start;
    DateTime end;

    if (_allDay) {
      start = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
      );
      end = start.add(const Duration(hours: 23, minutes: 59));
    } else {
      final startDateTime = _combine(_startDate, _startTime);
      final endDateTime = _combine(_endDate, _endTime);

      if (!_isEndAfterStart(startDateTime, endDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('終了時間は開始時間より後にしてください。')),
        );
        return;
      }

      start = startDateTime;
      end = endDateTime;
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
                  labelText: '予定',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '予定を入力してください';
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
                    if (value) {
                      _endDate = _startDate;
                    } else {
                      _ensureEndAfterStart(_combine(_startDate, _startTime));
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              _DateTimeSelectorRow(
                label: '開始時間',
                dateLabel: _formatDate(_startDate),
                onDateTap: () => _pickDate(isStart: true),
                timeLabel: _allDay ? null : _startTime.format(context),
                onTimeTap: _allDay ? null : () => _pickTime(isStart: true),
              ),
              if (!_allDay) ...[
                const SizedBox(height: 8),
                _DateTimeSelectorRow(
                  label: '終了時間',
                  dateLabel: _formatDate(_endDate),
                  onDateTap: () => _pickDate(isStart: false),
                  timeLabel: _endTime.format(context),
                  onTimeTap: () => _pickTime(isStart: false),
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

class _DateTimeSelectorRow extends StatelessWidget {
  const _DateTimeSelectorRow({
    required this.label,
    required this.dateLabel,
    required this.onDateTap,
    this.timeLabel,
    this.onTimeTap,
  });

  final String label;
  final String dateLabel;
  final VoidCallback onDateTap;
  final String? timeLabel;
  final VoidCallback? onTimeTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showTime = timeLabel != null && onTimeTap != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _PickerButton(
                label: dateLabel,
                icon: Icons.event,
                onTap: onDateTap,
              ),
            ),
            if (showTime) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _PickerButton(
                  label: timeLabel!,
                  icon: Icons.timer,
                  onTap: onTimeTap!,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _PickerButton extends StatelessWidget {
  const _PickerButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
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
