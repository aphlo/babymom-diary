import 'package:flutter/material.dart';

class AddEventDateTimeRow extends StatelessWidget {
  const AddEventDateTimeRow({
    required this.label,
    required this.dateLabel,
    required this.onDateTap,
    this.timeLabel,
    this.onTimeTap,
    super.key,
  });

  final String label;
  final String dateLabel;
  final VoidCallback onDateTap;
  final String? timeLabel;
  final VoidCallback? onTimeTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showTime = timeLabel != null && onTimeTap != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _PickerButton(
                label: dateLabel,
                icon: Icons.event,
                onTap: onDateTap,
              ),
            ),
            if (showTime) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _PickerButton(
                  label: timeLabel!,
                  icon: Icons.timer,
                  onTap: onTimeTap!,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _PickerButton extends StatelessWidget {
  const _PickerButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
