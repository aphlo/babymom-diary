import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/mom_diary_entry.dart';
import '../models/mom_diary_ui_model.dart';
import '../viewmodels/mom_diary_view_model.dart';

class MomDiaryEditorDialog extends ConsumerStatefulWidget {
  const MomDiaryEditorDialog({super.key, required this.entry});

  final MomDiaryEntryUiModel entry;

  static Future<bool?> show(
    BuildContext context,
    MomDiaryEntryUiModel entry,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) => MomDiaryEditorDialog(entry: entry),
    );
  }

  @override
  ConsumerState<MomDiaryEditorDialog> createState() =>
      _MomDiaryEditorDialogState();
}

class _MomDiaryEditorDialogState extends ConsumerState<MomDiaryEditorDialog> {
  late final TextEditingController _contentController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _contentController =
        TextEditingController(text: widget.entry.content ?? '');
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = !widget.entry.hasContent;
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 16.0),
              child: Text(
                isNew
                    ? '日記を追加  ${widget.entry.dateLabel.replaceAll('\n', '')}'
                    : '日記を編集  ${widget.entry.dateLabel.replaceAll('\n', '')}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '日記を入力してください',
                      ),
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(false),
                    child: const Text('キャンセル'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _isSaving ? null : _handleSave,
                    child: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('保存'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    FocusScope.of(context).unfocus();
    final content = _contentController.text.trim();
    final entry = MomDiaryEntry(
      date: DateTime(
        widget.entry.date.year,
        widget.entry.date.month,
        widget.entry.date.day,
      ),
      content: content.isEmpty ? null : content,
    );

    setState(() {
      _isSaving = true;
    });

    final notifier = ref.read(momDiaryViewModelProvider.notifier);
    try {
      await notifier.saveEntry(entry);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (_) {
      setState(() {
        _isSaving = false;
      });
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('日記の保存に失敗しました')),
      );
    }
  }
}
