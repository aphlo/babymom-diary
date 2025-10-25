import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/calendar/infrastructure/repositories/calendar_event_repository_impl.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/sources/calendar_event_firestore_data_source.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_event_repository.dart';

import '../../../core/firebase/household_service.dart' as fbcore;

final _firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => ref.watch(fbcore.firebaseFirestoreProvider),
);

final _calendarEventRemoteDataSourceProvider =
    Provider<CalendarEventFirestoreDataSource>((ref) {
  final firestore = ref.watch(_firebaseFirestoreProvider);
  return CalendarEventFirestoreDataSource(firestore);
});

final calendarEventRepositoryProvider =
    Provider<CalendarEventRepository>((ref) {
  final remote = ref.watch(_calendarEventRemoteDataSourceProvider);
  return CalendarEventRepositoryImpl(remote: remote);
});
