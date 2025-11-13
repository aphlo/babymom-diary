import '../../child_record.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';

class RecordUiMapper {
  const RecordUiMapper();

  RecordItemModel toUiModel(Record record) {
    return RecordItemModel(
      id: record.id,
      type: record.type,
      at: record.at.toLocal(),
      amount: record.amount,
      note: record.note,
      excretionVolume: record.excretionVolume,
      tags: record.tags,
    );
  }

  RecordDraft toDraft(Record record) {
    return RecordDraft(
      id: record.id,
      type: record.type,
      at: record.at.toLocal(),
      amount: record.amount,
      note: record.note,
      excretionVolume: record.excretionVolume,
      tags: record.tags,
    );
  }

  Record toDomain(RecordDraft draft) {
    final resolvedId =
        _shouldReuseId(draft.id, draft.type, draft.at) ? draft.id : null;

    return Record(
      id: resolvedId,
      type: draft.type,
      at: draft.at,
      amount: draft.amount,
      note: draft.note,
      excretionVolume: draft.excretionVolume,
      tags: draft.tags,
    );
  }

  bool _shouldReuseId(String? id, RecordType type, DateTime at) {
    if (id == null) {
      return false;
    }
    if (id.length < 16) {
      return false;
    }
    if (id[4] != '-' || id[7] != '-' || id[10] != '-') {
      return false;
    }
    final prefix = _buildIdPrefix(type, at);
    return id.startsWith('$prefix-');
  }

  String _buildIdPrefix(RecordType type, DateTime at) {
    final month = at.month.toString().padLeft(2, '0');
    final day = at.day.toString().padLeft(2, '0');
    final hour = at.hour.toString().padLeft(2, '0');
    return '${at.year.toString().padLeft(4, '0')}-$month-$day-$hour-${type.name}';
  }
}
