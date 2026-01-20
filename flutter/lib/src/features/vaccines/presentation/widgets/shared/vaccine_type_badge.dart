import 'package:flutter/material.dart';

class VaccineTypeBadge extends StatelessWidget {
  const VaccineTypeBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    this.fontSize = 10,
    this.fontWeight = FontWeight.w600,
    this.borderWidth = 1,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: borderWidth > 0
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foregroundColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              height: 1.1,
            ),
      ),
    );
  }
}
