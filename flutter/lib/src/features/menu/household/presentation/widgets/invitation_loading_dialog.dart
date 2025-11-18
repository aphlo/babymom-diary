import 'package:flutter/material.dart';

class InvitationLoadingDialog extends StatelessWidget {
  const InvitationLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('通信中'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text('通信に時間がかかる場合があります。'),
        ],
      ),
    );
  }
}
