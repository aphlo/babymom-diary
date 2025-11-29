import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/firebase/household_service.dart' as fbcore;
import '../../application/usecases/ensure_active_child.dart';

part 'ensure_active_child_provider.g.dart';

/// EnsureActiveChild UseCase の Provider
@riverpod
EnsureActiveChild ensureActiveChild(Ref ref) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  return EnsureActiveChild(db);
}
