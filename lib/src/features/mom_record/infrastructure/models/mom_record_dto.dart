import 'package:cloud_firestore/cloud_firestore.dart';

class MomRecordDto {
  const MomRecordDto({
    required this.date,
    this.temperatureCelsius,
    this.lochiaAmount,
    this.lochiaColor,
    this.breastFirmness,
    this.breastPain,
    this.breastRedness,
    this.memo,
  });

  final DateTime date;
  final double? temperatureCelsius;
  final String? lochiaAmount;
  final String? lochiaColor;
  final String? breastFirmness;
  final String? breastPain;
  final String? breastRedness;
  final String? memo;

  factory MomRecordDto.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final date = _extractDate(data, doc.id, doc.reference.path);
    final temperature = _parseTemperature(
      data['temperatureCelsius'] ??
          data['temperature'] ??
          data['bodyTemperature'],
    );

    final lochia = data['lochia'];
    final lochiaAmount =
        lochia is Map<String, dynamic> ? _readString(lochia['amount']) : null;
    final lochiaColor =
        lochia is Map<String, dynamic> ? _readString(lochia['color']) : null;

    final breast = data['breast'];
    final breastFirmness =
        breast is Map<String, dynamic> ? _readString(breast['firmness']) : null;
    final breastPain =
        breast is Map<String, dynamic> ? _readString(breast['pain']) : null;
    final breastRedness =
        breast is Map<String, dynamic> ? _readString(breast['redness']) : null;

    return MomRecordDto(
      date: date,
      temperatureCelsius: temperature,
      lochiaAmount: lochiaAmount,
      lochiaColor: lochiaColor,
      breastFirmness: breastFirmness,
      breastPain: breastPain,
      breastRedness: breastRedness,
      memo: _readString(data['memo'] ?? data['note']),
    );
  }

  Map<String, Object?> toFirestoreMap() {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final payload = <String, Object?>{
      'date': Timestamp.fromDate(normalizedDate),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (temperatureCelsius != null) {
      payload['temperatureCelsius'] = temperatureCelsius;
    } else {
      payload['temperatureCelsius'] = FieldValue.delete();
    }

    final lochiaMap = _buildLochiaMap();
    payload['lochia'] = lochiaMap ?? FieldValue.delete();

    final breastMap = _buildBreastMap();
    payload['breast'] = breastMap ?? FieldValue.delete();

    final trimmedMemo = memo?.trim();
    if (trimmedMemo != null && trimmedMemo.isNotEmpty) {
      payload['memo'] = trimmedMemo;
    } else {
      payload['memo'] = FieldValue.delete();
    }

    return payload;
  }

  Map<String, Object?>? _buildLochiaMap() {
    if (lochiaAmount == null || lochiaColor == null) {
      return null;
    }
    return <String, Object?>{
      'amount': lochiaAmount,
      'color': lochiaColor,
    };
  }

  Map<String, Object?>? _buildBreastMap() {
    if (breastFirmness == null || breastPain == null || breastRedness == null) {
      return null;
    }
    return <String, Object?>{
      'firmness': breastFirmness,
      'pain': breastPain,
      'redness': breastRedness,
    };
  }
}

double? _parseTemperature(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is num) {
    return raw.toDouble();
  }
  if (raw is String) {
    final normalized = raw.trim();
    if (normalized.isEmpty) {
      return null;
    }
    return double.tryParse(normalized);
  }
  return null;
}

DateTime _extractDate(
  Map<String, dynamic> data,
  String docId,
  String docPath,
) {
  final candidates = <dynamic>[
    data['date'],
    data['recordedAt'],
    data['day'],
    data['at'],
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

  throw StateError('MomRecord document $docPath is missing a valid date.');
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
