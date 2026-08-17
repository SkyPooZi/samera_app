import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/typography/text_styles.dart';
import '../../../../core/styles/colors/colors.dart';

class HomeDailyQuestBanner extends StatelessWidget {
  final String title;
  final String description;
  final int currentProgress;
  final int totalProgress;
  final String progressLabel;
  final String imagePath;
  final VoidCallback onTap;

  const HomeDailyQuestBanner({
    super.key,
    required this.title,
    required this.description,
    required this.currentProgress,
    required this.totalProgress,
    required this.progressLabel,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _WavyBackgroundPainter()),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.track_changes,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          title,
                          style: tsBodySmallSemiBold(
                            ColorsResources.colorsBlack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsResources.colorsOranye,
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: imagePath.toLowerCase().endsWith('.svg')
                                ? SvgPicture.asset(
                                    imagePath,
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    imagePath,
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                description,
                                style: tsBodySmallBold(
                                  ColorsResources.colorsBlack,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '$currentProgress / $totalProgress',
                                    style: tsLabelLargeSemiBold(Colors.orange),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    progressLabel,
                                    style: tsLabelLargeMedium(
                                      ColorsResources.colorsGrey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: currentProgress / totalProgress,
                                backgroundColor: Colors.white,
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(4),
                                minHeight: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: ColorsResources.colorsBlack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WavyBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Base: Top right corner is visible
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFEFC385),
    );

    // Layer 1: Very light, starts high on left, dips to right
    final path1 = Path();
    path1.moveTo(0, size.height * 0.05); // almost at top left
    path1.quadraticBezierTo(
      size.width * 0.25,
      -size.height * 0.05,
      size.width * 0.5,
      size.height * 0.15,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.3,
      size.width,
      size.height * 0.15,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, Paint()..color = const Color(0xFFF9D8AA));

    // Layer 2: Medium, starts mid-high on left, swoops down
    final path2 = Path();
    path2.moveTo(0, size.height * 0.3);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.1,
      size.width * 0.6,
      size.height * 0.35,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.5,
      size.width,
      size.height * 0.3,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, Paint()..color = const Color(0xFFF3D1A3));

    // Layer 3: Bottom block, starts lower on left, smooth curve
    final path3 = Path();
    path3.moveTo(0, size.height * 0.55);
    path3.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.4,
      size.width * 0.7,
      size.height * 0.55,
    );
    path3.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.6,
      size.width,
      size.height * 0.45,
    );
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, Paint()..color = const Color(0xFFFEEDD5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
