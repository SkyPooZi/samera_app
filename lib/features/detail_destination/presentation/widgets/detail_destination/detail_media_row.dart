import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/config/router.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';

import 'detail_media_card.dart';

class DetailMediaRow extends StatelessWidget {
  final DestinationEntity destination;

  const DetailMediaRow({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemSpacing = size.width * 0.025; // Jarak responsif antar item

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DetailMediaCard(
          title: 'Foto',
          hasPlayIcon: false,
          imageUrl: destination.gallery.isNotEmpty
              ? destination.gallery.first
              : destination.image,
          onTap: () {
            context.pushNamed(Routes.gallery, extra: destination);
          },
        ),
        SizedBox(width: itemSpacing),
        DetailMediaCard(title: 'Video', hasPlayIcon: true),
        if (destination.panorama360 != null &&
            destination.panorama360!.enabled &&
            destination.panorama360!.asset != null) ...[
          SizedBox(width: itemSpacing),
          DetailMediaCard(
            title: '360° Tour',
            hasPlayIcon: true,
            imageUrl: destination.gallery.length > 2
                ? destination.gallery[2]
                : destination.image,
            onTap: () {
              context.pushNamed(Routes.panorama360, extra: destination);
            },
          ),
        ],
        SizedBox(width: itemSpacing),
        DetailMediaCard(
          title: 'Galeri',
          hasPlayIcon: false,
          imageUrl: destination.gallery.length > 1
              ? destination.gallery[1]
              : destination.image,
          centerText: '+${destination.gallery.length}',
          onTap: () {
            context.pushNamed(Routes.gallery, extra: destination);
          },
        ),
      ],
    );
  }
}
