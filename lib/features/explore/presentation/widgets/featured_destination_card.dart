import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class FeaturedDestinationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String imageUrl;
  final VoidCallback? onArrowTap;

  const FeaturedDestinationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.imageUrl,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onArrowTap,
      child: Container(
        height: size.height * 0.28,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          image: imageUrl.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tsHeadlineSmallSemiBold(Colors.white).copyWith(
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  subtitle,
                  style: tsBodySmallMedium(Colors.white.withOpacity(0.9)).copyWith(
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.width * 0.05,
            right: size.width * 0.05,
            child: GestureDetector(
              onTap: onArrowTap,
              child: Container(
                padding: EdgeInsets.all(size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
