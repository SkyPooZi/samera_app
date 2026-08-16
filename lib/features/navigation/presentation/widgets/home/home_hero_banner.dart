
import 'package:flutter/material.dart';
import '../../../../../../core/styles/typography/text_styles.dart';
import '../../../../../../core/styles/colors/colors.dart';

class HomeHeroBanner extends StatelessWidget {
  final String location;
  final String title1;
  final String title2;
  final String description;
  final String imageUrl;
  final VoidCallback onExploreTap;

  const HomeHeroBanner({
    super.key,
    required this.location,
    required this.title1,
    required this.title2,
    required this.description,
    required this.imageUrl,
    required this.onExploreTap,
  });

  Widget _buildAvatar(String url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.26,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.blueGrey,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              gradient: LinearGradient(
                colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(location, style: tsLabelLargeSemiBold(ColorsResources.colorsWhite)),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$title1\n',
                        style: tsRobotoHeadlineSmallMedium(ColorsResources.colorsWhite).copyWith(height: 1.2),
                      ),
                      TextSpan(
                        text: title2,
                        style: tsRobotoHeadlineSmallBold(Colors.amber).copyWith(height: 1.2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: tsLabelMediumMedium(ColorsResources.colorsWhite),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onExploreTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Explore now', style: tsLabelLargeSemiBold(const Color(0xFF0D5D4A))),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF0D5D4A)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 82,
                  height: 28,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: _buildAvatar('https://i.pravatar.cc/150?img=33'),
                      ),
                      Positioned(
                        left: 18,
                        child: _buildAvatar('https://i.pravatar.cc/150?img=12'),
                      ),
                      Positioned(
                        left: 36,
                        child: _buildAvatar('https://i.pravatar.cc/150?img=5'),
                      ),
                      Positioned(
                        left: 54,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '+12k',
                            style: tsLabelSmallBold(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: tsLabelLargeBold(Colors.white).copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(2.341)',
                        style: tsLabelLargeMedium(Colors.white).copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
