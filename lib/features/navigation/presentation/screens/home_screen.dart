import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/icons/icons.dart';
import 'package:samera_app/core/styles/images/images.dart';

import '../../../../common/common_section_title.dart';
import '../../../../common/common_destination_card.dart';
import '../widgets/home/home_profile_header.dart';
import '../widgets/home/home_hero_banner.dart';
import '../widgets/home/home_adventure_menu.dart';
import '../widgets/home/home_daily_quest_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Variabel responsif berbasis ukuran layar pengguna
    final size = MediaQuery.of(context).size;
    final double sectionSpacing = size.height * 0.02;
    final double elementSpacing = size.height * 0.02;
    final double horizontalSpacing = size.width * 0.03;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: sectionSpacing),
                child: const HomeProfileHeader(
                  name: 'Skypo',
                  subtitle: 'Ready for your next adventure?',
                  profileImageUrl: 'https://i.pravatar.cc/150?img=11',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: sectionSpacing),
                child: HomeHeroBanner(
                  location: 'LABUAN BAJO',
                  title1: 'Vacation',
                  title2: 'Is Calling',
                  description: 'Discover natural beauty,\nculture, and unforgettable\nexperiences',
                  imageUrl: 'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=800&q=80',
                  onExploreTap: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: elementSpacing),
                      child: const CommonSectionTitle(
                        title: "Start your adventure",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: horizontalSpacing,
                              ),
                              child: HomeAdventureMenuCard(
                                title: 'Explore',
                                subtitle:
                                    'Discover other\ninteresting destinations',
                                gradientColors: const [
                                  ColorsResources.colorsPastelGreenStart,
                                  ColorsResources.colorsPastelGreenEnd,
                                ],
                                borderColor: ColorsResources.colorsPastelGreen,
                                imagePath: IconsThemes.iconCompass,
                                onTap: () {},
                              ),
                            ),
                          ),
                          Expanded(
                            child: HomeAdventureMenuCard(
                              title: 'Trip Plan',
                              subtitle: 'Plan your\ndream trip with ease',
                              gradientColors: const [
                                ColorsResources.colorsPastelPeachStart,
                                ColorsResources.colorsPastelPeachEnd,
                              ],
                              borderColor: ColorsResources.colorsPastelPeach,
                              imagePath: IconsThemes.iconMaps,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: sectionSpacing),
                child: HomeDailyQuestBanner(
                  title: 'Daily quest',
                  description: 'Take picture batik\ntraditional Yogyakarta',
                  currentProgress: 2,
                  totalProgress: 3,
                  progressLabel: 'Picture',
                  imagePath: IconsThemes.iconBatik,
                  onTap: () {},
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: elementSpacing),
                    child: const CommonSectionTitle(
                      title: "Recommendations for You",
                    ),
                  ),
                  SizedBox(
                    // Catatan: SizedBox ini bukan untuk jarak, tapi untuk memberikan batas tinggi pada ListView horizontal
                    height: size.height * 0.24,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      padding: const EdgeInsets.only(right: 24.0),
                      itemBuilder: (context, index) {
                        return CommonDestinationCard(
                          title: 'Karimun Jawa',
                          location: 'Jawa Tengah',
                          rating: 4.9,
                          imageUrl: 'https://images.unsplash.com/photo-1542259009477-d625272157b7?auto=format&fit=crop&w=400&q=80',
                          onTap: () {},
                          onFavoriteTap: () {},
                        );
                      },
                    ),
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
