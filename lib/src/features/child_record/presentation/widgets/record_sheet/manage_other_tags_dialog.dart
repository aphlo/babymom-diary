import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/other_tags_controller.dart';

class ManageOtherTagsDialog extends ConsumerStatefulWidget {
  const ManageOtherTagsDialog({super.key});

  @override
  ConsumerState<ManageOtherTagsDialog> createState() =>
      _ManageOtherTagsDialogState();
}

class _ManageOtherTagsDialogState extends ConsumerState<ManageOtherTagsDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;
  String? _inputError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleAdd() async {
    if (_isSubmitting) {
      return;
    }
    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      setState(() => _inputError = '文字を入力してください');
      return;
    }

    final existing =
        ref.read(otherTagsControllerProvider).valueOrNull ?? const <String>[];
    if (existing.contains(raw)) {
      setState(() => _inputError = '既に登録されています');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _inputError = null;
    });

    try {
      await ref.read(otherTagsControllerProvider.notifier).addTag(raw);
      if (!mounted) return;
      _controller.clear();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('タグの追加に失敗しました')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _handleRemove(String tag) async {
    if (_isSubmitting) {
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref.read(otherTagsControllerProvider.notifier).removeTag(tag);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('タグの削除に失敗しました')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagState = ref.watch(otherTagsControllerProvider);
    final tags = tagState.valueOrNull ?? const <String>[];

    return AlertDialog(
      title: const Text('タグを編集'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              enabled: !_isSubmitting,
              decoration: InputDecoration(
                labelText: 'タグ名',
                border: const OutlineInputBorder(),
                errorText: _inputError,
              ),
              onSubmitted: (_) => _handleAdd(),
            ),
            const SizedBox(height: 12),
            if (tagState.isLoading)
              const SizedBox(
                height: 72,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (tags.isEmpty)
              const Text('登録済みのタグがありません')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in tags)
                    InputChip(
                      label: Text(tag),
                      onDeleted:
                          _isSubmitting ? null : () => _handleRemove(tag),
                    ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              _isSubmitting ? null : () => Navigator.of(context).maybePop(),
          child: const Text('閉じる'),
        ),
        FilledButton.icon(
          onPressed: _isSubmitting || tagState.isLoading ? null : _handleAdd,
          icon: const Icon(Icons.add),
          label: const Text('追加'),
        ),
      ],
    );
  }
}
