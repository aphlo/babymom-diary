import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../application/usecases/create_invitation.dart';
import '../../domain/entities/invitation.dart';
import '../../domain/errors/invitation_errors.dart'
    show
        AlreadyMemberException,
        InvitationException,
        InvitationExpiredException,
        InvitationNotFoundException,
        InvitationPermissionDeniedException;
import '../providers/invitation_providers.dart';

class HouseholdSharePage extends ConsumerStatefulWidget {
  const HouseholdSharePage({super.key});

  @override
  ConsumerState<HouseholdSharePage> createState() => _HouseholdSharePageState();
}

class _HouseholdSharePageState extends ConsumerState<HouseholdSharePage> {
  CreateInvitationResult? _createdInvitation;
  final _joinCodeCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _joinCodeCtrl.dispose();
    super.dispose();
  }

  Future<void> _createInvitation() async {
    setState(() => _loading = true);
    try {
      final householdId = await ref.read(currentHouseholdIdProvider.future);
      final createInvitation = ref.read(createInvitationUseCaseProvider);
      final result = await createInvitation(householdId);
      if (!mounted) return;
      setState(() {
        _createdInvitation = result;
      });
    } on InvitationPermissionDeniedException {
      _showError('招待コードの作成権限がありません');
    } on InvitationException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('招待コードの発行に失敗しました: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
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

    setState(() => _loading = true);
    try {
      final acceptInvitation = ref.read(acceptInvitationUseCaseProvider);
      final householdId = await acceptInvitation(code);
      if (!mounted) return;

      _joinCodeCtrl.clear();
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('参加完了'),
          content: Text('世帯($householdId)への参加が完了しました'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
        setState(() => _loading = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('コードをコピーしました')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final householdIdAsync = ref.watch(currentHouseholdIdProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('世帯の共有'),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreateInvitationSection(),
          const Divider(height: 32),
          _buildPendingInvitationsSection(householdId),
          const Divider(height: 32),
          _buildJoinSection(),
        ],
      ),
    );
  }

  Widget _buildCreateInvitationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('招待コードを発行', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        const Text(
          '新しい招待コードを発行します。コードは24時間有効です。',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _createInvitation,
              icon: const Icon(Icons.add),
              label: const Text('新しい招待コードを発行'),
            ),
          ],
        ),
        if (_createdInvitation != null) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 8),
                      const Text(
                        '招待コードを発行しました',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPendingInvitationsSection(String householdId) {
    final pendingInvitations =
        ref.watch(pendingInvitationsProvider(householdId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('有効な招待コード', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        pendingInvitations.when(
          data: (invitations) {
            if (invitations.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '現在有効な招待コードはありません',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }
            return Column(
              children: invitations.map((invitation) {
                return _buildInvitationCard(invitation);
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('読み込みエラー: $error'),
        ),
      ],
    );
  }

  Widget _buildInvitationCard(Invitation invitation) {
    final remainingTime = invitation.expiresAt.difference(DateTime.now());
    final hours = remainingTime.inHours;
    final minutes = remainingTime.inMinutes % 60;

    return Card(
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

  Widget _buildJoinSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('招待コードで参加', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        const Text(
          '他の世帯から受け取った招待コードを入力して参加します。',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _joinCodeCtrl,
                decoration: const InputDecoration(
                  labelText: '招待コード',
                  hintText: 'ABC123',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.characters,
                maxLength: 6,
                enabled: !_loading,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _loading ? null : _acceptInvitation,
              child: const Text('参加'),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.year}/${local.month}/${local.day} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}
