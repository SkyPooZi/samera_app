import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../../../../../config/router.dart';
import '../../../../../common/common_destination_card.dart';
import '../../bloc/explore/explore_bloc.dart';
import '../../bloc/explore/explore_event.dart';
import '../../bloc/explore/explore_state.dart';
import '../../widgets/explore_detail/explore_detail_stat_item.dart';
import '../../widgets/explore_detail/explore_detail_divider.dart';

class ExploreDetailScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String subtitle;
  final String destinationsCount;
  final String heritageCount;
  final String cuisineCount;
  final String experienceCount;
  final String description;

  const ExploreDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    this.subtitle = 'Kota Budaya & Pelajar',
    this.destinationsCount = '120+',
    this.heritageCount = '35+',
    this.cuisineCount = '80+',
    this.experienceCount = '50+',
    this.description = 'Yogyakarta adalah jantung budaya jawa yang kaya akan sejarah, seni dan kemudahan bagi setiap pelancong.',
  });

  @override
  State<ExploreDetailScreen> createState() => _ExploreDetailScreenState();
}

class _ExploreDetailScreenState extends State<ExploreDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch event untuk mengambil rekomendasi sesuai nama kota
    context.read<ExploreBloc>().add(LoadDetailRecommendations(widget.title));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181C24),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.5,
            child: Image.network(widget.imageUrl, fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.4),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.06,
                          size.width * 0.08,
                          size.width * 0.06,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: tsHeadlineMediumSemiBold(ColorsResources.colorsPrimary),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              widget.subtitle,
                              style: tsBodyMediumMedium(Colors.grey[600]!),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ExploreDetailStatItem(
                                  icon: Icons.location_on,
                                  count: widget.destinationsCount,
                                  label: 'Destinasi',
                                ),
                                const ExploreDetailDivider(),
                                ExploreDetailStatItem(
                                  icon: Icons.account_balance,
                                  count: widget.heritageCount,
                                  label: 'Sejarah',
                                ),
                                const ExploreDetailDivider(),
                                ExploreDetailStatItem(
                                  icon: Icons.restaurant,
                                  count: widget.cuisineCount,
                                  label: 'Kuliner',
                                ),
                                const ExploreDetailDivider(),
                                ExploreDetailStatItem(
                                  icon: Icons.person,
                                  count: widget.experienceCount,
                                  label: 'Pengalaman',
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.03),
                            Text(
                              widget.description,
                              style: tsBodyMediumRegular(Colors.black87)
                                  .copyWith(height: 1.5),
                            ),
                            SizedBox(height: size.height * 0.04),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.5,
                        ),
                        padding: EdgeInsets.only(
                          top: size.width * 0.02,
                          bottom: size.width * 0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                              child: Text(
                                'Rekomendasi untuk anda',
                                style: tsBodyLargeSemiBold(Colors.black87),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            SizedBox(
                              height: size.height * 0.24,
                              child: BlocBuilder<ExploreBloc, ExploreState>(
                                builder: (context, state) {
                                  if (state is ExploreLoaded) {
                                    final recommendations =
                                        state.detailRecommendations ?? [];

                                    if (recommendations.isEmpty) {
                                      return const Center(
                                        child: Text('Tidak ada rekomendasi'),
                                      );
                                    }

                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                                      itemCount: recommendations.length,
                                      itemBuilder: (context, index) {
                                        final destination =
                                            recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 12.0,
                                          ),
                                          child: CommonDestinationCard(
                                            margin: EdgeInsets.zero,
                                            title: destination.name,
                                            location: destination.category,
                                            rating: destination.rating,
                                            id: destination.id,
                                            imageUrl: destination.image,
                                            onTap: () {
                                              context.pushNamed(
                                                Routes.detailDestination,
                                                extra: destination,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }

                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsResources.colorsPrimary,
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Tidak ada tambahan SizedBox agar jarak bawah pas
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
