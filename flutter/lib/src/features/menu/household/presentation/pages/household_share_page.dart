import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../../../../core/theme/semantic_colors.dart';
import '../../../../ads/application/services/banner_ad_manager.dart';
import '../../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../application/usecases/create_invitation.dart';
import '../../domain/entities/household_member.dart';
import '../../domain/errors/invitation_errors.dart';
import '../providers/invitation_providers.dart';
import '../widgets/invitation_loading_dialog.dart';

class HouseholdSharePage extends ConsumerStatefulWidget {
  const HouseholdSharePage({super.key});

  @override
  ConsumerState<HouseholdSharePage> createState() => _HouseholdSharePageState();
}

class _HouseholdSharePageState extends ConsumerState<HouseholdSharePage> {
  final TextEditingController _invitationTokenCtrl = TextEditingController();
  final TextEditingController _displayNameCtrl = TextEditingController();
  bool _isProcessing = false;
  bool _loadingDialogVisible = false;

  @override
  void dispose() {
    _invitationTokenCtrl.dispose();
    _displayNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final householdIdAsync = ref.watch(currentHouseholdIdProvider);
    final membershipTypeAsync = ref.watch(currentMembershipTypeProvider);

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('世帯の共有'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: householdIdAsync.when(
                data: (householdId) => membershipTypeAsync.when(
                  data: (membershipType) =>
                      _buildContent(householdId, membershipType),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('エラー: $error')),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('エラー: $error')),
              ),
            ),
            const BannerAdWidget(slot: BannerAdSlot.householdShare),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(String householdId, String? membershipType) {
    // If user is a member (not owner), show readonly view
    if (membershipType == 'member') {
      return _buildMemberView();
    }

    // If user is owner, show full functionality
    return _buildOwnerView(householdId);
  }

  Widget _buildMemberView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: context.cardBackground,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.group, color: context.primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '世帯を共有しています',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'あなたは他のユーザーの世帯に参加しています。\n招待コードの共有は世帯の作成者のみが行えます。',
                  style: TextStyle(color: context.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerView(String householdId) {
    final membersAsync = ref.watch(householdMembersProvider(householdId));
    final currentUid = ref.watch(firebaseAuthProvider).currentUser?.uid;

    return membersAsync.when(
      data: (members) {
        final otherMembers = members.where((m) => m.uid != currentUid).toList();
        final hasOtherMembers = otherMembers.isNotEmpty;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildInvitationSection(householdId),
            if (hasOtherMembers)
              _buildMembersSectionContent(otherMembers, householdId),
            if (!hasOtherMembers) _buildJoinInvitationSection(),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('エラー: $error')),
    );
  }

  Widget _buildInvitationSection(String householdId) {
    return Card(
      color: context.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('世帯への招待', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text(
              '招待コードは24時間・1回のみ有効です。新しく発行すると以前のコードは失効します。信頼できる相手にのみ渡してください。',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isProcessing ? null : () => _issueInvitation(householdId),
              child: const Text('招待コードを発行'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _issueInvitation(String householdId) async {
    setState(() => _isProcessing = true);
    try {
      final createInvitation = CreateInvitation(
        ref.read(firebaseFunctionsProvider),
      );
      final token = await createInvitation(householdId);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('招待コード'),
          content: SelectableText(token),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              },
              child: const Text('コピー'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('閉じる'),
            ),
          ],
        ),
      );
    } catch (_) {
      await _showErrorDialog('招待を発行できませんでした。世帯の確認後、もう一度お試しください。');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Widget _buildMembersSectionContent(
    List<HouseholdMember> otherMembers,
    String householdId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        color: context.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('メンバ一覧', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Column(
                children: otherMembers
                    .map((member) => _buildMemberCard(member, householdId))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(HouseholdMember member, String householdId) {
    final dateFormat = DateFormat('yyyy/MM/dd');

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        leading: CircleAvatar(
          backgroundColor: context.primaryColor,
          child: Text(
            member.displayName.isNotEmpty
                ? member.displayName[0].toUpperCase()
                : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(member.displayName),
        subtitle: Text('${dateFormat.format(member.joinedAt)}に参加'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => _showRemoveMemberDialog(member, householdId),
        ),
      ),
    );
  }

  Widget _buildJoinInvitationSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        color: context.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.group_add),
                  const SizedBox(width: 12),
                  Text('世帯に参加', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '他のユーザーから受け取った招待コードを入力して世帯に参加します。',
                style: TextStyle(color: context.textSecondary),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _displayNameCtrl,
                decoration: const InputDecoration(
                  labelText: '表示名',
                  hintText: 'パパ、ママなど',
                  border: OutlineInputBorder(),
                ),
                maxLength: 50,
                enabled: !_isProcessing,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _invitationTokenCtrl,
                decoration: const InputDecoration(
                  labelText: '招待コード',
                  hintText: '受け取った招待コード',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isProcessing,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : () => _acceptInvitation(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('参加'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _acceptInvitation() async {
    final token = _invitationTokenCtrl.text.trim();
    final displayName = _displayNameCtrl.text.trim();

    if (displayName.isEmpty) {
      await _showErrorDialog('表示名を入力してください');
      return;
    }

    if (token.isEmpty) {
      await _showErrorDialog('招待コードを入力してください');
      return;
    }

    setState(() => _isProcessing = true);
    _showLoadingDialog();
    try {
      if (!mounted) return;

      final acceptInvitation = ref.read(acceptInvitationUseCaseProvider);
      await acceptInvitation(
        token: token,
        displayName: displayName,
      );

      if (!mounted) return;

      _invitationTokenCtrl.clear();
      _displayNameCtrl.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('世帯への参加が完了しました')),
      );
    } on InvitationNotFoundException {
      await _showErrorDialog('世帯が見つかりません');
    } on AlreadyMemberException {
      await _showErrorDialog('既にこの世帯のメンバーです');
    } on InvitationException catch (e) {
      await _showErrorDialog(e.message);
    } catch (e) {
      await _showErrorDialog('参加に失敗しました: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
      _hideLoadingDialog();
    }
  }

  Future<void> _showErrorDialog(String message) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('エラー'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
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

  Future<void> _showRemoveMemberDialog(
    HouseholdMember member,
    String householdId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'メンバーを削除',
          style: Theme.of(dialogContext).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        content: Text('${member.displayName}さんを世帯から削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isProcessing = true);
    _showLoadingDialog();

    try {
      final removeMember = ref.read(removeMemberUseCaseProvider);
      await removeMember(
        householdId: householdId,
        memberUid: member.uid,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${member.displayName}さんを削除しました')),
      );
    } on InvitationException catch (e) {
      await _showErrorDialog(e.message);
    } catch (e) {
      await _showErrorDialog('削除に失敗しました: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
      _hideLoadingDialog();
    }
  }
}
