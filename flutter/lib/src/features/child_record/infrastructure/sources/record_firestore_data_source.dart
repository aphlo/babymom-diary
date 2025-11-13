import 'package:cloud_firestore/cloud_firestore.dart';

import '../../child_record.dart';

class RecordFirestoreDataSource {
  RecordFirestoreDataSource(this.db, this.householdId);

  final FirebaseFirestore db;
  final String householdId;

  static const collectionName = 'childRecords';

  CollectionReference<Map<String, dynamic>> _collection(String childId) => db
      .collection('households')
      .doc(householdId)
      .collection('children')
      .doc(childId)
      .collection(collectionName);

  Future<List<Record>> getForDay(String childId, DateTime day) async {
    final normalizedDay = _normalizeDay(day);
    final docId = _docIdForDay(normalizedDay);

    final snapshot = await _collection(childId).doc(docId).get();
    final data = snapshot.data();
    if (data == null) {
      return const [];
    }

    final hoursRaw = data['hours'];
    if (hoursRaw is! Map<String, dynamic>) {
      return const [];
    }

    final records = <Record>[];
    hoursRaw.forEach((hourKey, value) {
      final hour = int.tryParse(hourKey);
      if (hour == null || hour < 0 || hour > 23) {
        return;
      }
      final hourMap =
          value is Map<String, dynamic> ? value : <String, dynamic>{};
      hourMap.forEach((typeKey, rawTypeBlock) {
        if (typeKey == 'updatedAt') {
          return;
        }
        final typeBlock =
            rawTypeBlock is Map<String, dynamic> ? rawTypeBlock : null;
        if (typeBlock == null) {
          return;
        }
        final recordsMap = typeBlock['records'];
        if (recordsMap is! Map<String, dynamic>) {
          return;
        }
        recordsMap.forEach((recordId, rawRecord) {
          final recordData = rawRecord is Map<String, dynamic>
              ? rawRecord
              : <String, dynamic>{};
          final record = _recordFromFirestore(
            recordId: recordId,
            typeKey: typeKey,
            data: recordData,
            day: normalizedDay,
            hour: hour,
          );
          if (record != null) {
            records.add(record);
          }
        });
      });
    });

    records.sort((a, b) => b.at.compareTo(a.at));
    return records;
  }

  Future<void> upsert(String childId, Record record) async {
    final normalizedDay = _normalizeDay(record.at);
    final docId = _docIdForDay(normalizedDay);
    final hourKey = _formatTwoDigits(record.at.hour);
    final locator = _RecordLocator.tryParse(record.id);

    final recordData = _recordToFirestoreMap(record);
    final newDoc = _collection(childId).doc(docId);
    final batch = db.batch();

    final payload = <String, Object?>{
      'date': Timestamp.fromDate(normalizedDay),
      'updatedAt': FieldValue.serverTimestamp(),
      'hours': {
        hourKey: {
          'updatedAt': FieldValue.serverTimestamp(),
          record.type.name: {
            'updatedAt': FieldValue.serverTimestamp(),
            'records': {
              record.id: recordData,
            },
          },
        },
      },
    };

    batch.set(newDoc, payload, SetOptions(merge: true));

    final needsRelocation = locator != null &&
        (locator.docId != docId ||
            locator.hourKey != hourKey ||
            locator.typeName != record.type.name);
    if (needsRelocation) {
      final oldDoc = _collection(childId).doc(locator.docId);
      batch.set(
          oldDoc,
          {
            'updatedAt': FieldValue.serverTimestamp(),
            'hours': {
              locator.hourKey: {
                'updatedAt': FieldValue.serverTimestamp(),
                locator.typeName: {
                  'records': {
                    locator.recordId: FieldValue.delete(),
                  },
                  'updatedAt': FieldValue.serverTimestamp(),
                },
              },
            },
          },
          SetOptions(merge: true));
    }

    await batch.commit();
  }

  Future<void> delete(String childId, String id) async {
    final locator = _RecordLocator.tryParse(id);
    if (locator == null) {
      // When the identifier is malformed we simply ignore the request.
      // Callers are expected to pass IDs generated after the migration.
      return;
    }
    final doc = _collection(childId).doc(locator.docId);
    await doc.set({
      'updatedAt': FieldValue.serverTimestamp(),
      'hours': {
        locator.hourKey: {
          'updatedAt': FieldValue.serverTimestamp(),
          locator.typeName: {
            'records': {
              locator.recordId: FieldValue.delete(),
            },
            'updatedAt': FieldValue.serverTimestamp(),
          },
        },
      },
    }, SetOptions(merge: true));
  }

  Record? _recordFromFirestore({
    required String recordId,
    required String typeKey,
    required Map<String, dynamic> data,
    required DateTime day,
    required int hour,
  }) {
    final type = _parseRecordType(data, typeKey);

    DateTime? at;
    final rawAt = data['at'];
    if (rawAt is Timestamp) {
      at = rawAt.toDate();
    } else if (rawAt is DateTime) {
      at = rawAt;
    }
    at ??= DateTime(day.year, day.month, day.day, hour);
    at = at.toLocal();

    ExcretionVolume? excretionVolume;
    final rawVolume = data['excretionVolume'] as String?;
    if (rawVolume != null) {
      try {
        excretionVolume = ExcretionVolume.values.byName(rawVolume);
      } catch (_) {
        excretionVolume = null;
      }
    }

    final tags = (data['tags'] as List?)
            ?.whereType<String>()
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList(growable: false) ??
        const <String>[];

    return Record(
      id: recordId,
      type: type,
      at: at,
      amount: (data['amount'] as num?)?.toDouble(),
      note: data['note'] as String?,
      excretionVolume: excretionVolume,
      tags: tags,
    );
  }

  Map<String, Object?> _recordToFirestoreMap(Record record) {
    final map = <String, Object?>{
      'type': record.type.name,
      'at': Timestamp.fromDate(record.at),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (record.amount != null) {
      map['amount'] = record.amount;
    }
    if (record.note != null && record.note!.trim().isNotEmpty) {
      map['note'] = record.note;
    }
    if (record.excretionVolume != null) {
      map['excretionVolume'] = record.excretionVolume!.name;
    }
    if (record.tags.isNotEmpty) {
      map['tags'] = record.tags;
    }
    return map;
  }

  String _docIdForDay(DateTime day) {
    return '${day.year.toString().padLeft(4, '0')}-'
        '${_formatTwoDigits(day.month)}-'
        '${_formatTwoDigits(day.day)}';
  }

  DateTime _normalizeDay(DateTime day) =>
      DateTime(day.year, day.month, day.day);

  RecordType _parseRecordType(Map<String, dynamic> data, String keyTypeName) {
    final rawType = data['type'] as String? ?? keyTypeName;
    if (rawType.isEmpty) {
      return RecordType.other;
    }

    return RecordType.values.firstWhere(
      (value) => value.name == rawType,
      orElse: () => RecordType.other,
    );
  }
}

class _RecordLocator {
  const _RecordLocator({
    required this.docId,
    required this.hourKey,
    required this.typeName,
    required this.recordId,
  });

  final String docId;
  final String hourKey;
  final String typeName;
  final String recordId;

  static _RecordLocator? tryParse(String id) {
    if (id.length < 18) {
      return null;
    }
    if (id[4] != '-' || id[7] != '-' || id[10] != '-' || id[13] != '-') {
      return null;
    }

    final docId = id.substring(0, 10);
    final hourKey = id.substring(11, 13);
    final hour = int.tryParse(hourKey);
    if (hour == null || hour < 0 || hour > 23) {
      return null;
    }

    final remainder = id.substring(14);
    final separator = remainder.indexOf('-');
    if (separator <= 0) {
      return null;
    }
    final typeName = remainder.substring(0, separator);
    final unique = remainder.substring(separator + 1);
    if (hourKey.length != 2) {
      return null;
    }
    if (typeName.isEmpty || unique.isEmpty) {
      return null;
    }
    return _RecordLocator(
      docId: docId,
      hourKey: hourKey,
      typeName: typeName,
      recordId: id,
    );
  }
}

String _formatTwoDigits(int value) => value.toString().padLeft(2, '0');
