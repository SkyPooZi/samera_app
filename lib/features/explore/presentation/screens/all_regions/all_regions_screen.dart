import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../../../domain/entities/region_entity.dart';
import '../../widgets/explore/explore_region_card.dart';
import '../explore_detail/explore_detail_screen.dart';

class AllRegionsScreen extends StatelessWidget {
  final List<RegionEntity> regions;

  const AllRegionsScreen({super.key, required this.regions});

  void _navigateToDetail(BuildContext context, RegionEntity region) {
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
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Semua Destinasi',
          style: tsBodyLargeSemiBold(Colors.black87),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: 24 + bottomPadding,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75, // Disesuaikan agar ExploreRegionCard pas
        ),
        itemCount: regions.length,
        itemBuilder: (context, index) {
          final region = regions[index];
          return ExploreRegionCard(
            name: region.name,
            imageUrl: region.image,
            isSelected: false,
            onTap: () => _navigateToDetail(context, region),
          );
        },
      ),
    );
  }
}
