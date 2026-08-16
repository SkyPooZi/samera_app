import 'package:flutter/material.dart';

import '../core/styles/typography/text_styles.dart';
import '../core/styles/colors/colors.dart';

class CommonDestinationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const CommonDestinationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
        margin: const EdgeInsets.only(left: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(size.width * 0.03), // Padding responsif
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: size.width * 0.05, // Ukuran icon responsif
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tsBodyMediumSemiBold(ColorsResources.colorsWhite),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: size.width * 0.03, // Ukuran icon responsif
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          location,
                          style: tsLabelMediumSemiBold(
                            ColorsResources.colorsWhite,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsResources.colorsBlackLight,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: size.width * 0.03, // Ukuran icon responsif
                            ),
                            const SizedBox(width: 2),
                            Text(
                              rating.toString(),
                              style: tsLabelMediumSemiBold(
                                ColorsResources.colorsWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
