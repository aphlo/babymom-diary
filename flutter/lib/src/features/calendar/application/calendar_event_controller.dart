import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/calendar/infrastructure/repositories/calendar_event_repository_impl.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/sources/calendar_event_firestore_data_source.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_event_repository.dart';

import '../../../core/firebase/household_service.dart' as fbcore;

part 'calendar_event_controller.g.dart';

@Riverpod(keepAlive: true)
CalendarEventFirestoreDataSource calendarEventRemoteDataSource(Ref ref) {
  final firestore = ref.watch(fbcore.firebaseFirestoreProvider);
  return CalendarEventFirestoreDataSource(firestore);
}

@Riverpod(keepAlive: true)
CalendarEventRepository calendarEventRepository(Ref ref) {
  final remote = ref.watch(calendarEventRemoteDataSourceProvider);
  return CalendarEventRepositoryImpl(remote: remote);
}
