import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

class AccountLinkPage extends ConsumerStatefulWidget {
  const AccountLinkPage({super.key});

  @override
  ConsumerState<AccountLinkPage> createState() => _AccountLinkPageState();
}

class _AccountLinkPageState extends ConsumerState<AccountLinkPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
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

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    }
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

  // アカウント連携（昇格）処理の共通メソッド
  Future<void> _linkWithCredential(AuthCredential credential) async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.linkWithCredential(credential);
        _showSuccess('アカウントの連携が完了しました！これでデータを引き継げます。');
        // 画面状態を更新するため再ビルドを促す
        setState(() {});
      }
    } on FirebaseAuthException catch (e) {
      String message = '連携に失敗しました';
      if (e.code == 'provider-already-linked') {
        message = 'このアカウントはすでに連携されています';
      } else if (e.code == 'credential-already-in-use') {
        message = 'このサインイン情報は、すでに他のデータで使用されています。別のアカウントを連携してください。';
      } else if (e.code == 'email-already-in-use') {
        message = 'このメールアドレスはすでに使用されています。';
      } else if (e.code == 'invalid-credential') {
        message = '無効な認証情報です';
      }
      _showError(message);
    } catch (e) {
      _showError('連携に失敗しました: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // メールアドレスでアカウントを連携（昇格）
  Future<void> _handleEmailLink() async {
    if (!_formKey.currentState!.validate()) return;

    final credential = EmailAuthProvider.credential(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    await _linkWithCredential(credential);
  }

  // Googleで連携（昇格）
  Future<void> _linkWithGoogle() async {
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
      await _linkWithCredential(credential);
    } catch (e) {
      _showError('Google連携に失敗しました: $e');
    }
  }

  // Appleで連携（昇格）
  Future<void> _linkWithApple() async {
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
      await _linkWithCredential(credential);
    } catch (e) {
      _showError('Apple連携に失敗しました: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isAnonymous = user?.isAnonymous ?? true;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: const Text('機種変更・データ引き継ぎ'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: isAnonymous
                    ? _buildAnonymousLinkView(theme)
                    : _buildLinkedUserView(theme, user),
              ),
      ),
    );
  }

  // 1. 匿名ユーザー用の「アカウント連携（昇格）」画面
  Widget _buildAnonymousLinkView(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // インフォメーションカード
        Card(
          color: context.infoBoxBackground,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: context.infoBoxAccent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '現在、この端末の一時的なデータ（匿名アカウント）として育児記録が保存されています。\n\nメールアドレスやSNSアカウントを連携（作成）することで、スマホの故障や機種変更時にも同じデータを安全に引き継ぐことができます。',
                    style: TextStyle(
                      color: context.infoBoxText,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        Text(
          '引き継ぎアカウントの作成',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        // メールアドレスでの連携フォーム
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'メールアドレスを入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'パスワード（6文字以上）',
                  border: const OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  }
                  if (value.length < 6) {
                    return '6文字以上で入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _handleEmailLink,
                  style: FilledButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'メールアドレスで連携する',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  Text('または', style: TextStyle(color: context.textSecondary)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),

        // Google連携ボタン
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: _linkWithGoogle,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/google_logo.png',
                    width: 20, height: 20),
                const SizedBox(width: 12),
                Text(
                  'Googleアカウントで連携する',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: context.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Apple連携ボタン（iOSのみ）
        if (Platform.isIOS)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _linkWithApple,
              icon: const Icon(Icons.apple, color: Colors.white, size: 22),
              label: const Text(
                'Appleアカウントで連携する',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        const SizedBox(height: 48),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'すでにアカウントをお持ちの方',
                style: TextStyle(color: context.textSecondary, fontSize: 13),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () => context.push('/onboarding/sign-in'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: context.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'ログインしてデータを引き継ぐ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 2. すでにアカウント作成・連携済みのユーザー向け画面
  Widget _buildLinkedUserView(ThemeData theme, User? user) {
    String providerName = 'メールアドレス';
    String? email = user?.email;
    IconData providerIcon = Icons.email_outlined;

    if (user != null && user.providerData.isNotEmpty) {
      final providerId = user.providerData.first.providerId;
      if (providerId == 'google.com') {
        providerName = 'Google';
        providerIcon = Icons.g_mobiledata;
        email = user.providerData.first.email;
      } else if (providerId == 'apple.com') {
        providerName = 'Apple';
        providerIcon = Icons.apple;
        email = user.providerData.first.email;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_outline,
              color: Colors.green, size: 48),
        ),
        const SizedBox(height: 24),
        Text(
          'アカウントは正常に連携されています',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '機種変更やアプリ再インストール時も、このアカウントでログインすることでデータをいつでも復元できます。',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: context.textSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 32),

        // 現在のアカウント情報カード
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(providerIcon, size: 36, color: context.primaryColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '連携方式: $providerName',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (email != null && email.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                              color: context.textSecondary, fontSize: 14),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
