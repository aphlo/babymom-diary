import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/firebase/household_service.dart';
import '../../../../../core/theme/app_colors.dart';
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
  final TextEditingController _householdIdCtrl = TextEditingController();
  final TextEditingController _displayNameCtrl = TextEditingController();
  bool _isProcessing = false;
  bool _loadingDialogVisible = false;

  @override
  void dispose() {
    _householdIdCtrl.dispose();
    _displayNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final householdIdAsync = ref.watch(currentHouseholdIdProvider);
    final membershipTypeAsync = ref.watch(currentMembershipTypeProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('世帯の共有'),
      ),
      body: SafeArea(
        child: householdIdAsync.when(
          data: (householdId) => membershipTypeAsync.when(
            data: (membershipType) =>
                _buildContent(householdId, membershipType),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('エラー: $error')),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('エラー: $error')),
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
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.group, color: AppColors.primary),
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
                const Text(
                  'あなたは他のユーザーの世帯に参加しています。\n世帯IDの共有は世帯の作成者のみが行えます。',
                  style: TextStyle(color: Colors.grey),
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
            _buildHouseholdIdSection(householdId),
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

  Widget _buildHouseholdIdSection(String householdId) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.share),
                const SizedBox(width: 12),
                Text('世帯ID', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '他のユーザーとこの世帯IDを共有することで、世帯にメンバーを追加できます。',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      householdId,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontFamily: 'monospace',
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyHouseholdId(householdId),
                    tooltip: 'コピー',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (buttonContext) => ElevatedButton(
                  onPressed: () =>
                      _shareHouseholdId(buttonContext, householdId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    '世帯IDを共有する',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersSectionContent(
    List<HouseholdMember> otherMembers,
    String householdId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('メンバ一覧',
                  style: Theme.of(context).textTheme.titleMedium),
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
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
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
        color: Colors.white,
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
              const Text(
                '他のユーザーから受け取った世帯IDを入力して世帯に参加します。',
                style: TextStyle(color: Colors.grey),
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
                controller: _householdIdCtrl,
                decoration: const InputDecoration(
                  labelText: '世帯ID',
                  hintText: '参加する世帯のID',
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
                    backgroundColor: AppColors.primary,
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

  void _copyHouseholdId(String householdId) {
    Clipboard.setData(ClipboardData(text: householdId));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('世帯IDをコピーしました')),
    );
  }

  void _shareHouseholdId(BuildContext context, String householdId) {
    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin =
        box != null ? box.localToGlobal(Offset.zero) & box.size : null;

    Share.share(
      'miluへの招待が届きました。\n\n世帯ID: $householdId',
      subject: 'miluへの招待が届きました。',
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  Future<void> _acceptInvitation() async {
    final householdId = _householdIdCtrl.text.trim();
    final displayName = _displayNameCtrl.text.trim();

    if (displayName.isEmpty) {
      await _showErrorDialog('表示名を入力してください');
      return;
    }

    if (householdId.isEmpty) {
      await _showErrorDialog('世帯IDを入力してください');
      return;
    }

    setState(() => _isProcessing = true);
    _showLoadingDialog();
    try {
      if (!mounted) return;

      final acceptInvitation = ref.read(acceptInvitationUseCaseProvider);
      await acceptInvitation(
        householdId: householdId,
        displayName: displayName,
      );

      if (!mounted) return;

      _householdIdCtrl.clear();
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
        title: const Text('メンバーを削除'),
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
