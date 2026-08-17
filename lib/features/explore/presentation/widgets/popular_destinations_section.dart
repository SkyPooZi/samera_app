import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/explore/presentation/screens/explore_detail_screen.dart';

class PopularDestinationData {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;

  PopularDestinationData({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
  });
}

class PopularDestinationsSection extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  final List<PopularDestinationData> destinations;

  const PopularDestinationsSection({
    super.key,
    required this.title,
    required this.actionText,
    required this.destinations,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: tsBodyLargeMedium(Colors.black87)),
              GestureDetector(
                onTap: onActionTap,
                child: Text(actionText, style: tsBodyMediumMedium(Colors.teal)),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.28,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: size.width * 0.04),
            itemBuilder: (context, index) {
              return _buildPopularCard(
                context,
                destinations[index],
                size.width,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularCard(
    BuildContext context,
    PopularDestinationData destination,
    double screenWidth,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExploreDetailScreen(
              title: destination.title,
              imageUrl: destination.imageUrl,
            ),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(destination.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              top: screenWidth * 0.03,
              right: screenWidth * 0.03,
              child: const Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 24,
              ),
            ),
            Positioned(
              bottom: screenWidth * 0.04,
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.title,
                    style: tsBodyMediumSemiBold(Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Expanded(
                              child: Text(
                                destination.location,
                                style: tsLabelLargeMedium(Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              destination.rating.toString(),
                              style: tsBodySmallSemiBold(Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
