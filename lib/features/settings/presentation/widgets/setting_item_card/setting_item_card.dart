import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class SettingItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color iconColor;
  final bool showDivider;
  final bool showArrow;

  const SettingItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.iconColor = Colors.orange,
    this.showDivider = true,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Row(
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                // Text Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: tsTitleSmallSemiBold(ColorsResources.colorsBlack),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: tsBodySmallMedium(ColorsResources.colorsBlack.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                ),
                // Arrow Right
                if (showArrow)
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: Colors.grey[200],
            thickness: 1,
            height: 1,
          ),
      ],
    );
  }
}
