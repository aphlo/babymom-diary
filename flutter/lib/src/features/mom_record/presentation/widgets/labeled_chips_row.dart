import 'package:flutter/material.dart';

class LabeledChipsRow extends StatelessWidget {
  const LabeledChipsRow({
    super.key,
    required this.label,
    required this.chips,
  });

  final String label;
  final Widget chips;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(child: chips),
      ],
    );
  }
}
