import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router.dart';
import '../../../../../common/common_destination_card.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../../bloc/category_destination/category_destination_bloc.dart';
import '../../bloc/category_destination/category_destination_event.dart';
import '../../bloc/category_destination/category_destination_state.dart';

class CategoryDestinationScreen extends StatefulWidget {
  final String categoryId;
  final String title;

  const CategoryDestinationScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  State<CategoryDestinationScreen> createState() => _CategoryDestinationScreenState();
}

class _CategoryDestinationScreenState extends State<CategoryDestinationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryDestinationBloc>().add(
          LoadDestinationsByCategory(widget.categoryId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.title,
          style: tsBodyMediumSemiBold(Colors.black87).copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryDestinationBloc, CategoryDestinationState>(
        builder: (context, state) {
          if (state is CategoryDestinationLoading || state is CategoryDestinationInitial) {
            return const Center(
              child: CircularProgressIndicator(color: ColorsResources.colorsPrimary),
            );
          } else if (state is CategoryDestinationError) {
            return Center(child: Text(state.message));
          } else if (state is CategoryDestinationLoaded) {
            final destinations = state.destinations;

            if (destinations.isEmpty) {
              return Center(
                child: Text(
                  'Belum ada data untuk kategori ini.',
                  style: tsBodyMediumRegular(Colors.grey),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(24.0),
              itemCount: destinations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return SizedBox(
                  height: 240, // Tinggi card agar stabil di vertical list
                  child: CommonDestinationCard(
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
