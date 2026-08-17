import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/styles/typography/text_styles.dart';
import '../../../../../../core/styles/colors/colors.dart';

class HomeAdventureMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final Color borderColor;
  final String imagePath;
  final VoidCallback onTap;

  const HomeAdventureMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.borderColor,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 0.5),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.width * 0.13),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: tsBodyLargeSemiBold(
                              ColorsResources.colorsBlack,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: tsLabelLargeMedium(
                              ColorsResources.colorsBlackLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6.0),
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
          ),
          Positioned(
            right: imagePath.toLowerCase().contains('map') ? -12 : -20,
            top: imagePath.toLowerCase().contains('map') ? -24 : -18,
            child: Builder(
              builder: (context) {
                final isMap = imagePath.toLowerCase().contains('map');
                final double imageSize = isMap ? 115.0 : 100.0;

                if (imagePath.toLowerCase().endsWith('.svg')) {
                  return SvgPicture.asset(
                    imagePath,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  );
                }

                return Image.asset(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
