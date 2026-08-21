import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../../../../../config/router.dart';
import '../../../../../common/common_destination_card.dart';

import '../../../domain/entities/region_entity.dart';
import '../../bloc/explore/explore_bloc.dart';
import '../../bloc/explore/explore_state.dart';
import '../../widgets/explore/explore_categories_section.dart';
import '../../widgets/explore/explore_header_section.dart';
import '../../widgets/explore/explore_search_bar.dart';
import '../../widgets/explore/explore_regions_section.dart';
import '../../widgets/explore/explore_region_card.dart';
import '../../widgets/explore/explore_recommendations_section.dart';
import '../explore_detail/explore_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  void _navigateToDetail(RegionEntity region) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExploreDetailScreen(
          title: region.name,
          imageUrl: region.image,
          subtitle: region.tagline,
          destinationsCount: '${region.stats.destinations}+',
          heritageCount: '${region.stats.heritage}+',
          cuisineCount: '${region.stats.cuisine}+',
          experienceCount: '${region.stats.experiences}+',
          description: region.description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, exploreState) {
          if (exploreState is ExploreLoading ||
              exploreState is ExploreInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsResources.colorsPrimary,
              ),
            );
          } else if (exploreState is ExploreError) {
            return Center(child: Text(exploreState.message));
          } else if (exploreState is ExploreLoaded) {
            final regions = exploreState.regions;
            final selectedRegionId = exploreState.selectedRegionId;
            final recommendations = exploreState.recommendations;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  ExploreHeaderSection(
                    backgroundImage: const DecorationImage(
                      image: AssetImage('assets/images/bg-explore-asset.png'),
                      fit: BoxFit.cover,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Pagi, Skypo 👋',
                          style: tsBodyMediumMedium(Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore',
                          style: tsRobotoDisplayLargeBold(Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jelajahi keindahan\nJawa Tengah Dan DIY',
                          style: tsBodyMediumMedium(Colors.white)
                              .copyWith(height: 1.4),
                        ),
                        const SizedBox(height: 24),
                        ExploreSearchBar(
                          hintText:
                              'Search for a destination, city, or activity...',
                          onFilterTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // Regions Section
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.04),
                    child: ExploreRegionsSection(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jelajahi Jawa Tengah & DIY',
                          style: tsBodyMediumSemiBold(Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.allRegions, extra: regions);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Lihat semua',
                                style: tsBodySmallRegular(Colors.black),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: regions.take(6)
                        .map<Widget>((region) {
                          final isSelected = selectedRegionId == region.id;
                          return ExploreRegionCard(
                            name: region.name,
                            imageUrl: region.image,
                            isSelected: isSelected,
                            onTap: () {
                              _navigateToDetail(region);
                            },
                          );
                        })
                        .toList(),
                    ),
                  ),

                  // Categories Section
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.04,
                      left: paddingHorizontal,
                      right: paddingHorizontal,
                    ),
                    child: ExploreCategoriesSection(
                      title: 'Jelajahi Kategori',
                      categories: [
                        CategoryItemData(
                          icon: Icons.location_on,
                          label: 'Destinasi',
                          bgColor: Colors.blue[50]!,
                          iconColor: Colors.blue,
                          onTap: () {
                            context.push('/explore/category/destination', extra: {'title': 'Destinasi'});
                          },
                        ),
                        CategoryItemData(
                          icon: Icons.account_balance,
                          label: 'Heritage',
                          bgColor: Colors.orange[50]!,
                          iconColor: Colors.orange,
                          onTap: () {
                            context.push('/explore/category/heritage', extra: {'title': 'Heritage'});
                          },
                        ),
                        CategoryItemData(
                          icon: Icons.restaurant,
                          label: 'Cuisine',
                          bgColor: Colors.green[50]!,
                          iconColor: Colors.green,
                          onTap: () {
                            context.push('/explore/category/cuisine', extra: {'title': 'Cuisine'});
                          },
                        ),
                        CategoryItemData(
                          icon: Icons.masks,
                          label: 'Culture',
                          bgColor: Colors.purple[50]!,
                          iconColor: Colors.purple,
                          onTap: () {
                            context.push('/explore/category/culture', extra: {'title': 'Culture'});
                          },
                        ),
                        CategoryItemData(
                          icon: Icons.shopping_bag,
                          label: 'Local\nExperience',
                          bgColor: Colors.pink[50]!,
                          iconColor: Colors.pink,
                          onTap: () {
                            context.push('/explore/category/local_experience', extra: {'title': 'Local Experience'});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Recommendations Section
                  ExploreRecommendationsSection(
                    title: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                      ),
                      child: Text(
                        'Rekomendasi untukmu',
                        style: tsBodyMediumSemiBold(Colors.black87),
                      ),
                    ),
                    child: SizedBox(
                      height: size.height * 0.24,
                      child: recommendations.isEmpty
                          ? const Center(child: Text('Tidak ada rekomendasi'))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: recommendations.length,
                              padding: const EdgeInsets.only(right: 24.0),
                              itemBuilder: (context, index) {
                                final destination = recommendations[index];
                                return CommonDestinationCard(
                                  title: destination.name,
                                  location: destination.category,
                                  rating: destination.rating,
                                  imageUrl: destination.image,
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.detailDestination,
                                      extra: destination,
                                    );
                                  },
                                  onFavoriteTap: () {},
                                );
                              },
                            ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.16),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
