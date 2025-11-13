import 'package:cloud_firestore/cloud_firestore.dart';

class MomDiaryDto {
  const MomDiaryDto({
    required this.date,
    this.content,
  });

  final DateTime date;
  final String? content;

  factory MomDiaryDto.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final date = _extractDate(data, doc.id, doc.reference.path);
    final content =
        _readString(data['content'] ?? data['memo'] ?? data['note']);
    return MomDiaryDto(
      date: date,
      content: content,
    );
  }

  Map<String, Object?> toFirestoreMap() {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final payload = <String, Object?>{
      'date': Timestamp.fromDate(normalizedDate),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final trimmedContent = content?.trim();
    if (trimmedContent != null && trimmedContent.isNotEmpty) {
      payload['content'] = trimmedContent;
    } else {
      payload['content'] = FieldValue.delete();
    }
    return payload;
  }
}

DateTime _extractDate(
  Map<String, dynamic> data,
  String docId,
  String docPath,
) {
  final candidates = <dynamic>[
    data['date'],
    data['day'],
    data['at'],
    data['createdAt'],
  ].where((value) => value != null);

  for (final candidate in candidates) {
    final parsed = _parseDate(candidate);
    if (parsed != null) {
      return _normalizeDate(parsed);
    }
  }

  final fromId = _parseDate(docId);
  if (fromId != null) {
    return _normalizeDate(fromId);
  }

  throw StateError('MomDiary document $docPath is missing a valid date.');
}

DateTime? _parseDate(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is Timestamp) {
    return raw.toDate();
  }
  if (raw is DateTime) {
    return raw;
  }
  if (raw is String) {
    final normalized = raw.trim();
    if (normalized.isEmpty) {
      return null;
    }
    final parsed = DateTime.tryParse(normalized);
    if (parsed != null) {
      return parsed;
    }
    final replaced = normalized.replaceAll('/', '-');
    if (replaced != normalized) {
      final fallback = DateTime.tryParse(replaced);
      if (fallback != null) {
        return fallback;
      }
    }
  }
  return null;
}

DateTime _normalizeDate(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

String? _readString(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is String) {
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
  return raw.toString();
}
