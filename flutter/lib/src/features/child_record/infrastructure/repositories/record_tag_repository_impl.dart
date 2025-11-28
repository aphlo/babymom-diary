import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/record_tag_repository.dart';

class RecordTagRepositoryImpl implements RecordTagRepository {
  RecordTagRepositoryImpl(this._db);

  final FirebaseFirestore _db;

  static const _tagsCollectionName = 'tags';

  CollectionReference<Map<String, dynamic>> _tagCollection(String householdId) {
    return _db
        .collection('households')
        .doc(householdId)
        .collection(_tagsCollectionName);
  }

  @override
  Future<List<String>> fetchTags(String householdId) async {
    final snap = await _tagCollection(householdId).orderBy('name').get();
    final tags = snap.docs
        .map((doc) => (doc.data()['name'] as String?)?.trim())
        .whereType<String>()
        .where((name) => name.isNotEmpty)
        .toList(growable: true);
    tags.sort();
    return List.unmodifiable(tags);
  }

  @override
  Future<void> addTag(String householdId, String tag) async {
    final normalized = tag.trim();
    if (normalized.isEmpty) return;

    await _tagCollection(householdId).doc(normalized).set({
      'name': normalized,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> removeTag(String householdId, String tag) async {
    await _tagCollection(householdId).doc(tag).delete();
  }
}
