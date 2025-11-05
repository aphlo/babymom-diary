import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/menu/children/application/children_local_provider.dart';
import '../../features/menu/children/application/children_stream_provider.dart';
import '../../features/menu/children/application/selected_child_provider.dart';
import '../../features/menu/children/application/selected_child_snapshot_provider.dart';
import '../../features/menu/children/domain/entities/child_summary.dart';
import '../preferences/shared_preferences_provider.dart';
import 'app_theme.dart';

final appThemeProvider = Provider.family<ThemeData, String>((ref, householdId) {
  const fallbackColor = defaultPrimaryColor;

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

  Color? parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    final cleaned = hex.replaceFirst('#', '').padLeft(6, '0');
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return null;
    return Color(0xFF000000 | value);
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

  selectedColor = parseColor(selectedSummary?.color);

  return buildTheme(primaryColor: selectedColor ?? fallbackColor);
});
