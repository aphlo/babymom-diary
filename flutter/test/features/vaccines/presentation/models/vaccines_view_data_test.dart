import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_requirement.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/models/vaccine_info.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/models/vaccines_view_data.dart';

void main() {
  group('VaccinesViewData', () {
    test('初期状態が正しい', () {
      const viewData = VaccinesViewData(
        periodLabels: ['2ヶ月', '3ヶ月', '4ヶ月'],
        vaccines: [],
      );

      expect(viewData.periodLabels.length, 3);
      expect(viewData.vaccines, isEmpty);
      expect(viewData.version, isNull);
      expect(viewData.publishedAt, isNull);
      expect(viewData.recordsByVaccine, isEmpty);
    });

    test('全てのフィールドを指定できる', () {
      final now = DateTime(2024, 3, 15);
      final record = VaccinationRecord(
        vaccineId: 'hib',
        vaccineName: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
        doses: const [],
        createdAt: now,
        updatedAt: now,
      );

      final viewData = VaccinesViewData(
        periodLabels: const ['2ヶ月'],
        vaccines: const [],
        version: '1.0.0',
        publishedAt: now,
        recordsByVaccine: {'hib': record},
      );

      expect(viewData.version, '1.0.0');
      expect(viewData.publishedAt, now);
      expect(viewData.recordsByVaccine['hib'], record);
    });

    test('periodLabelsは正しく保持される', () {
      const viewData = VaccinesViewData(
        periodLabels: ['2ヶ月', '3ヶ月'],
        vaccines: [],
      );

      expect(viewData.periodLabels.length, 2);
      expect(viewData.periodLabels[0], '2ヶ月');
      expect(viewData.periodLabels[1], '3ヶ月');
    });
  });

  group('VaccineInfo', () {
    test('初期状態が正しい', () {
      const info = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
      );

      expect(info.id, 'hib');
      expect(info.name, 'ヒブ');
      expect(info.category, VaccineCategory.inactivated);
      expect(info.requirement, VaccineRequirement.mandatory);
      expect(info.doseSchedules, isEmpty);
      expect(info.periodHighlights, isEmpty);
      expect(info.highlightPalette, VaccineHighlightPalette.primary);
      expect(info.notes, isEmpty);
      expect(info.doseStatuses, isEmpty);
      expect(info.doseDisplayOverrides, isEmpty);
    });

    test('doseStatusesを含むVaccineInfoを作成できる', () {
      const info = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
        doseStatuses: {
          1: DoseStatus.completed,
          2: DoseStatus.scheduled,
          3: null,
        },
      );

      expect(info.doseStatuses[1], DoseStatus.completed);
      expect(info.doseStatuses[2], DoseStatus.scheduled);
      expect(info.doseStatuses[3], isNull);
    });

    test('doseDisplayOverridesを含むVaccineInfoを作成できる', () {
      const info = VaccineInfo(
        id: 'influenza_injection',
        name: 'インフルエンザ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.optional,
        doseDisplayOverrides: {
          1: '1歳1回目',
          2: '1歳2回目',
        },
      );

      expect(info.doseDisplayOverrides[1], '1歳1回目');
      expect(info.doseDisplayOverrides[2], '1歳2回目');
    });

    test('notesを含むVaccineInfoを作成できる', () {
      const info = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
        notes: [
          VaccineGuidelineNote(message: '注意事項1'),
          VaccineGuidelineNote(message: '注意事項2'),
        ],
      );

      expect(info.notes.length, 2);
      expect(info.notes[0].message, '注意事項1');
      expect(info.notes[1].message, '注意事項2');
    });

    test('doseSchedulesを含むVaccineInfoを作成できる', () {
      const info = VaccineInfo(
        id: 'hib',
        name: 'ヒブ',
        category: VaccineCategory.inactivated,
        requirement: VaccineRequirement.mandatory,
        doseSchedules: {
          '2ヶ月': [1],
          '3ヶ月': [2],
          '4ヶ月': [3],
          '12ヶ月': [4],
        },
      );

      expect(info.doseSchedules['2ヶ月'], [1]);
      expect(info.doseSchedules['3ヶ月'], [2]);
      expect(info.doseSchedules['12ヶ月'], [4]);
    });
  });

  group('VaccineGuidelineNote', () {
    test('messageを含むnoteを作成できる', () {
      const note = VaccineGuidelineNote(message: 'テストメッセージ');
      expect(note.message, 'テストメッセージ');
    });
  });

  group('VaccineHighlightPalette', () {
    test('primary と secondary が存在する', () {
      expect(VaccineHighlightPalette.values.length, 2);
      expect(VaccineHighlightPalette.primary.name, 'primary');
      expect(VaccineHighlightPalette.secondary.name, 'secondary');
    });
  });
}
