import 'dart:math';

import 'package:flutter/material.dart';

class MomSupportFab extends StatefulWidget {
  const MomSupportFab({super.key});

  @override
  State<MomSupportFab> createState() => _MomSupportFabState();
}

class _MomSupportFabState extends State<MomSupportFab> {
  static const _iconAssets = [
    'assets/icons/milu_bear.png',
    'assets/icons/milu_cat.png',
  ];

  static const _messages = [
    '今日もがんばってるね！',
    '今日もおつかれさま。',
    'おいしいもの食べてる？',
    'ちゃんと眠れてるかな？',
    '気分転換もしてみてね。',
    '毎日頑張っていてすごい！',
    'たまには周りにも頼ってね。',
    '自分を大切にしてね。',
    '無理せず休憩しようね。',
    'ちょっとひと息ついても大丈夫だよ。',
    'いつでも味方だよ。ゆっくり進もうね。',
  ];

  final _random = Random();

  late String _iconAsset;
  late String _message;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _refreshContent();
  }

  void _refreshContent() {
    _iconAsset = _iconAssets[_random.nextInt(_iconAssets.length)];
    _message = _messages[_random.nextInt(_messages.length)];
  }

  void _handleClose() {
    setState(() {
      _isVisible = false;
    });
  }

  void _handleTap() {
    setState(_refreshContent);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return Transform.translate(
      offset: const Offset(8, 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, -12),
            child: _SupportSpeechBubble(
              message: _message,
              onClose: _handleClose,
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
            ),
            child: FloatingActionButton(
              onPressed: _handleTap,
              backgroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              child: ClipOval(
                child: Image.asset(
                  _iconAsset,
                  fit: BoxFit.cover,
                  width: 64,
                  height: 64,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportSpeechBubble extends StatelessWidget {
  const _SupportSpeechBubble({
    required this.message,
    required this.onClose,
  });

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleColor = theme.colorScheme.surface;
    final onBubble = theme.colorScheme.onSurface;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 240),
          padding: const EdgeInsets.fromLTRB(16, 12, 32, 12),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(color: onBubble),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onClose,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.close,
                size: 16,
                color: onBubble.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Positioned(
          right: -10,
          bottom: 12,
          child: CustomPaint(
            size: const Size(12, 16),
            painter: _BubbleTailPainter(color: bubbleColor),
          ),
        ),
      ],
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  const _BubbleTailPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BubbleTailPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
