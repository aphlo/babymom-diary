import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/firebase/household_service.dart' as fbcore;
import '../../application/usecases/ensure_active_child.dart';

/// EnsureActiveChild UseCase の Provider
final ensureActiveChildProvider = Provider<EnsureActiveChild>((ref) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  return EnsureActiveChild(db);
});
