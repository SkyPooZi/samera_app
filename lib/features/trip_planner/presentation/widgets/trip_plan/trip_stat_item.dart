import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class TripStatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const TripStatItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(width * 0.02),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: width * 0.05, color: iconColor),
        ),
        SizedBox(height: width * 0.02),
        Text(
          title,
          style: tsLabelLargeMedium(Colors.grey[600]!),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: width * 0.01),
        Text(
          value,
          style: tsBodySmallSemiBold(Colors.black87),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
