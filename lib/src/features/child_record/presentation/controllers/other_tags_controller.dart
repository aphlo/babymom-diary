import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart';

class OtherTagsController extends AsyncNotifier<List<String>> {
  static const collectionName = 'tags';

  CollectionReference<Map<String, dynamic>> _collection(
    FirebaseFirestore db,
    String householdId,
  ) {
    return db
        .collection('households')
        .doc(householdId)
        .collection(collectionName);
  }

  @override
  Future<List<String>> build() async {
    final db = ref.watch(firebaseFirestoreProvider);
    final householdId = await ref.watch(currentHouseholdIdProvider.future);
    final snap = await _collection(db, householdId).orderBy('name').get();
    final tags = snap.docs
        .map((doc) => (doc.data()['name'] as String?)?.trim())
        .whereType<String>()
        .where((name) => name.isNotEmpty)
        .toList(growable: false);
    tags.sort();
    return List.unmodifiable(tags);
  }

  Future<void> addTag(String tag) async {
    final normalized = tag.trim();
    if (normalized.isEmpty) {
      return;
    }

    final current = List.of(state.valueOrNull ?? await future);
    if (current.contains(normalized)) {
      return;
    }

    final db = ref.read(firebaseFirestoreProvider);
    final householdId = await ref.read(currentHouseholdIdProvider.future);
    final col = _collection(db, householdId);

    try {
      await col.doc(normalized).set({
        'name': normalized,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      current.add(normalized);
      current.sort();
      state = AsyncData(List.unmodifiable(current));
    } catch (err, stackTrace) {
      state = AsyncError(err, stackTrace);
      rethrow;
    }
  }

  Future<void> removeTag(String tag) async {
    final current = List.of(state.valueOrNull ?? await future);
    if (!current.contains(tag)) {
      return;
    }

    final db = ref.read(firebaseFirestoreProvider);
    final householdId = await ref.read(currentHouseholdIdProvider.future);
    final col = _collection(db, householdId);

    try {
      await col.doc(tag).delete();
      current.remove(tag);
      state = AsyncData(List.unmodifiable(current));
    } catch (err, stackTrace) {
      state = AsyncError(err, stackTrace);
      rethrow;
    }
  }
}

final otherTagsControllerProvider =
    AsyncNotifierProvider<OtherTagsController, List<String>>(
  OtherTagsController.new,
);
