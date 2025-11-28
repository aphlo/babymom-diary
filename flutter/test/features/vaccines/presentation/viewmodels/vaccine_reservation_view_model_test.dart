import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/vaccine_reservation_state.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_record_type.dart';

void main() {
  group('VaccineReservationState', () {
    test('初期状態が正しい', () {
      const state = VaccineReservationState();
      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.primaryVaccine, isNull);
      expect(state.scheduledDate, isNull);
      expect(state.recordType, VaccineRecordType.scheduled);
    });

    test(
        'canSubmitはprimaryVaccine, primaryDoseNumber, scheduledDateが全て設定されている場合のみtrue',
        () {
      const state = VaccineReservationState();
      expect(state.canSubmit, false);
    });

    test('copyWithでscheduledDateを設定できる', () {
      const state = VaccineReservationState();
      final date = DateTime(2024, 3, 15);
      final updated = state.copyWith(scheduledDate: date);
      expect(updated.scheduledDate, date);
    });

    test('copyWithでrecordTypeを変更できる', () {
      const state = VaccineReservationState();
      final updated = state.copyWith(recordType: VaccineRecordType.completed);
      expect(updated.recordType, VaccineRecordType.completed);
    });

    test('copyWithでisAccordionExpandedを切り替えできる', () {
      const state = VaccineReservationState();
      expect(state.isAccordionExpanded, false);
      final updated = state.copyWith(isAccordionExpanded: true);
      expect(updated.isAccordionExpanded, true);
    });

    test('clearErrorでエラーをクリアできる', () {
      const state = VaccineReservationState(
        error: 'some error',
        isDuplicateError: true,
      );
      final cleared = state.clearError();
      expect(cleared.error, isNull);
      expect(cleared.isDuplicateError, false);
    });
  });
}
