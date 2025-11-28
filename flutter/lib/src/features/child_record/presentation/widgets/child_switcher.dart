import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../menu/children/application/child_color_provider.dart';
import '../../../menu/children/application/children_stream_provider.dart';
import '../../../menu/children/application/selected_child_provider.dart';

class ChildSwitcher extends ConsumerWidget {
  const ChildSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHid = ref.watch(currentHouseholdIdProvider);
    final selectedId = ref.watch(selectedChildControllerProvider).value;

    return asyncHid.when(
      loading: () => const SizedBox(
          height: 40,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
      error: (e, __) => Text('error: $e'),
      data: (hid) {
        final childrenAsync = ref.watch(childrenStreamProvider(hid));
        return childrenAsync.when(
          loading: () => const SizedBox(
              height: 40,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
          error: (e, __) => Text('error: $e'),
          data: (children) {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                value:
                    children.any((c) => c.id == selectedId) ? selectedId : null,
                hint: const Text('子どもを選択'),
                items: [
                  for (final child in children)
                    DropdownMenuItem(
                      value: child.id,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: ref
                                .watch(childColorProvider.notifier)
                                .getColor(child.id,
                                    defaultColor: AppColors.primary),
                          ),
                          const SizedBox(width: 8),
                          Text(child.name),
                        ],
                      ),
                    ),
                ],
                onChanged: (v) => ref
                    .read(selectedChildControllerProvider.notifier)
                    .select(v),
                icon: const Icon(Icons.expand_more),
              ),
            );
          },
        );
      },
    );
  }
}
