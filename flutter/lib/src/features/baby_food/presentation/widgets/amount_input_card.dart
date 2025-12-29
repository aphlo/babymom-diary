import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/types/child_icon.dart';
import '../../domain/value_objects/amount_unit.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../models/baby_food_draft.dart';
import 'reaction_image_button.dart';

/// 食材ごとの量入力カード
class AmountInputCard extends StatefulWidget {
  const AmountInputCard({
    super.key,
    required this.item,
    required this.childIcon,
    required this.onAmountChanged,
    required this.onUnitChanged,
    required this.onReactionChanged,
    required this.onAllergyChanged,
    required this.onMemoChanged,
  });

  final BabyFoodItemDraft item;
  final ChildIcon childIcon;
  final void Function(double? amount) onAmountChanged;
  final void Function(AmountUnit unit) onUnitChanged;
  final void Function(BabyFoodReaction? reaction) onReactionChanged;
  final void Function(bool? hasAllergy) onAllergyChanged;
  final void Function(String? memo) onMemoChanged;

  @override
  State<AmountInputCard> createState() => _AmountInputCardState();
}

class _AmountInputCardState extends State<AmountInputCard> {
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

  @override
  void didUpdateWidget(covariant AmountInputCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 食材が変わった場合（Keyが同じでもitemの内容が変わる可能性がある）
    if (oldWidget.item.ingredientId != widget.item.ingredientId) {
      _amountController.text = _formatAmount(widget.item.amount);
      _memoController.text = widget.item.memo ?? '';
    }
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
          // 1行目: 食材名
          _buildNameRow(),
          const SizedBox(height: 12),
          // 2行目: 量ラベル + 単位・量入力
          _buildAmountRow(),
          const Divider(height: 16),
          // 3行目: 反応ラベル + 反応アイコン + アレルギーチェック
          _buildReactionAndAllergyRow(),
          const Divider(height: 16),
          // 4行目: メモ（複数行入力可能）
          _buildMemoRow(),
        ],
      ),
    );
  }

  /// 1行目: 食材名
  Widget _buildNameRow() {
    return Text(
      widget.item.ingredientName,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 2行目: 量ラベル + 単位・量入力
  Widget _buildAmountRow() {
    final currentUnit = widget.item.unit;

    return Row(
      children: [
        // ラベル
        SizedBox(
          width: 32,
          child: Text(
            '量',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 単位選択（タップでドラムロール表示）
        Expanded(
          child: GestureDetector(
            onTap: () => _showUnitPicker(context, currentUnit),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        fontSize: 13,
                        color: currentUnit != null
                            ? Colors.black87
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
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
            height: 36,
            child: TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: '数値',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                isDense: true,
              ),
              onChanged: (value) {
                final amount = value.isEmpty ? null : double.tryParse(value);
                widget.onAmountChanged(amount);
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 3行目: 反応ラベル + 反応選択 + アレルギーチェック
  Widget _buildReactionAndAllergyRow() {
    // 反応ボタンの高さ（画像56 + 間隔4 + ラベル約16）
    const reactionButtonHeight = 76.0;

    return SizedBox(
      height: reactionButtonHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ラベル（垂直中央）
          SizedBox(
            width: 32,
            child: Text(
              '反応',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 反応選択（動物アイコン）
          ReactionImageButton(
            childIcon: widget.childIcon,
            reaction: BabyFoodReaction.good,
            isSelected: widget.item.reaction == BabyFoodReaction.good,
            onTap: () => widget.onReactionChanged(
                widget.item.reaction == BabyFoodReaction.good
                    ? null
                    : BabyFoodReaction.good),
          ),
          const SizedBox(width: 8),
          ReactionImageButton(
            childIcon: widget.childIcon,
            reaction: BabyFoodReaction.normal,
            isSelected: widget.item.reaction == BabyFoodReaction.normal,
            onTap: () => widget.onReactionChanged(
                widget.item.reaction == BabyFoodReaction.normal
                    ? null
                    : BabyFoodReaction.normal),
          ),
          const SizedBox(width: 8),
          ReactionImageButton(
            childIcon: widget.childIcon,
            reaction: BabyFoodReaction.bad,
            isSelected: widget.item.reaction == BabyFoodReaction.bad,
            onTap: () => widget.onReactionChanged(
                widget.item.reaction == BabyFoodReaction.bad
                    ? null
                    : BabyFoodReaction.bad),
          ),
          const Spacer(),
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
      ),
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('キャンセル'),
                        ),
                      ),
                    ),
                    const Text(
                      '単位を選択',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            widget.onUnitChanged(
                                AmountUnit.values[selectedIndex]);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('完了'),
                        ),
                      ),
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

  /// 4行目: メモラベル + メモ入力（複数行）
  Widget _buildMemoRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ラベル
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 32,
            child: Text(
              'メモ',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // メモ入力フィールド
        Expanded(
          child: TextField(
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              isDense: true,
              counterText: '',
            ),
            onChanged: (value) {
              widget.onMemoChanged(value.isEmpty ? null : value);
            },
          ),
        ),
      ],
    );
  }
}
