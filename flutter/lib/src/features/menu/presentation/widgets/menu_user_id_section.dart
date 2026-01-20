import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../../core/theme/semantic_colors.dart';

/// メニューのユーザーIDセクション
class MenuUserIdSection extends ConsumerWidget {
  const MenuUserIdSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              'ユーザーID: $uid',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.textSecondary,
                    fontSize: 11,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => Clipboard.setData(ClipboardData(text: uid)),
            child: Icon(
              Icons.copy,
              size: 14,
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
