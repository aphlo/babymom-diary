import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/value_objects/amount_unit.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../models/baby_food_draft.dart';

/// 量入力ウィジェット
class AmountInput extends StatelessWidget {
  const AmountInput({
    super.key,
    required this.items,
    required this.onAmountChanged,
    required this.onUnitChanged,
    required this.onReactionChanged,
    required this.onAllergyChanged,
    required this.onMemoChanged,
  });

  final List<BabyFoodItemDraft> items;
  final void Function(String ingredientId, double? amount) onAmountChanged;
  final void Function(String ingredientId, AmountUnit unit) onUnitChanged;
  final void Function(String ingredientId, BabyFoodReaction? reaction)
      onReactionChanged;
  final void Function(String ingredientId, bool? hasAllergy) onAllergyChanged;
  final void Function(String ingredientId, String? memo) onMemoChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return _AmountInputCard(
          item: item,
          onAmountChanged: (amount) =>
              onAmountChanged(item.ingredientId, amount),
          onUnitChanged: (unit) => onUnitChanged(item.ingredientId, unit),
          onReactionChanged: (reaction) =>
              onReactionChanged(item.ingredientId, reaction),
          onAllergyChanged: (hasAllergy) =>
              onAllergyChanged(item.ingredientId, hasAllergy),
          onMemoChanged: (memo) => onMemoChanged(item.ingredientId, memo),
        );
      },
    );
  }
}

class _AmountInputCard extends StatefulWidget {
  const _AmountInputCard({
    required this.item,
    required this.onAmountChanged,
    required this.onUnitChanged,
    required this.onReactionChanged,
    required this.onAllergyChanged,
    required this.onMemoChanged,
  });

  final BabyFoodItemDraft item;
  final void Function(double? amount) onAmountChanged;
  final void Function(AmountUnit unit) onUnitChanged;
  final void Function(BabyFoodReaction? reaction) onReactionChanged;
  final void Function(bool? hasAllergy) onAllergyChanged;
  final void Function(String? memo) onMemoChanged;

  @override
  State<_AmountInputCard> createState() => _AmountInputCardState();
}

class _AmountInputCardState extends State<_AmountInputCard> {
  late final TextEditingController _amountController;
  late final TextEditingController _memoController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: _formatAmount(widget.item.amount),
    );
    _memoController = TextEditingController(
      text: widget.item.memo ?? '',
    );
  }

  /// 量を表示用にフォーマット（整数の場合は小数点以下を省略）
  String _formatAmount(double? amount) {
    if (amount == null) return '';
    if (amount == amount.truncate()) {
      return amount.truncate().toString();
    }
    return amount.toString();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pink.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1行目: 食材名（左） + 反応アイコン（右）
          _buildNameAndReactionRow(),
          const Divider(height: 16),
          // 2行目: 単位 + 数値 + アレルギーチェック
          _buildAmountAndAllergyRow(),
          const Divider(height: 16),
          // 3行目: メモ（複数行入力可能）
          _buildMemoRow(),
        ],
      ),
    );
  }

  /// 1行目: 食材名（左） + 反応アイコン（右）
  Widget _buildNameAndReactionRow() {
    return Row(
      children: [
        // 食材名
        Text(
          widget.item.ingredientName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        // 反応選択
        _ReactionIconButton(
          reaction: BabyFoodReaction.good,
          icon: Icons.sentiment_very_satisfied,
          color: Colors.green,
          isSelected: widget.item.reaction == BabyFoodReaction.good,
          onTap: () => widget.onReactionChanged(
              widget.item.reaction == BabyFoodReaction.good
                  ? null
                  : BabyFoodReaction.good),
        ),
        const SizedBox(width: 4),
        _ReactionIconButton(
          reaction: BabyFoodReaction.normal,
          icon: Icons.sentiment_neutral,
          color: Colors.orange,
          isSelected: widget.item.reaction == BabyFoodReaction.normal,
          onTap: () => widget.onReactionChanged(
              widget.item.reaction == BabyFoodReaction.normal
                  ? null
                  : BabyFoodReaction.normal),
        ),
        const SizedBox(width: 4),
        _ReactionIconButton(
          reaction: BabyFoodReaction.bad,
          icon: Icons.sentiment_very_dissatisfied,
          color: Colors.red,
          isSelected: widget.item.reaction == BabyFoodReaction.bad,
          onTap: () => widget.onReactionChanged(
              widget.item.reaction == BabyFoodReaction.bad
                  ? null
                  : BabyFoodReaction.bad),
        ),
      ],
    );
  }

  /// 2行目: 単位選択 + 量入力 + アレルギーチェック
  Widget _buildAmountAndAllergyRow() {
    final currentUnit = widget.item.unit;

    return Row(
      children: [
        // 単位選択（タップでドラムロール表示）
        Expanded(
          child: GestureDetector(
            onTap: () => _showUnitPicker(context, currentUnit),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      currentUnit?.label ?? '単位',
                      style: TextStyle(
                        fontSize: 14,
                        color: currentUnit != null
                            ? Colors.black87
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 量入力フィールド
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: '量（任意）',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true,
              ),
              onChanged: (value) {
                final amount = value.isEmpty ? null : double.tryParse(value);
                widget.onAmountChanged(amount);
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        // アレルギーチェック
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'アレルギー',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Checkbox(
              value: widget.item.hasAllergy ?? false,
              onChanged: (value) {
                widget.onAllergyChanged(value == true ? true : null);
              },
              activeColor: Colors.red,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ],
    );
  }

  /// 単位選択のドラムロールを表示
  void _showUnitPicker(BuildContext context, AmountUnit? currentUnit) {
    var selectedIndex =
        currentUnit != null ? AmountUnit.values.indexOf(currentUnit) : 0;

    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: 280,
          color: Colors.white,
          child: Column(
            children: [
              // ヘッダー
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('キャンセル'),
                    ),
                    const Text(
                      '単位を選択',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onUnitChanged(AmountUnit.values[selectedIndex]);
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('完了'),
                    ),
                  ],
                ),
              ),
              // ピッカー
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  itemExtent: 40,
                  onSelectedItemChanged: (index) {
                    selectedIndex = index;
                  },
                  children: AmountUnit.values.map((unit) {
                    return Center(
                      child: Text(
                        unit.label,
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 3行目: メモ入力（複数行）
  Widget _buildMemoRow() {
    return TextField(
      controller: _memoController,
      maxLength: 100,
      maxLines: null,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: 'メモを入力',
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        isDense: true,
        counterText: '',
      ),
      onChanged: (value) {
        widget.onMemoChanged(value.isEmpty ? null : value);
      },
    );
  }
}

class _ReactionIconButton extends StatelessWidget {
  const _ReactionIconButton({
    required this.reaction,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final BabyFoodReaction reaction;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected ? color : Colors.grey.shade400,
        ),
      ),
    );
  }
}
