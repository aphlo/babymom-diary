import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/record_tag_controller.dart';
import '../../viewmodels/record_sheet/manage_other_tags_view_model.dart';

class ManageOtherTagsDialog extends ConsumerStatefulWidget {
  const ManageOtherTagsDialog({
    super.key,
    required this.householdId,
  });

  final String householdId;

  @override
  ConsumerState<ManageOtherTagsDialog> createState() =>
      _ManageOtherTagsDialogState();
}

class _ManageOtherTagsDialogState extends ConsumerState<ManageOtherTagsDialog> {
  late final TextEditingController _controller;
  late final ProviderSubscription<ManageOtherTagsState> _stateSub;

  @override
  void dispose() {
    _stateSub.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final initialState =
        ref.read(manageOtherTagsViewModelProvider(widget.householdId));
    _controller = TextEditingController(text: initialState.input);
    _stateSub = ref.listenManual<ManageOtherTagsState>(
      manageOtherTagsViewModelProvider(widget.householdId),
      (previous, next) {
        if (_controller.text == next.input) {
          return;
        }
        _controller.text = next.input;
      },
    );
  }

  Future<void> _handleAdd() async {
    await ref
        .read(manageOtherTagsViewModelProvider(widget.householdId).notifier)
        .addTag();
  }

  Future<void> _handleRemove(String tag) async {
    await ref
        .read(manageOtherTagsViewModelProvider(widget.householdId).notifier)
        .removeTag(tag);
  }

  @override
  Widget build(BuildContext context) {
    final viewState =
        ref.watch(manageOtherTagsViewModelProvider(widget.householdId));
    final tagState = ref.watch(recordTagControllerProvider(widget.householdId));
    final tags = tagState.value ?? const <String>[];
    final isSubmitting = viewState.isSubmitting;
    final errorText = viewState.errorMessage;

    return AlertDialog(
      title: const Text('タグを編集'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              enabled: !isSubmitting,
              decoration: InputDecoration(
                labelText: 'タグ名',
                border: const OutlineInputBorder(),
                errorText: errorText,
              ),
              onChanged: (value) => ref
                  .read(manageOtherTagsViewModelProvider(widget.householdId)
                      .notifier)
                  .updateInput(value),
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
                      showCheckmark: false,
                      onDeleted: isSubmitting ? null : () => _handleRemove(tag),
                    ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              isSubmitting ? null : () => Navigator.of(context).maybePop(),
          child: const Text('閉じる'),
        ),
        FilledButton.icon(
          onPressed: isSubmitting || tagState.isLoading ? null : _handleAdd,
          icon: const Icon(Icons.add),
          label: const Text('追加'),
        ),
      ],
    );
  }
}
