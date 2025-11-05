import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../../../../core/firebase/household_service.dart';

class HouseholdSharePage extends ConsumerStatefulWidget {
  const HouseholdSharePage({super.key});

  @override
  ConsumerState<HouseholdSharePage> createState() => _HouseholdSharePageState();
}

class _HouseholdSharePageState extends ConsumerState<HouseholdSharePage> {
  String? _code;
  DateTime? _expireAt;
  final _joinCodeCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _joinCodeCtrl.dispose();
    super.dispose();
  }

  Future<void> _createCode() async {
    setState(() => _loading = true);
    try {
      final hid = await ref.read(currentHouseholdIdProvider.future);
      final svc = ref.read(householdServiceProvider);
      final res = await svc.createJoinToken(householdId: hid);
      if (!mounted) return;
      setState(() {
        _code = res.code;
        _expireAt = res.expireAt;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('招待コードの発行に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _joinWithCode() async {
    final code = _joinCodeCtrl.text.trim();
    if (code.isEmpty) return;
    setState(() => _loading = true);
    try {
      final svc = ref.read(householdServiceProvider);
      final hid = await svc.joinWithCode(code);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('世帯($hid)に参加しました')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('参加に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('世帯の共有'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('招待コードを発行', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _loading ? null : _createCode,
                    icon: const Icon(Icons.qr_code_2),
                    label: const Text('招待コードを発行'),
                  ),
                  const SizedBox(width: 12),
                  if (_code != null)
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _code!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('コードをコピーしました')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('コピー'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (_code != null) ...[
                SelectableText('コード: $_code'),
                if (_expireAt != null) Text('有効期限: ${_expireAt!.toLocal()}'),
              ],
              const Divider(height: 32),
              Text('招待コードで参加', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _joinCodeCtrl,
                      decoration: const InputDecoration(
                        labelText: '招待コード',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _loading ? null : _joinWithCode,
                    child: const Text('参加'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
