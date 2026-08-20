import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';

import '../../widgets/detail_destination/detail_header_image.dart';
import '../../widgets/detail_destination/detail_info_section.dart';
import '../../widgets/detail_destination/detail_media_row.dart';
import '../../widgets/detail_destination/detail_description_section.dart';
import '../../widgets/detail_destination/detail_quick_info_section.dart';
import '../../widgets/detail_destination/detail_action_bar.dart';

class DetailDestinationScreen extends StatefulWidget {
  final DestinationEntity destination;

  const DetailDestinationScreen({super.key, required this.destination});

  @override
  State<DetailDestinationScreen> createState() => _DetailDestinationScreenState();
}

class _DetailDestinationScreenState extends State<DetailDestinationScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Dynamic header transition calculations
    final double bannerHeight = size.height * 0.44;
    final double topPadding = MediaQuery.paddingOf(context).top;
    final double transitionEnd = bannerHeight - kToolbarHeight - topPadding;
    final double progress = (_scrollOffset / (transitionEnd > 0 ? transitionEnd : 1.0)).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: ColorsResources.colorsWhite,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                // Header Image
                DetailHeaderImage(
                  imageUrl: widget.destination.image,
                  height: size.height * 0.48,
                ),

                // Content Container
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.44),
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: ColorsResources.colorsWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06, // responsive padding ~24
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Destination Info (Name, Location, Rating)
                      DetailInfoSection(
                        name: widget.destination.name,
                        location: widget.destination.location,
                        rating: widget.destination.rating,
                        reviewCount: widget.destination.reviewCount,
                      ),
                      const SizedBox(height: 24),

                      // Media Options Row (Foto, Video, 360° Tour, Galeri)
                      DetailMediaRow(destination: widget.destination),
                      const SizedBox(height: 24),

                      // Description Section
                      DetailDescriptionSection(
                        description: widget.destination.description,
                        shortDescription: widget.destination.shortDescription,
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colors.grey[200], thickness: 1),
                      const SizedBox(height: 20),

                      // Quick Info Section (Operating Hours, Price, Address)
                      DetailQuickInfoSection(
                        ticketPriceLabel: widget.destination.ticketPriceLabel,
                        address: widget.destination.address,
                      ),
                      const SizedBox(height: 40),

                      // Add to Trip Plan Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsResources.colorsPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Tambah ke Trip Plan',
                                style: tsBodyLargeSemiBold(Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pinned Top Action Buttons (transitions opacity on scroll)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: DetailActionBar(progress: progress),
          ),
        ],
      ),
    );
  }
}
