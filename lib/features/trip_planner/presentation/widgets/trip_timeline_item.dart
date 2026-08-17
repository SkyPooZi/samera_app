import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TripTimelineItem extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final String duration;
  final String imageUrl;
  final bool isLast;
  final Color dotColor;

  const TripTimelineItem({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageUrl,
    this.isLast = false,
    this.dotColor = const Color(0xFFFE813C),
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Column
          SizedBox(
            width: width * 0.1,
            child: Column(
              children: [
                SizedBox(
                  height: width * 0.015,
                ), // Offset to align dot with text
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: CustomPaint(
                      painter: DashedLinePainter(color: dotColor),
                      size: const Size(12, double.infinity),
                    ),
                  ),
              ],
            ),
          ),

          // Content Column
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(time, style: tsBodyMediumSemiBold(Colors.black87)),
                  SizedBox(height: width * 0.02),
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            width: width * 0.24,
                            height: width * 0.24,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: width * 0.24,
                                  height: width * 0.24,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(width: width * 0.04),

                        // Text Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: const Color(
                                      0xFFF34239,
                                    ), // Orange Red
                                    size: width * 0.045,
                                  ),
                                  SizedBox(width: width * 0.015),
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: tsBodySmallSemiBold(
                                        const Color(0xFF2C3E50),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: width * 0.02),
                              Text(
                                description,
                                style: tsBodySmallMedium(Colors.grey[800]!),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: width * 0.04),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: width * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFE813C)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: width * 0.03,
                                      color: const Color(0xFFFE813C),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      duration,
                                      style: tsLabelMediumSemiBold(
                                        const Color(0xFFFE813C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
