import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class ExploreDetailStatItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;

  const ExploreDetailStatItem({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: ColorsResources.colorsPrimary, size: 20),
        const SizedBox(height: 4),
        Text(count, style: tsBodyMediumSemiBold(ColorsResources.colorsPrimary)),
        const SizedBox(height: 2),
        Text(label, style: tsLabelLargeMedium(Colors.grey[600]!)),
      ],
    );
  }
}
