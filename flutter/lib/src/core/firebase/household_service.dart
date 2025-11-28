import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core Firebase providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseFunctionsProvider = Provider<FirebaseFunctions>((ref) {
  return FirebaseFunctions.instanceFor(region: 'asia-northeast1');
});

class HouseholdService {
  HouseholdService(this._auth, this._db);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _userRef(String uid) {
    return _db.collection('users').doc(uid);
  }

  // Find an existing household where current user is a member
  // Uses users/{uid} document to determine household membership (no collectionGroup query)
  Future<String?> findExistingHouseholdForCurrentUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final userSnap = await _ensureUserDocument(uid);
    final userData = userSnap.data();

    final activeHouseholdId = userData?['activeHouseholdId'] as String?;
    final membershipType = userData?['membershipType'] as String?;

    // No household info stored - user needs to create or join a household
    if (activeHouseholdId == null || membershipType == null) {
      return null;
    }

    // Verify the household still exists and user is still a member
    final membershipRef = _db
        .collection('households')
        .doc(activeHouseholdId)
        .collection('members')
        .doc(uid);
    final membershipSnapshot = await membershipRef.get();

    if (membershipSnapshot.exists) {
      return activeHouseholdId;
    }

    // Membership no longer valid - clear the stored data
    await _clearActiveHousehold(uid);
    return null;
  }

  // Create a new household and add current user as admin member
  Future<String> createHouseholdForCurrentUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw StateError('User is not signed in.');
    }
    await _ensureUserDocument(uid);
    final hRef = _db.collection('households').doc();
    try {
      await hRef.set({
        'createdBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(
          'Failed to create ${hRef.path}: [${e.code}] ${e.message}');
    } catch (e) {
      throw Exception('Failed to create ${hRef.path}: $e');
    }

    final mRef = hRef.collection('members').doc(uid);
    try {
      await mRef.set({
        'role': 'admin',
        'displayName': '管理者',
        'joinedAt': FieldValue.serverTimestamp(),
        'joinToken': null,
        'uid': uid,
      });
    } on FirebaseException catch (e) {
      throw Exception(
          'Failed to create ${mRef.path}: [${e.code}] ${e.message}');
    } catch (e) {
      throw Exception('Failed to create ${mRef.path}: $e');
    }
    await _setActiveHousehold(
      uid: uid,
      householdId: hRef.id,
      membershipType: 'owner',
    );
    return hRef.id;
  }

  // Ensure there is at least one household and return its id
  Future<String> ensureHousehold() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw StateError('User is not signed in.');
    }
    final existing = await findExistingHouseholdForCurrentUser();
    if (existing != null) {
      return existing;
    }
    return createHouseholdForCurrentUser();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _ensureUserDocument(
      String uid) async {
    final userRef = _userRef(uid);
    final snap = await userRef.get();
    if (snap.exists) {
      return snap;
    }
    await userRef.set({
      'createdAt': FieldValue.serverTimestamp(),
    }).catchError((e, _) {
      throw Exception('Failed to create ${userRef.path}: $e');
    });
    return userRef.get();
  }

  Future<void> _setActiveHousehold({
    required String uid,
    required String householdId,
    required String membershipType,
  }) async {
    final userRef = _userRef(uid);
    await userRef.set(
      {
        'activeHouseholdId': householdId,
        'membershipType': membershipType,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    ).catchError((e, _) {
      throw Exception('Failed to update ${userRef.path}: $e');
    });
  }

  Future<void> _clearActiveHousehold(String uid) async {
    final userRef = _userRef(uid);
    await userRef.set(
      {
        'activeHouseholdId': FieldValue.delete(),
        'membershipType': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    ).catchError((e, _) {
      throw Exception('Failed to update ${userRef.path}: $e');
    });
  }

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
final householdServiceProvider = Provider<HouseholdService>((ref) {
  return HouseholdService(
    ref.watch(firebaseAuthProvider),
    ref.watch(firebaseFirestoreProvider),
  );
});

/// Provider for initial household ID (used at app startup)
/// This ensures a household exists and returns its ID synchronously after initial load
final initialHouseholdIdProvider = FutureProvider<String>((ref) async {
  final svc = ref.watch(householdServiceProvider);
  return svc.ensureHousehold();
});

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
final _userDocumentStreamProvider = StreamProvider<UserDocumentData>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final firestore = ref.watch(firebaseFirestoreProvider);
  final uid = auth.currentUser?.uid;

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
});

/// Stream provider that watches users/{uid} document for activeHouseholdId changes
/// This allows real-time updates when user joins/leaves a household
final currentHouseholdIdProvider = StreamProvider<String>((ref) {
  final userDoc = ref.watch(_userDocumentStreamProvider);

  return userDoc.when(
    data: (data) {
      if (data.activeHouseholdId == null) {
        return Stream.error(StateError('No active household found.'));
      }
      return Stream.value(data.activeHouseholdId!);
    },
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

/// Stream provider that watches users/{uid} document for membershipType changes
final currentMembershipTypeProvider = StreamProvider<String?>((ref) {
  final userDoc = ref.watch(_userDocumentStreamProvider);

  return userDoc.when(
    data: (data) => Stream.value(data.membershipType),
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});
