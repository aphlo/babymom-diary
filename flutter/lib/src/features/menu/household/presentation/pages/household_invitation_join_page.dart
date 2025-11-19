import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../domain/errors/invitation_errors.dart'
    show
        AlreadyMemberException,
        InvitationException,
        InvitationExpiredException,
        InvitationNotFoundException;
import '../providers/invitation_providers.dart';
import '../widgets/invitation_loading_dialog.dart';

class HouseholdInvitationJoinPage extends ConsumerStatefulWidget {
  const HouseholdInvitationJoinPage({super.key});

  @override
  ConsumerState<HouseholdInvitationJoinPage> createState() =>
      _HouseholdInvitationJoinPageState();
}

class _HouseholdInvitationJoinPageState
    extends ConsumerState<HouseholdInvitationJoinPage> {
  final TextEditingController _joinCodeCtrl = TextEditingController();
  bool _isProcessing = false;
  bool _loadingDialogVisible = false;

  @override
  void dispose() {
    _joinCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('招待コードで参加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('招待コードを入力',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    const Text(
                      '他の世帯から受け取った招待コードを入力して参加します。',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _joinCodeCtrl,
                      decoration: const InputDecoration(
                        labelText: '招待コード',
                        hintText: 'ABC123',
                        border: OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 6,
                      enabled: !_isProcessing,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _isProcessing ? null : () => _acceptInvitation(),
                        child: const Text('参加'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _acceptInvitation() async {
    final code = _joinCodeCtrl.text.trim();
    if (code.isEmpty) {
      _showError('招待コードを入力してください');
      return;
    }
    if (code.length != 6) {
      _showError('招待コードは6桁です');
      return;
    }

    setState(() => _isProcessing = true);
    _showLoadingDialog();
    try {
      if (!mounted) return;

      final acceptInvitation = ref.read(acceptInvitationUseCaseProvider);
      await acceptInvitation(code);
      ref.invalidate(currentHouseholdIdProvider);

      if (!mounted) return;

      _joinCodeCtrl.clear();
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('参加完了'),
          content: const Text('世帯への参加が完了しました'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;

      final navigator = Navigator.of(context);
      navigator.pop();
      navigator.maybePop();
    } on InvitationNotFoundException {
      _showError('招待コードが見つかりません');
    } on InvitationExpiredException {
      _showError('招待コードの有効期限が切れています');
    } on AlreadyMemberException {
      _showError('既にこの世帯のメンバーです');
    } on InvitationException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('参加に失敗しました: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
      _hideLoadingDialog();
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showLoadingDialog() {
    if (_loadingDialogVisible || !mounted) return;
    _loadingDialogVisible = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const InvitationLoadingDialog(),
    ).then((_) {
      _loadingDialogVisible = false;
    });
  }

  void _hideLoadingDialog() {
    if (_loadingDialogVisible && mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
