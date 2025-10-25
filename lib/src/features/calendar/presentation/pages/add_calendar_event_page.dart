import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_view_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/add_event_date_time_row.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/add_event_icon_picker.dart';

class AddCalendarEventPage extends ConsumerStatefulWidget {
  const AddCalendarEventPage({
    required this.initialDate,
    super.key,
  });

  final DateTime initialDate;

  @override
  ConsumerState<AddCalendarEventPage> createState() =>
      _AddCalendarEventPageState();
}

class _AddCalendarEventPageState extends ConsumerState<AddCalendarEventPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    final initialState =
        ref.read(addCalendarEventViewModelProvider(widget.initialDate));
    _titleController = TextEditingController(text: initialState.title);
    _memoController = TextEditingController(text: initialState.memo);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  AddCalendarEventViewModel get _viewModel =>
      ref.read(addCalendarEventViewModelProvider(widget.initialDate).notifier);

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(addCalendarEventViewModelProvider(widget.initialDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text('予定を追加'),
        actions: [
          TextButton(
            onPressed: state.canSubmit && !state.isSubmitting
                ? () {
                    if (_formKey.currentState!.validate()) {
                      final result = _viewModel.buildResult();
                      if (result != null) {
                        Navigator.of(context).pop(result);
                      }
                    }
                  }
                : null,
            child: const Text('保存'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // タイトル入力
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  border: OutlineInputBorder(),
                ),
                onChanged: _viewModel.updateTitle,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'タイトルを入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // メモ入力
              TextFormField(
                controller: _memoController,
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: _viewModel.updateMemo,
              ),
              const SizedBox(height: 16),

              // 終日フラグ
              Row(
                children: [
                  const Text('終日'),
                  const Spacer(),
                  Switch(
                    value: state.allDay,
                    onChanged:
                        state.isSubmitting ? null : _viewModel.updateAllDay,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 開始日時
              AddEventDateTimeRow(
                label: '開始',
                dateLabel: DateFormat('yyyy/MM/dd').format(state.startDate),
                onDateTap: () => _viewModel.showStartDatePicker(context),
                timeLabel: state.allDay
                    ? null
                    : '${state.startTime.hour.toString().padLeft(2, '0')}:${state.startTime.minute.toString().padLeft(2, '0')}',
                onTimeTap: state.allDay
                    ? null
                    : () => _viewModel.showStartTimePicker(context),
              ),
              const SizedBox(height: 8),

              // 終了日時
              AddEventDateTimeRow(
                label: '終了',
                dateLabel: DateFormat('yyyy/MM/dd').format(state.endDate),
                onDateTap: () => _viewModel.showEndDatePicker(context),
                timeLabel: state.allDay
                    ? null
                    : '${state.endTime.hour.toString().padLeft(2, '0')}:${state.endTime.minute.toString().padLeft(2, '0')}',
                onTimeTap: state.allDay
                    ? null
                    : () => _viewModel.showEndTimePicker(context),
              ),
              const SizedBox(height: 24),

              // アイコン選択
              const Text(
                'アイコン',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              AddEventIconPicker(
                iconPaths: state.availableIconPaths,
                selectedPath: state.selectedIconPath,
                onChanged: _viewModel.selectIcon,
              ),
              const SizedBox(height: 32),

              // 保存ボタン（下部）
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.canSubmit && !state.isSubmitting
                      ? () {
                          final result = _viewModel.buildResult();
                          if (result != null) {
                            Navigator.of(context).pop(result);
                          }
                        }
                      : null,
                  child: state.isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('保存'),
                ),
              ),

              // エラーメッセージ
              if (state.validationMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    state.validationMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
