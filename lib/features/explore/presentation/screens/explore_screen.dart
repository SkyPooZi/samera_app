import 'package:flutter/material.dart';
import 'package:samera_app/features/explore/presentation/widgets/explore_categories_section.dart';
import 'package:samera_app/features/explore/presentation/widgets/explore_header_widget.dart';
import 'package:samera_app/features/explore/presentation/widgets/explore_search_bar.dart';
import 'package:samera_app/features/explore/presentation/widgets/featured_destination_card.dart';
import 'package:samera_app/features/explore/presentation/widgets/popular_destinations_section.dart';
import 'package:samera_app/features/explore/presentation/screens/explore_detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.23, 0.27, 0.33, 1.0],
                      colors: [
                        Color(0xFF8ECCF5),
                        Color(0xFF8ECCF5),
                        Color(0xFFE0F2FF),
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.02,
                left: 0,
                right: 0,
                height: size.height * 0.25,
                child: Image.asset(
                  'assets/images/cloud-image-background.jpg',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: const ExploreHeaderWidget(
                        title: 'Explore',
                        subtitle: 'Discover the\nbeauty of Indonesia',
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: ExploreSearchBar(
                        hintText:
                            'Search for a destination, city, or activity...',
                        onFilterTap: () {},
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: FeaturedDestinationCard(
                        title: 'Yogyakarta',
                        subtitle: 'Explore Indonesia\'s culture,\nhistory, and beauty',
                        backgroundColor: Colors.grey[400]!,
                        imageUrl: 'https://images.unsplash.com/photo-1712056980792-68a32307fe33?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        onArrowTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExploreDetailScreen(
                                title: 'Yogyakarta',
                                imageUrl: 'https://images.unsplash.com/photo-1712056980792-68a32307fe33?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      child: ExploreCategoriesSection(
                        title: 'Jelajahi Kategori',
                        categories: [
                          CategoryItemData(
                            icon: Icons.location_on,
                            label: 'Destination',
                            bgColor: Colors.blue[50]!,
                            iconColor: Colors.blue,
                          ),
                          CategoryItemData(
                            icon: Icons.account_balance,
                            label: 'Heritage',
                            bgColor: Colors.orange[50]!,
                            iconColor: Colors.orange,
                          ),
                          CategoryItemData(
                            icon: Icons.restaurant,
                            label: 'Cuisine',
                            bgColor: Colors.green[50]!,
                            iconColor: Colors.green,
                          ),
                          CategoryItemData(
                            icon: Icons.masks,
                            label: 'Culture',
                            bgColor: Colors.purple[50]!,
                            iconColor: Colors.purple,
                          ),
                          CategoryItemData(
                            icon: Icons.shopping_bag,
                            label: 'Local\nExperience',
                            bgColor: Colors.pink[50]!,
                            iconColor: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    PopularDestinationsSection(
                      title: 'Destinasi populer',
                      actionText: 'Lihat semua',
                      destinations: [
                        PopularDestinationData(
                          imageUrl: 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?q=80&w=600&auto=format&fit=crop',
                          title: 'Karimun Jawa',
                          location: 'Jawa Tengah',
                          rating: 4.9,
                        ),
                        PopularDestinationData(
                          imageUrl: 'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?q=80&w=600&auto=format&fit=crop',
                          title: 'Nusa Penida',
                          location: 'Bali',
                          rating: 4.8,
                        ),
                        PopularDestinationData(
                          imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=600&auto=format&fit=crop',
                          title: 'Raja Ampat',
                          location: 'Papua',
                          rating: 5.0,
                        ),
                      ],
                      onActionTap: () {},
                    ),
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
