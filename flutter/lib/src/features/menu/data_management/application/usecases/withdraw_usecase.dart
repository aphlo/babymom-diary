import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// アカウント退会処理を行うユースケース
class WithdrawUseCase {
  WithdrawUseCase(this._auth, this._functions);

  final FirebaseAuth _auth;
  final FirebaseFunctions _functions;

  Future<void> execute() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('ログインしていません。');
    }

    // 1. Cloud Functions の `delete-account` を呼び出してFirestoreデータをクリーンアップ
    final callable = _functions.httpsCallable('delete-account');
    await callable.call<void>();

    // 2. Firebase Authenticationからユーザーアカウントを物理削除
    await user.delete();
  }
}
