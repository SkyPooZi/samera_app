import 'package:flutter/material.dart';

import '../../../../core/styles/typography/text_styles.dart';

class ActiveQuestCard extends StatelessWidget {
  final String title;
  final String description;
  final String progressText;
  final double progressValue;
  final IconData icon;
  final Color backgroundColor;
  final Color progressColor;
  final Color iconColor;
  final String imageUrl;

  const ActiveQuestCard({
    super.key,
    required this.title,
    required this.description,
    required this.progressText,
    required this.progressValue,
    required this.icon,
    required this.backgroundColor,
    required this.progressColor,
    required this.iconColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(icon, color: iconColor, size: 28),
                          const SizedBox(width: 8),
                          Text(title, style: tsTitleSmallSemiBold(iconColor)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: tsBodySmallMedium(Colors.grey[700]!),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        progressText,
                        style: tsBodySmallSemiBold(const Color(0xFF676481)),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progressValue,
                          backgroundColor: progressColor.withAlpha(51),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progressColor,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer for the image
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ),
          // Image Placeholder on the right
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: _HalfCircleClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.42,
                decoration: BoxDecoration(
                  color: Colors.grey[400], // Placeholder background
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.white, size: 40),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.5, size.height);
    // Draw a curve for the left side of the image area
    path.quadraticBezierTo(0, size.height / 2, size.width * 0.5, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
