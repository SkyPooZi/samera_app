import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samera_app/features/favorite/presentation/bloc/favorite/favorite_cubit.dart';
import 'package:samera_app/features/favorite/presentation/bloc/favorite/favorite_state.dart';

import '../core/styles/typography/text_styles.dart';
import '../core/styles/colors/colors.dart';

class CommonDestinationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final String id;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final EdgeInsetsGeometry? margin;

  const CommonDestinationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.id,
    this.onTap,
    this.onFavoriteTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
        margin: margin ?? const EdgeInsets.only(left: 24.0),
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
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final isFavorite = state.favoriteIds.contains(id);
                    return GestureDetector(
                      onTap: () {
                        context.read<FavoriteCubit>().toggleFavorite(id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          color: ColorsResources.colorsPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: size.width * 0.04,
                        ),
                      ),
                    );
                  }
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tsBodyLargeSemiBold(ColorsResources.colorsWhite),
                  ),
                  SizedBox(height: size.height * 0.002),
                  Text(
                    location,
                    style: tsLabelLargeMedium(ColorsResources.colorsWhite),
                    overflow: TextOverflow.ellipsis,
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
