import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class DetailDescriptionSection extends StatelessWidget {
  final String description;
  final String shortDescription;

  const DetailDescriptionSection({
    super.key,
    required this.description,
    required this.shortDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description.isNotEmpty ? description : shortDescription,
          style: tsBodyMediumRegular(ColorsResources.colorsGrey).copyWith(height: 1.6),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Selengkapnya',
              style: tsBodyMediumSemiBold(ColorsResources.colorsPrimary),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: ColorsResources.colorsPrimary,
              size: 20,
            ),
          ],
        ),
      ],
    );
  }
}
