import '../../child_record.dart';
import '../models/record_draft.dart';
import '../models/record_item_model.dart';

class RecordUiMapper {
  const RecordUiMapper();

  RecordItemModel toUiModel(Record record) {
    return RecordItemModel(
      id: record.id,
      type: record.type,
      at: record.at,
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
      at: record.at,
      amount: record.amount,
      note: record.note,
      excretionVolume: record.excretionVolume,
      tags: record.tags,
    );
  }

  Record toDomain(RecordDraft draft) {
    return Record(
      id: draft.id,
      type: draft.type,
      at: draft.at,
      amount: draft.amount,
      note: draft.note,
      excretionVolume: draft.excretionVolume,
      tags: draft.tags,
    );
  }
}
