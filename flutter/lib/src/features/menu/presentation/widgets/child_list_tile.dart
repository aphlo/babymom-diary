import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/menu/children/application/child_color_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';

class ChildListTile extends ConsumerWidget {
  const ChildListTile({
    super.key,
    required this.id,
    required this.name,
    required this.subtitle,
  });

  final String id;
  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      selectedChildControllerProvider.select((v) => v.value == id),
    );
    // SharedPreferencesから色を取得
    final color = ref
        .watch(childColorProvider.notifier)
        .getColor(id, defaultColor: AppColors.primary);

    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      key: ValueKey('child-$id'),
      tileColor: isSelected ? scheme.primaryContainer : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 40,
      leading: InkWell(
        onTap: () =>
            ref.read(selectedChildControllerProvider.notifier).select(id),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
          child: Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            size: 28,
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 16,
            child: const Icon(Icons.child_care, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/children/edit/$id'),
    );
  }
}
