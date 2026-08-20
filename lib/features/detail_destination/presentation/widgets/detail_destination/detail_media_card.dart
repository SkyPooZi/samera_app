import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class DetailMediaCard extends StatelessWidget {
  final String title;
  final bool hasPlayIcon;
  final String? centerText;
  final String? imageUrl;
  final VoidCallback? onTap;

  const DetailMediaCard({
    super.key,
    required this.title,
    this.hasPlayIcon = true,
    this.centerText,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final horizontalPadding = size.width * 0.06 * 2;
    final gap = 12.0 * 3;
    final cardWidth = (size.width - horizontalPadding - gap) / 4;
    final cardHeight = cardWidth * 1.5;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.grey[400], // Placeholder color
          borderRadius: BorderRadius.circular(16),
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          children: [
            // Overlay to make white text readable when image is added later
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
            // Center Icon or Text
            Center(
              child: hasPlayIcon
                  ? const Icon(Icons.play_circle_outline, color: Colors.white, size: 28)
                  : Text(centerText ?? '', style: tsBodyLargeSemiBold(Colors.white)),
            ),
            // Bottom Text
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: tsLabelLargeSemiBold(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
