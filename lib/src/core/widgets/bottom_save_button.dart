import 'package:flutter/material.dart';

/// Bottom navigation bar with a save button
///
/// This widget provides a consistent save button design across the app.
/// It's based on ChildForm's save button style (FilledButton.icon).
///
/// Example:
/// ```dart
/// Scaffold(
///   body: ...,
///   bottomNavigationBar: BottomSaveButton(
///     onPressed: _handleSave,
///     isLoading: _isSubmitting,
///   ),
/// )
/// ```
class BottomSaveButton extends StatelessWidget {
  const BottomSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = '保存',
    this.icon,
  });

  /// Callback when the button is pressed.
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// Whether to show loading indicator instead of the icon/label
  final bool isLoading;

  /// Button label text
  final String label;

  /// Button icon (defaults to Icons.save)
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: isLoading ? null : onPressed,
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(icon ?? Icons.save),
            label: Text(label),
          ),
        ),
      ),
    );
  }
}

/// Bottom save button specifically for forms that don't use bottomNavigationBar
///
/// This is a simpler version without SafeArea padding, suitable for inline use.
class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = '保存',
    this.icon,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon ?? Icons.save),
        label: Text(label),
      ),
    );
  }
}
