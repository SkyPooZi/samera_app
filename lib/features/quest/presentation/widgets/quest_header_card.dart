import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/styles/typography/text_styles.dart';

class QuestHeaderCard extends StatelessWidget {
  final String userName;
  final String levelText;
  final double xpProgress;
  final String currentXp;
  final String targetXp;
  final String destinationCount;

  const QuestHeaderCard({
    super.key,
    required this.userName,
    required this.levelText,
    required this.xpProgress,
    required this.currentXp,
    required this.targetXp,
    required this.destinationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/bg-quest-asset.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Quest Kamu',
            style: tsTitleMediumBold(Colors.white).copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withAlpha(76),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // User Profile Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: const NetworkImage(
                    'https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, $userName! 👋',
                        style: tsBodyLargeBold(
                          const Color(0xFF1E1E50),
                        ), // Dark blueish text
                      ),
                      const SizedBox(height: 16),
                      Text(
                        levelText,
                        style: tsBodySmallMedium(const Color(0xFF1E1E50)),
                      ),
                      const SizedBox(height: 6),
                      // Progress Bar
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: xpProgress,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFFF4B942),
                                ), // Yellowish orange
                                minHeight: 6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Coin Icon Placeholder
                    SvgPicture.asset(
                      'assets/icons/coin-icon.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      '$currentXp /',
                      style: tsLabelLargeBold(const Color(0xFF1E1E50)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '$targetXp XP',
                      style: tsLabelLargeBold(const Color(0xFF1E1E50)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Stats Card
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFAC3902), // Darker brownish orange
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // XP Stat
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/coin-icon.svg',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(currentXp, style: tsBodyLargeBold(Colors.white)),
                    Text('XP', style: tsBodySmallSemiBold(Colors.white)),
                  ],
                ),
                // Divider
                Container(
                  height: 50,
                  width: 2,
                  color: Colors.white.withAlpha(188),
                ),
                // Destinasi Stat
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/location-icon.svg',
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      destinationCount,
                      style: tsBodyLargeBold(Colors.white),
                    ),
                    Text('Destinasi', style: tsBodySmallSemiBold(Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
