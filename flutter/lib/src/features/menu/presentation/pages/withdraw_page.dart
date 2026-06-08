import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/features/menu/data_management/application/providers/data_management_providers.dart';

class WithdrawPage extends ConsumerStatefulWidget {
  const WithdrawPage({super.key});

  @override
  ConsumerState<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends ConsumerState<WithdrawPage> {
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // Appleサインイン用 nonce 生成
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: context.errorText,
        ),
      );
    }
  }

  // 再認証後に退会処理を実行する
  Future<void> _performWithdrawal(AuthCredential? credential) async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw StateError('ログインしていません。');
      }

      // 1. メール/Google/Appleの場合、再認証を実行
      if (credential != null) {
        await user.reauthenticateWithCredential(credential);
      }

      // 2. ユースケースを実行（Functionsでのデータクリーンアップ ＆ Auth削除）
      final withdrawUseCase = ref.read(withdrawUseCaseProvider);
      await withdrawUseCase.execute();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('退会処理が完了しました。ご利用ありがとうございました。'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '退会に失敗しました';
      if (e.code == 'wrong-password') {
        message = 'パスワードが正しくありません';
      } else if (e.code == 'user-mismatch') {
        message = '認証されたユーザーが一致しません';
      } else if (e.code == 'requires-recent-login') {
        message = 'セキュリティ保護のため、もう一度ログインし直してからお試しください';
      } else if (e.code == 'invalid-credential') {
        message = '認証情報が無効です';
      }
      _showError(message);
    } catch (e) {
      _showError('退会に失敗しました: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Googleでの再認証
  Future<void> _withdrawWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId: FirebaseAuth.instance.app.options.iosClientId,
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // キャンセル時

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _performWithdrawal(credential);
    } catch (e) {
      _showError('Googleでの再認証に失敗しました: $e');
    }
  }

  // Appleでの再認証
  Future<void> _withdrawWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await _performWithdrawal(credential);
    } catch (e) {
      _showError('Appleでの再認証に失敗しました: $e');
    }
  }

  // メールアドレスとパスワードでの再認証ダイアログ
  Future<void> _withdrawWithEmailAndPassword(String email) async {
    _passwordController.clear();
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('パスワードの入力'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('セキュリティのため、パスワードを入力してください。'),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('退会する'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      _showError('パスワードを入力してください');
      return;
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await _performWithdrawal(credential);
  }

  // 匿名ユーザーの即時退会（再認証不要）
  Future<void> _withdrawAnonymous() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('アカウントの完全削除'),
          content: const Text('匿名アカウントのため再認証は不要です。\n本当に退会（全データの削除）を行いますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('退会する'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _performWithdrawal(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isAnonymous = user?.isAnonymous ?? true;
    final providerId = user != null && user.providerData.isNotEmpty
        ? user.providerData.first.providerId
        : '';
    final email = user?.email ?? '';

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: const Text('退会手続き'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('退会処理を実行しています...'),
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 警告バナー
                    Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '重要なお知らせ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Card(
                      elevation: 0,
                      color: context.cardBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: context.menuSectionBorder),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '退会時の注意事項',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: context.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildWarningItem(
                                '育児記録、予防接種スケジュール、カレンダーなど、すべてのアカウントデータが完全に削除され、復元することはできなくなります。'),
                            _buildWarningItem(
                                '世帯を共有中の場合、世帯は解散され、パートナーなどの他のメンバーも一切の世帯データにアクセスできなくなります。他のメンバーのデータも完全に削除されます。'),
                            _buildWarningItem(
                                'プレミアムプラン（有料サブスクリプション）をご契約中の場合、退会しても自動更新は解約されません。必ず事前にApp StoreまたはGoogle Playからサブスクリプションの解約手続きを行ってください。'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    if (!isAnonymous) ...[
                      Text(
                        '再認証と退会の実行',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.textPrimary,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        providerId == 'password'
                            ? '安全に退会を行うため、再認証（パスワードの入力）が必要です。ボタンを押すとパスワード入力画面が表示されます。'
                            : '安全に退会を行うため、再認証が必要です。ボタンを押すとログイン画面が表示されますので、現在連携しているアカウントで認証を行ってください。',
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ] else ...[
                      Text(
                        '退会の実行',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.textPrimary,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '下記のボタンを押すと退会処理が実行されます。この操作は取り消せません。',
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // ログイン方式に応じた再認証＆退会ボタン
                    if (isAnonymous)
                      _buildWithdrawButton(
                        text: '退会してデータを完全に削除する',
                        color: Colors.red,
                        onPressed: _withdrawAnonymous,
                      )
                    else if (providerId == 'google.com')
                      _buildWithdrawButton(
                        text: 'Googleアカウントで再認証して退会する',
                        color: Colors.red,
                        onPressed: _withdrawWithGoogle,
                        icon: Image.asset('assets/icons/google_logo.png',
                            width: 20, height: 20),
                      )
                    else if (providerId == 'apple.com')
                      _buildWithdrawButton(
                        text: 'Appleアカウントで再認証して退会する',
                        color: Colors.black,
                        onPressed: _withdrawWithApple,
                        icon: const Icon(Icons.apple,
                            color: Colors.white, size: 22),
                      )
                    else
                      _buildWithdrawButton(
                        text: 'パスワードを入力して退会する',
                        color: Colors.red,
                        onPressed: () => _withdrawWithEmailAndPassword(email),
                        icon: const Icon(Icons.password, color: Colors.white),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: context.textSecondary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    Widget? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon,
              label: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
    );
  }
}
