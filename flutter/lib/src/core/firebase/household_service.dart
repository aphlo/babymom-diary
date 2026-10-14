import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'household_service.g.dart';

// Core Firebase providers
@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
FirebaseFunctions firebaseFunctions(Ref ref) {
  return FirebaseFunctions.instanceFor(region: 'asia-northeast1');
}

class HouseholdService {
  HouseholdService(this._auth, this._db, this._functions);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseFunctions _functions;

  DocumentReference<Map<String, dynamic>> _userRef(String uid) {
    return _db.collection('users').doc(uid);
  }

  // Server verification prevents legacy profile fields from becoming authority.
  Future<String> ensureHousehold() async {
    if (_auth.currentUser == null) throw StateError('User is not signed in.');
    final result = await _functions
        .httpsCallable('create-household')
        .call<Map<String, dynamic>>();
    return result.data['householdId'] as String;
  }

  Future<String?> findExistingHouseholdForCurrentUser() async {
    if (_auth.currentUser == null) return null;
    return ensureHousehold();
  }

  Future<String> createHouseholdForCurrentUser() => ensureHousehold();

  // Get membership type for current user
  Future<String?> getMembershipType() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final userSnap = await _userRef(uid).get();
    if (!userSnap.exists) return null;

    return userSnap.data()?['membershipType'] as String?;
  }
}

// Household id provider: ensures household membership exists
@Riverpod(keepAlive: true)
HouseholdService householdService(Ref ref) {
  return HouseholdService(
    ref.watch(firebaseAuthProvider),
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseFunctionsProvider),
  );
}

/// Provider for initial household ID (used at app startup)
/// This ensures a household exists and returns its ID synchronously after initial load
@Riverpod(keepAlive: true)
Future<String> initialHouseholdId(Ref ref) async {
  final svc = ref.watch(householdServiceProvider);
  return svc.ensureHousehold();
}

@Riverpod(keepAlive: true)
Stream<User?> authState(Ref ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
}

/// ユーザードキュメントのデータ（householdId + membershipType）
class UserDocumentData {
  final String? activeHouseholdId;
  final String? membershipType;

  const UserDocumentData({
    this.activeHouseholdId,
    this.membershipType,
  });
}

/// users/{uid}ドキュメントを単一のStreamで購読するプロバイダー
/// 複数のプロバイダーで同じドキュメントを購読しないよう統合
@Riverpod(keepAlive: true)
Stream<UserDocumentData> userDocumentStream(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final user = ref.watch(authStateProvider).value;
  final uid = user?.uid;

  if (uid == null) {
    return Stream.value(const UserDocumentData());
  }

  return firestore.collection('users').doc(uid).snapshots().map((snapshot) {
    final data = snapshot.data();
    return UserDocumentData(
      activeHouseholdId: data?['activeHouseholdId'] as String?,
      membershipType: data?['membershipType'] as String?,
    );
  });
}

/// Provider that derives activeHouseholdId from the shared user document stream
/// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener
@Riverpod(keepAlive: true)
Future<String> currentHouseholdId(Ref ref) async {
  final userDoc = await ref.watch(userDocumentStreamProvider.future);
  if (userDoc.activeHouseholdId != null) {
    return userDoc.activeHouseholdId!;
  }

  // 世帯IDがまだ設定されていない過渡期（ログイン直後など）は、
  // 未完了のFutureを返して、次のデータ同期（再ビルド）を待機する
  return Completer<String>().future;
}

/// Provider that derives membershipType from the shared user document stream
/// Uses select to avoid Stream-of-Streams while sharing the single Firestore listener
@Riverpod(keepAlive: true)
Future<String?> currentMembershipType(Ref ref) async {
  final userDoc = await ref.watch(userDocumentStreamProvider.future);
  return userDoc.membershipType;
}
