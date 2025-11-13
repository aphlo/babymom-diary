import 'package:flutter/material.dart';

class EmptyEventsView extends StatelessWidget {
  const EmptyEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_available,
            size: 48,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 12),
          const Text('この日の予定はまだありません'),
        ],
      ),
    );
  }
}
