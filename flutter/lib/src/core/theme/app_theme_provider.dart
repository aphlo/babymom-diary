import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/menu/children/application/child_color_provider.dart';
import '../../features/menu/children/application/children_local_provider.dart';
import '../../features/menu/children/application/children_stream_provider.dart';
import '../../features/menu/children/application/selected_child_provider.dart';
import '../../features/menu/children/application/selected_child_snapshot_provider.dart';
import '../../features/menu/children/domain/entities/child_summary.dart';
import '../preferences/shared_preferences_provider.dart';
import 'app_colors.dart';
import 'app_theme.dart';

final appThemeProvider = Provider.family<ThemeData, String>((ref, householdId) {
  const fallbackColor = AppColors.primary;

  final prefs = ref.watch(sharedPreferencesProvider);

  ChildSummary? selectedSummary;
  Color? selectedColor;

  final storedSnapshotRaw =
      prefs.getString(SelectedChildSnapshotNotifier.prefsKey(householdId));
  if (storedSnapshotRaw != null) {
    selectedSummary = decodeSelectedChildSnapshot(storedSnapshotRaw);
  }

  ChildSummary? findById(List<ChildSummary> list, String id) {
    for (final child in list) {
      if (child.id == id) return child;
    }
    return null;
  }

  final selectedChildAsync = ref.watch(selectedChildControllerProvider);
  final selectedId = selectedChildAsync.value;

  final localChildrenState = ref.watch(childrenLocalProvider(householdId));
  final localChildren = localChildrenState.value;
  if (selectedId != null && localChildren != null) {
    selectedSummary = findById(localChildren, selectedId);
  }

  final snapshotState = ref.watch(selectedChildSnapshotProvider(householdId));
  final snapshot = snapshotState.value;
  if (selectedSummary == null) {
    if (selectedId != null && snapshot != null && snapshot.id == selectedId) {
      selectedSummary = snapshot;
    } else if (selectedId == null && snapshot != null) {
      selectedSummary = snapshot;
    }
  }

  final streamChildrenState = ref.watch(childrenStreamProvider(householdId));
  final streamChildren = streamChildrenState.value;
  if (selectedSummary == null && selectedId != null && streamChildren != null) {
    selectedSummary = findById(streamChildren, selectedId);
  }

  // SharedPreferencesから色を取得
  if (selectedSummary != null) {
    selectedColor = ref
        .read(childColorProvider.notifier)
        .getColor(selectedSummary.id, defaultColor: fallbackColor);
  }

  return buildTheme(childColor: selectedColor ?? fallbackColor);
});
