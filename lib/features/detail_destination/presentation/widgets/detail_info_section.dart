import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class DetailInfoSection extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final int reviewCount;

  const DetailInfoSection({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: tsDisplaySmallSemiBold(ColorsResources.colorsBlue),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: ColorsResources.colorsGrey,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              location,
              style: tsBodyMediumRegular(ColorsResources.colorsGrey),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: ColorsResources.colorsOranye,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              rating.toString(),
              style: tsBodyMediumSemiBold(const Color(0xFF2E7D32)),
            ),
            const SizedBox(width: 4),
            Text(
              '($reviewCount ulasan)',
              style: tsBodyMediumRegular(ColorsResources.colorsGrey),
            ),
          ],
        ),
      ],
    );
  }
}
