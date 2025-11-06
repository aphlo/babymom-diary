import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_view_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/edit_calendar_event_view_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/add_event_date_time_row.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/add_event_icon_picker.dart';

class AddCalendarEventPage extends ConsumerStatefulWidget {
  const AddCalendarEventPage({
    this.initialDate,
    this.existingEvent,
    super.key,
  }) : assert(
          (initialDate != null) != (existingEvent != null),
          'Either initialDate or existingEvent must be provided, but not both',
        );

  final DateTime? initialDate;
  final CalendarEvent? existingEvent;

  bool get isEditing => existingEvent != null;

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

    if (widget.isEditing) {
      _titleController =
          TextEditingController(text: widget.existingEvent!.title);
      _memoController = TextEditingController(text: widget.existingEvent!.memo);
    } else {
      final initialState =
          ref.read(addCalendarEventViewModelProvider(widget.initialDate!));
      _titleController = TextEditingController(text: initialState.title);
      _memoController = TextEditingController(text: initialState.memo);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      return _buildEditingView(context);
    } else {
      return _buildAddingView(context);
    }
  }

  Widget _buildAddingView(BuildContext context) {
    final state =
        ref.watch(addCalendarEventViewModelProvider(widget.initialDate!));
    final viewModel = ref
        .read(addCalendarEventViewModelProvider(widget.initialDate!).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('予定を追加'),
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
                cursorColor: AppColors.primary,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  floatingLabelStyle: TextStyle(color: AppColors.primary),
                ),
                onChanged: viewModel.updateTitle,
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
                cursorColor: AppColors.primary,
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  floatingLabelStyle: TextStyle(color: AppColors.primary),
                ),
                maxLines: 3,
                onChanged: viewModel.updateMemo,
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
                        state.isSubmitting ? null : viewModel.updateAllDay,
                    activeTrackColor: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 開始日時
              AddEventDateTimeRow(
                label: '開始',
                dateLabel: DateFormat('yyyy/MM/dd').format(state.startDate),
                onDateTap: () => viewModel.showStartDatePicker(context),
                timeLabel: state.allDay
                    ? null
                    : '${state.startTime.hour.toString().padLeft(2, '0')}:${state.startTime.minute.toString().padLeft(2, '0')}',
                onTimeTap: state.allDay
                    ? null
                    : () => viewModel.showStartTimePicker(context),
              ),
              const SizedBox(height: 8),

              // 終了日時（終日の場合は非表示）
              if (!state.allDay)
                AddEventDateTimeRow(
                  label: '終了',
                  dateLabel: DateFormat('yyyy/MM/dd').format(state.endDate),
                  onDateTap: () => viewModel.showEndDatePicker(context),
                  timeLabel:
                      '${state.endTime.hour.toString().padLeft(2, '0')}:${state.endTime.minute.toString().padLeft(2, '0')}',
                  onTimeTap: () => viewModel.showEndTimePicker(context),
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
                onChanged: viewModel.selectIcon,
              ),
              const SizedBox(height: 32),

              // エラーメッセージ
              if (state.validationMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    state.validationMessage!,
                    style: const TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: state.canSubmit && !state.isSubmitting
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        final result = viewModel.buildResult();
                        if (result != null) {
                          Navigator.of(context).pop(result);
                        }
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('保存'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditingView(BuildContext context) {
    final state =
        ref.watch(editCalendarEventViewModelProvider(widget.existingEvent!));
    final viewModel = ref.read(
        editCalendarEventViewModelProvider(widget.existingEvent!).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('予定を編集'),
        actions: [
          // 削除ボタン
          IconButton(
            onPressed: state.canDelete
                ? () => _showDeleteConfirmDialog(context, viewModel)
                : null,
            icon: state.isDeleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete),
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
                cursorColor: AppColors.primary,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  floatingLabelStyle: TextStyle(color: AppColors.primary),
                ),
                onChanged: viewModel.updateTitle,
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
                cursorColor: AppColors.primary,
                decoration: const InputDecoration(
                  labelText: 'メモ',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  floatingLabelStyle: TextStyle(color: AppColors.primary),
                ),
                maxLines: 3,
                onChanged: viewModel.updateMemo,
              ),
              const SizedBox(height: 16),

              // 終日フラグ
              Row(
                children: [
                  const Text('終日'),
                  const Spacer(),
                  Switch(
                    value: state.allDay,
                    onChanged: state.isSubmitting || state.isDeleting
                        ? null
                        : viewModel.updateAllDay,
                    activeTrackColor: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 開始日時
              AddEventDateTimeRow(
                label: '開始',
                dateLabel: DateFormat('yyyy/MM/dd').format(state.startDate),
                onDateTap: () => viewModel.showStartDatePicker(context),
                timeLabel: state.allDay
                    ? null
                    : '${state.startTime.hour.toString().padLeft(2, '0')}:${state.startTime.minute.toString().padLeft(2, '0')}',
                onTimeTap: state.allDay
                    ? null
                    : () => viewModel.showStartTimePicker(context),
              ),
              const SizedBox(height: 8),

              // 終了日時（終日の場合は非表示）
              if (!state.allDay)
                AddEventDateTimeRow(
                  label: '終了',
                  dateLabel: DateFormat('yyyy/MM/dd').format(state.endDate),
                  onDateTap: () => viewModel.showEndDatePicker(context),
                  timeLabel:
                      '${state.endTime.hour.toString().padLeft(2, '0')}:${state.endTime.minute.toString().padLeft(2, '0')}',
                  onTimeTap: () => viewModel.showEndTimePicker(context),
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
                onChanged: viewModel.selectIcon,
              ),
              const SizedBox(height: 32),

              // エラーメッセージ
              if (state.validationMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    state.validationMessage!,
                    style: const TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: state.canSubmit && !state.isSubmitting
                  ? () => _handleUpdate(context, viewModel)
                  : null,
              child: const Text('保存'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleUpdate(
      BuildContext context, EditCalendarEventViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      final success = await viewModel.updateEvent();
      if (success) {
        if (!context.mounted) return;
        Navigator.of(context).pop(true); // 更新成功を示すためtrueを返す
      }
    }
  }

  Future<void> _showDeleteConfirmDialog(
      BuildContext context, EditCalendarEventViewModel viewModel) async {
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('予定を削除'),
        content: const Text('この予定を削除しますか？\nこの操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop(true);

              // 削除処理中のローディングダイアログを表示
              if (context.mounted) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // ユーザーが閉じられないようにする
                  builder: (loadingContext) => const AlertDialog(
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text('削除中...'),
                      ],
                    ),
                  ),
                );

                try {
                  final success = await viewModel.deleteEvent();

                  // ローディングダイアログを閉じる
                  if (context.mounted) {
                    Navigator.of(context).pop(); // ローディングダイアログを閉じる
                  }

                  if (success && context.mounted) {
                    // 削除成功時はページ全体を閉じて前の画面に戻る
                    Navigator.of(context).pop(true); // 削除成功を示すためtrueを返す
                  } else if (!success && context.mounted) {
                    // 削除失敗時はエラーメッセージを表示
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('イベントの削除に失敗しました'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (error) {
                  // ローディングダイアログを閉じる
                  if (context.mounted) {
                    Navigator.of(context).pop(); // ローディングダイアログを閉じる
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('削除中にエラーが発生しました: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}
