import 'package:flutter/material.dart';

import '../../../../core/theme/semantic_colors.dart';

class PaywallReviewCarousel extends StatefulWidget {
  const PaywallReviewCarousel({super.key});

  @override
  State<PaywallReviewCarousel> createState() => _PaywallReviewCarouselState();
}

class _PaywallReviewCarouselState extends State<PaywallReviewCarousel> {
  final _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  static const _reviews = [
    _ReviewData(
      title: '広告がなくて快適!',
      body: '育児中は片手しか空かないことが多いので、広告が消えるだけでストレスが全然違います。',
      userName: '30代 ママ',
    ),
    _ReviewData(
      title: '毎日使うものだから',
      body: '記録を見返すときに広告が挟まらないので、とても見やすくなりました。課金して良かったです。',
      userName: '20代 ママ',
    ),
    _ReviewData(
      title: 'サクサク記録できる',
      body: '子どもが寝てる隙にパッと記録したいので、広告なしは本当にありがたい。おすすめです!',
      userName: '30代 パパ',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _reviews.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _ReviewCard(review: _reviews[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _reviews.length,
            (index) => _DotIndicator(isActive: index == _currentPage),
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final _ReviewData review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.menuSectionBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.menuSectionBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
              (_) => Icon(
                Icons.star,
                size: 16,
                color: context.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              review.body,
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondary,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            review.userName,
            style: TextStyle(
              fontSize: 12,
              color: context.subtextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? context.primaryColor
            : context.subtextColor.withValues(alpha: 0.3),
      ),
    );
  }
}

class _ReviewData {
  const _ReviewData({
    required this.title,
    required this.body,
    required this.userName,
  });

  final String title;
  final String body;
  final String userName;
}
