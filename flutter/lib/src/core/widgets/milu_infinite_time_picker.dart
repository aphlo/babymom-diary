import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Shows a modal bottom sheet with an infinite scrolling time picker.
///
/// Returns the selected [TimeOfDay] or null if dismissed.
Future<TimeOfDay?> showMiluInfiniteTimePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
}) {
  return showModalBottomSheet<TimeOfDay>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _MiluInfiniteTimePicker(
      initialTime: initialTime ?? TimeOfDay.now(),
    ),
  );
}

class _MiluInfiniteTimePicker extends StatefulWidget {
  const _MiluInfiniteTimePicker({
    required this.initialTime,
  });

  final TimeOfDay initialTime;

  @override
  State<_MiluInfiniteTimePicker> createState() =>
      _MiluInfiniteTimePickerState();
}

class _MiluInfiniteTimePickerState extends State<_MiluInfiniteTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  static const double _itemExtent = 40.0;
  static const double _pickerHeight = 200.0;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
    _hourController = FixedExtentScrollController(initialItem: _selectedHour);
    _minuteController =
        FixedExtentScrollController(initialItem: _selectedMinute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          SizedBox(
            height: _pickerHeight,
            child: Row(
              children: [
                Expanded(
                  child: _buildHourPicker(),
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: _buildMinutePicker(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'キャンセル',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(
                TimeOfDay(hour: _selectedHour, minute: _selectedMinute),
              );
            },
            child: Text(
              '完了',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourPicker() {
    return CupertinoPicker(
      scrollController: _hourController,
      itemExtent: _itemExtent,
      looping: true,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        capEndEdge: false,
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          _selectedHour = index;
        });
      },
      children: List.generate(24, (index) {
        final isSelected = index == _selectedHour;
        return Center(
          child: Text(
            '$index時',
            style: TextStyle(
              fontSize: 20,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.black87,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMinutePicker() {
    return CupertinoPicker(
      scrollController: _minuteController,
      itemExtent: _itemExtent,
      looping: true,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        capStartEdge: false,
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          _selectedMinute = index;
        });
      },
      children: List.generate(60, (index) {
        final isSelected = index == _selectedMinute;
        return Center(
          child: Text(
            '$index分',
            style: TextStyle(
              fontSize: 20,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.black87,
            ),
          ),
        );
      }),
    );
  }
}
