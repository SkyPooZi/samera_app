import 'package:flutter/material.dart';

class ExploreRecommendationsSection extends StatelessWidget {
  final Widget title;
  final Widget child;

  const ExploreRecommendationsSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
