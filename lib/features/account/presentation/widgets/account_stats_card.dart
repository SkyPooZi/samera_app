import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class AccountStatsCard extends StatelessWidget {
  const AccountStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explorer',
                  style: tsTitleSmallSemiBold(ColorsResources.colorsBlack),
                ),
                const SizedBox(height: 4),
                Text(
                  'Level 0',
                  style: tsLabelLargeMedium(ColorsResources.colorsBlack),
                ),
                const SizedBox(height: 8),
                // Progress Bar
                Container(
                  height: 6,
                  width: screenWidth * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber, // Placeholder color for progress
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Right side
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Coin Icon
              SvgPicture.asset(
                'assets/icons/coin-icon.svg',
                width: 32,
                height: 32,
              ),
              const SizedBox(height: 8),
              Text(
                '0 / 0 XP',
                style: tsLabelMediumSemiBold(const Color(0xFF332965)), // Purple-ish color
              ),
            ],
          ),
        ],
      ),
    );
  }
}
