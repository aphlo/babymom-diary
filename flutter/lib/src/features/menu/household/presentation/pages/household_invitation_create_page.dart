import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../application/usecases/create_invitation.dart';
import '../../domain/entities/invitation.dart';
import '../../domain/errors/invitation_errors.dart'
    show InvitationException, InvitationPermissionDeniedException;
import '../providers/invitation_providers.dart';
import '../widgets/invitation_loading_dialog.dart';

class HouseholdInvitationCreatePage extends ConsumerStatefulWidget {
  const HouseholdInvitationCreatePage({super.key});

  @override
  ConsumerState<HouseholdInvitationCreatePage> createState() =>
      _HouseholdInvitationCreatePageState();
}

class _HouseholdInvitationCreatePageState
    extends ConsumerState<HouseholdInvitationCreatePage> {
  CreateInvitationResult? _createdInvitation;
  bool _isProcessing = false;
  bool _loadingDialogVisible = false;

  @override
  Widget build(BuildContext context) {
    final householdIdAsync = ref.watch(currentHouseholdIdProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('招待コードを発行'),
      ),
      body: SafeArea(
        child: householdIdAsync.when(
          data: (householdId) => _buildContent(householdId),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('エラー: $error')),
        ),
      ),
    );
  }

  Widget _buildContent(String householdId) {
    final pendingInvitations =
        ref.watch(pendingInvitationsProvider(householdId));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCreateInvitationSection(householdId),
        const SizedBox(height: 24),
        _buildPendingInvitationsSection(pendingInvitations),
      ],
    );
  }

  Widget _buildCreateInvitationSection(String householdId) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('招待コードを発行', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text(
              '新しい招待コードを発行します。コードは24時間有効です。',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed:
                  _isProcessing ? null : () => _createInvitation(householdId),
              icon: const Icon(Icons.add),
              label: const Text('新しい招待コードを発行'),
            ),
            if (_createdInvitation != null) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text('招待コードを発行しました',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      _createdInvitation!.code,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyCode(_createdInvitation!.code),
                    tooltip: 'コピー',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '有効期限: ${_formatDateTime(_createdInvitation!.expiresAt)}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPendingInvitationsSection(
    AsyncValue<List<Invitation>> pendingInvitations,
  ) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('有効な招待コード', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            pendingInvitations.when(
              data: (invitations) {
                if (invitations.isEmpty) {
                  return const Text(
                    '現在有効な招待コードはありません',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                return Column(
                  children: invitations
                      .map((invitation) => _buildInvitationCard(invitation))
                      .toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('読み込みエラー: $error'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvitationCard(Invitation invitation) {
    final remainingTime = invitation.expiresAt.difference(DateTime.now());
    final hours = remainingTime.inHours;
    final minutes = remainingTime.inMinutes % 60;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    invitation.code,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '残り $hours時間$minutes分',
                    style: TextStyle(
                      color: hours < 1 ? Colors.orange : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '作成日時: ${_formatDateTime(invitation.createdAt)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => _copyCode(invitation.code),
              tooltip: 'コピー',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createInvitation(String householdId) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);
    _showLoadingDialog();
    try {
      final createInvitation = ref.read(createInvitationUseCaseProvider);
      final result = await createInvitation(householdId);
      if (!mounted) return;
      setState(() => _createdInvitation = result);
    } on InvitationPermissionDeniedException {
      _showError('招待コードの作成権限がありません');
    } on InvitationException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('招待コードの発行に失敗しました: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
      _hideLoadingDialog();
    }
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('コードをコピーしました')),
    );
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

String _formatDateTime(DateTime dateTime) {
  final local = dateTime.toLocal();
  return '${local.year}/${local.month}/${local.day} '
      '${local.hour.toString().padLeft(2, '0')}:'
      '${local.minute.toString().padLeft(2, '0')}';
}
