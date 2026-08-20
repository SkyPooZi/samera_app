import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class DetailQuickInfoSection extends StatelessWidget {
  final String ticketPriceLabel;
  final String address;

  const DetailQuickInfoSection({
    super.key,
    required this.ticketPriceLabel,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Operating Hours
        Row(
          children: [
            const Icon(
              Icons.alarm,
              color: ColorsResources.colorsPrimary,
              size: 32,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jam Operasional',
                  style: tsBodySmallRegular(ColorsResources.colorsGrey),
                ),
                const SizedBox(height: 4),
                Text(
                  '24 Jam',
                  style: tsBodyMediumSemiBold(ColorsResources.colorsBlack),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Ticket Price
        Row(
          children: [
            const Icon(
              Icons.local_activity_outlined,
              color: ColorsResources.colorsPrimary,
              size: 32,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harga Tiket',
                  style: tsBodySmallRegular(ColorsResources.colorsGrey),
                ),
                const SizedBox(height: 4),
                Text(
                  ticketPriceLabel,
                  style: tsBodyMediumSemiBold(ColorsResources.colorsBlack),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Location
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: ColorsResources.colorsPrimary,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lokasi',
                    style: tsBodySmallRegular(ColorsResources.colorsGrey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: tsBodyMediumSemiBold(ColorsResources.colorsBlack).copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
