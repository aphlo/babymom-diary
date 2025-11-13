import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core Firebase providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

class HouseholdService {
  HouseholdService(this._auth, this._db);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  // Find an existing household where current user is a member
  Future<String?> findExistingHouseholdForCurrentUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final snap = await _db
        .collectionGroup('members')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get()
        .catchError((e, _) {
      throw Exception('Membership query failed for uid=$uid: $e');
    });
    if (snap.docs.isEmpty) return null;
    final doc = snap.docs.first;
    final hid = doc.reference.parent.parent!.id;
    return hid;
  }

  // Create a new household and add current user as admin member
  Future<String> createHouseholdForCurrentUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw StateError('User is not signed in.');
    }
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

  // -------- Invite / Join (no Functions) --------
  static String _randomTokenId([int bytes = 16]) {
    final r = Random.secure();
    final b = List<int>.generate(bytes, (_) => r.nextInt(256));
    return base64UrlEncode(b).replaceAll('=', '');
  }

  static String sixDigitCode() {
    final r = Random.secure().nextInt(900000) + 100000;
    return r.toString();
  }

  Future<({String tokenId, String? code, DateTime expireAt})> createJoinToken({
    required String householdId,
    bool withCode = true,
    Duration ttl = const Duration(minutes: 10),
  }) async {
    final uid = _auth.currentUser!.uid;
    final tokenId = _randomTokenId();
    final code = withCode ? sixDigitCode() : null;
    final expireAt = DateTime.now().add(ttl);

    final tRef = _db
        .collection('households')
        .doc(householdId)
        .collection('joinTokens')
        .doc(tokenId);
    await tRef.set({
      'code': code,
      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),
      'expireAt': Timestamp.fromDate(expireAt),
    }).catchError((e, _) {
      throw Exception('Failed to create ${tRef.path}: $e');
    });

    return (tokenId: tokenId, code: code, expireAt: expireAt);
  }

  Future<void> joinWithToken({
    required String householdId,
    required String tokenId,
  }) async {
    final joinUid = _auth.currentUser!.uid;
    final mRef = _db
        .collection('households')
        .doc(householdId)
        .collection('members')
        .doc(joinUid);
    await mRef.set({
      'role': 'member',
      'joinedAt': FieldValue.serverTimestamp(),
      'joinToken': tokenId,
      'uid': joinUid,
    }).catchError((e, _) {
      throw Exception('Failed to create ${mRef.path}: $e');
    });
  }

  Future<String> joinWithCode(String inputCode) async {
    final snap = await _db
        .collectionGroup('joinTokens')
        .where('code', isEqualTo: inputCode)
        .where('expireAt', isGreaterThan: Timestamp.now())
        .limit(1)
        .get()
        .catchError((e, _) {
      throw Exception('Join code query failed: $e');
    });
    if (snap.docs.isEmpty) {
      throw Exception('コードが無効または期限切れです');
    }
    final tokenDoc = snap.docs.first;
    final tokenId = tokenDoc.id;
    final householdId = tokenDoc.reference.parent.parent!.id;
    await joinWithToken(householdId: householdId, tokenId: tokenId);
    return householdId;
  }
}

// Household id provider: ensures household membership exists
final householdServiceProvider = Provider<HouseholdService>((ref) {
  return HouseholdService(
    ref.watch(firebaseAuthProvider),
    ref.watch(firebaseFirestoreProvider),
  );
});

final currentHouseholdIdProvider = FutureProvider<String>((ref) async {
  final svc = ref.watch(householdServiceProvider);
  return svc.ensureHousehold();
});
