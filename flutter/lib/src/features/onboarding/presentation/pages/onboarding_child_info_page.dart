import 'package:babymom_diary/src/core/widgets/bottom_save_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/menu/children/application/child_color_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/children/data/infrastructure/child_firestore_data_source.dart';
import 'package:babymom_diary/src/features/menu/children/presentation/widgets/child_form.dart';
import 'package:babymom_diary/src/features/onboarding/application/onboarding_status_provider.dart';

class OnboardingChildInfoPage extends ConsumerStatefulWidget {
  const OnboardingChildInfoPage({super.key});

  @override
  ConsumerState<OnboardingChildInfoPage> createState() =>
      _OnboardingChildInfoPageState();
}

class _OnboardingChildInfoPageState
    extends ConsumerState<OnboardingChildInfoPage> {
  final _formKey = GlobalKey<ChildFormState>();
  bool _isProcessing = false;

  Future<void> _completeOnboarding(BuildContext context) async {
    await ref.read(onboardingStatusProvider.notifier).complete();
    if (context.mounted) {
      context.go('/baby');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子どもの登録'),
        actions: [
          TextButton(
            onPressed:
                _isProcessing ? null : () => _completeOnboarding(context),
            child: const Text(
              'スキップ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'あなたの子どもの情報を登録すると、成長記録や予防接種の予定をスムーズに管理できます。',
                    ),
                  ),
                  ChildForm(
                    key: _formKey,
                    showSaveButton: false,
                    onSubmit: (data) async {
                      setState(() => _isProcessing = true);

                      final householdId =
                          await ref.read(currentHouseholdIdProvider.future);
                      final db = ref.read(firebaseFirestoreProvider);
                      final ds = ChildFirestoreDataSource(db, householdId);

                      try {
                        final childId = await ds.addChild(
                          name: data.name,
                          gender: data.gender,
                          birthday: data.birthday,
                          dueDate: data.dueDate,
                          icon: data.icon,
                        );

                        await ref
                            .read(childColorProvider.notifier)
                            .setColor(childId, data.color);

                        await ref
                            .read(selectedChildControllerProvider.notifier)
                            .select(childId);

                        await ref
                            .read(onboardingStatusProvider.notifier)
                            .complete();

                        if (context.mounted) {
                          context.go('/baby');
                        }
                      } on FirebaseException catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('保存に失敗しました: ${e.message}')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('保存に失敗しました: $e')),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() => _isProcessing = false);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // 画面下に固定表示の保存ボタン（SafeArea考慮）
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SaveButton(
                onPressed: _isProcessing
                    ? null
                    : () => _formKey.currentState?.submit(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
