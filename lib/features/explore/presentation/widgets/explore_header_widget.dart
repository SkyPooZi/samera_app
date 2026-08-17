import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class ExploreHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const ExploreHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: tsDisplayMediumSemiBold(const Color(0xFF2C3E50))),
        SizedBox(height: height * 0.005),
        Text(
          subtitle,
          style: tsBodyMediumRegular(Colors.blueGrey[700]!)
              .copyWith(height: 1.3),
        ),
      ],
    );
  }
}
