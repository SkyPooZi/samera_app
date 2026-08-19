import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/typography/text_styles.dart';
import '../../../../core/styles/colors/colors.dart';
import '../../../../core/styles/images/images.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 28.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: ColorsResources.colorsPrimary, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  ImagesThemes.imgBgDailyQuest,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.track_changes,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(title, style: tsBodySmallSemiBold(Colors.white)),
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
                              color: ColorsResources.colorsPrimary,
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
                                style: tsBodyMediumSemiBold(Colors.white)
                                    .copyWith(
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.6,
                                          ),
                                          offset: const Offset(1, 1),
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '$currentProgress / $totalProgress',
                                    style: tsBodySmallSemiBold(Colors.white),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    progressLabel,
                                    style: tsBodySmallSemiBold(Colors.white70),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: currentProgress / totalProgress,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.5,
                                ),
                                color: ColorsResources.colorsPrimary,
                                borderRadius: BorderRadius.circular(4),
                                minHeight: 6,
                              ),
                            ],
                          ),
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
