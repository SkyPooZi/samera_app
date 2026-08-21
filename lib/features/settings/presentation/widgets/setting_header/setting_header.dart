import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class SettingHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SettingHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          ),
        ),
        const SizedBox(height: 24),
        // Title
        Text(
          title,
          style: tsHeadlineSmallBold(ColorsResources.colorsBlack),
        ),
        const SizedBox(height: 8),
        // Subtitle
        Text(
          subtitle,
          style: tsBodyMediumRegular(ColorsResources.colorsBlack.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}
