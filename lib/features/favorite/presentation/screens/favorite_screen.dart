import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/favorite/presentation/widgets/favorite_destination_card.dart';
import 'package:samera_app/config/router.dart';
import 'package:samera_app/features/favorite/presentation/bloc/favorite/favorite_cubit.dart';
import 'package:samera_app/features/favorite/presentation/bloc/favorite/favorite_state.dart';
import 'package:samera_app/features/trip_planner/data/datasources/local/trip_planner_local_data_source.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<DestinationEntity>> _destinationsFuture;

  @override
  void initState() {
    super.initState();
    _destinationsFuture = TripPlannerLocalDataSourceImpl().getAllDestinations();
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
          'Destinasi Favorit',
          style: tsBodyMediumSemiBold(Colors.black87).copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state.favoriteIds.isEmpty) {
            return Center(
              child: Text(
                'Belum ada destinasi favorit.',
                style: tsBodyMediumRegular(Colors.grey),
              ),
            );
          }

          return FutureBuilder<List<DestinationEntity>>(
            future: _destinationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: ColorsResources.colorsPrimary));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Terjadi kesalahan memuat data', style: tsBodyMediumRegular(Colors.grey)));
              }

              final allDestinations = snapshot.data ?? [];
              final favoriteDestinations = allDestinations
                  .where((dest) => state.favoriteIds.contains(dest.id))
                  .toList();

              if (favoriteDestinations.isEmpty) {
                return Center(
                  child: Text(
                    'Destinasi favorit tidak ditemukan.',
                    style: tsBodyMediumRegular(Colors.grey),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(24.0),
                itemCount: favoriteDestinations.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final destination = favoriteDestinations[index];
                  return FavoriteDestinationCard(
                    destination: destination,
                    onTap: () {
                      context.pushNamed(
                        Routes.detailDestination,
                        extra: destination,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
