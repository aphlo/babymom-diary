import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_state.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_view_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/add_event_date_time_row.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/add_event_icon_picker.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';

class AddCalendarEventScreen extends ConsumerStatefulWidget {
  const AddCalendarEventScreen({
    required this.initialDate,
    required this.children,
    this.initialChildId,
    super.key,
  });

  final DateTime initialDate;
  final List<ChildSummary> children;
  final String? initialChildId;

  @override
  ConsumerState<AddCalendarEventScreen> createState() =>
      _AddCalendarEventScreenState();
}

class _AddCalendarEventScreenState
    extends ConsumerState<AddCalendarEventScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;
  late final AddCalendarEventViewModelArgs _args;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _args = AddCalendarEventViewModelArgs(
      initialDate: widget.initialDate,
      children: widget.children,
      initialChildId: widget.initialChildId,
    );
    final initialState = ref.read(addCalendarEventViewModelProvider(_args));
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
      ref.read(addCalendarEventViewModelProvider(_args).notifier);

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  Widget _horizontalPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AddCalendarEventState>(
      addCalendarEventViewModelProvider(_args),
      (previous, next) {
        final message = next.validationMessage;
        if (message == null || message == previous?.validationMessage) {
          return;
        }
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );

    final state = ref.watch(addCalendarEventViewModelProvider(_args));

    return Scaffold(
      appBar: AppBar(
        title: const Text('予定を追加'),
        actions: [
          TextButton(
            onPressed: state.hasChildren && !state.isSubmitting
                ? () {
                    final result = _viewModel.handleSubmit(
                      formKey: _formKey,
                      titleValue: _titleController.text,
                      memoValue: _memoController.text,
                    );
                    if (result == null || !mounted) {
                      return;
                    }
                    Navigator.of(context).pop(result);
                  }
                : null,
            child: const Text('保存'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (!state.hasChildren)
              _horizontalPadding(
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('子どもが登録されていないため、予定を追加できません。'),
                  ),
                ),
              )
            else
              _horizontalPadding(
                DropdownButtonFormField<String>(
                  value: state.selectedChildId,
                  decoration: const InputDecoration(
                    labelText: '対象の子ども',
                    border: OutlineInputBorder(),
                  ),
                  items: state.children
                      .map(
                        (child) => DropdownMenuItem<String>(
                          value: child.id,
                          child: Text(child.name),
                        ),
                      )
                      .toList(),
                  onChanged: state.isSubmitting
                      ? null
                      : (value) => _viewModel.selectChild(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '子どもを選択してください';
                    }
                    return null;
                  },
                ),
              ),
            if (state.hasChildren) const SizedBox(height: 16),
            _horizontalPadding(
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '予定',
                  border: OutlineInputBorder(),
                ),
                onChanged: _viewModel.setTitle,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '予定を入力してください';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            _horizontalPadding(
              TextFormField(
                controller: _memoController,
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: _viewModel.setMemo,
              ),
            ),
            const SizedBox(height: 16),
            _horizontalPadding(
              SwitchListTile.adaptive(
                title: const Text('終日'),
                value: state.allDay,
                onChanged: state.isSubmitting
                    ? null
                    : (value) => _viewModel.toggleAllDay(value),
              ),
            ),
            const SizedBox(height: 12),
            _horizontalPadding(
              AddEventDateTimeRow(
                label: '開始時間',
                dateLabel: _formatDate(state.startDate),
                onDateTap: () =>
                    _viewModel.pickDate(context: context, isStart: true),
                timeLabel:
                    state.allDay ? null : state.startTime.format(context),
                onTimeTap: state.allDay
                    ? null
                    : () => _viewModel.pickTime(
                          context: context,
                          isStart: true,
                        ),
              ),
            ),
            if (!state.allDay) ...[
              const SizedBox(height: 8),
              _horizontalPadding(
                AddEventDateTimeRow(
                  label: '終了時間',
                  dateLabel: _formatDate(state.endDate),
                  onDateTap: () =>
                      _viewModel.pickDate(context: context, isStart: false),
                  timeLabel: state.endTime.format(context),
                  onTimeTap: () =>
                      _viewModel.pickTime(context: context, isStart: false),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _horizontalPadding(
              const Text(
                'アイコンを選択',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            AddEventIconPicker(
              iconPaths: state.availableIconPaths,
              selectedPath: state.selectedIconPath,
              onChanged: (path) {
                final latestState =
                    ref.read(addCalendarEventViewModelProvider(_args));
                if (latestState.isSubmitting) {
                  return;
                }
                _viewModel.selectIcon(path);
              },
            ),
            const SizedBox(height: 32),
            _horizontalPadding(
              FilledButton.icon(
                onPressed: state.hasChildren && !state.isSubmitting
                    ? () {
                        final result = _viewModel.handleSubmit(
                          formKey: _formKey,
                          titleValue: _titleController.text,
                          memoValue: _memoController.text,
                        );
                        if (result == null || !mounted) {
                          return;
                        }
                        Navigator.of(context).pop(result);
                      }
                    : null,
                icon: const Icon(Icons.save),
                label: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
