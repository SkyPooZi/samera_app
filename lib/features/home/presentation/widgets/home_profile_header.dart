import 'package:flutter/material.dart';
import '../../../../../../core/styles/typography/text_styles.dart';
import '../../../../../../core/styles/colors/colors.dart';

class HomeProfileHeader extends StatelessWidget {
  final String name;
  final String subtitle;
  final String? profileImageUrl;

  const HomeProfileHeader({
    super.key,
    required this.name,
    required this.subtitle,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $name 👋',
                style: tsTitleMediumMedium(ColorsResources.colorsWhite),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: tsBodySmallMedium(ColorsResources.colorsWhite),
              ),
            ],
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[300],
            backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
            child: profileImageUrl == null ? const Icon(Icons.person, color: Colors.white) : null,
          ),
        ],
      ),
    );
  }
}
