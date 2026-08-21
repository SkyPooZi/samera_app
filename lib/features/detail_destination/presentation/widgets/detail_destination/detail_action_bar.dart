import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/features/favorite/presentation/bloc/favorite/favorite_cubit.dart';
import 'package:samera_app/features/favorite/presentation/bloc/favorite/favorite_state.dart';

class DetailActionBar extends StatelessWidget {
  final double progress;
  final String destinationId;

  const DetailActionBar({super.key, required this.progress, required this.destinationId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsets.only(
        top: topPadding + 12,
        bottom: 12,
        left: size.width * 0.06,
        right: size.width * 0.06,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: progress),
        boxShadow: progress > 0.5
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05 * progress),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => context.pop(),
            child: CircleAvatar(
              backgroundColor: Color.lerp(
                ColorsResources.colorsPrimary,
                Colors.white.withValues(alpha: 0.0), // transparent when scrolled
                progress,
              ),
              radius: 20,
              child: Icon(
                Icons.chevron_left,
                color: Color.lerp(
                  Colors.white,
                  ColorsResources.colorsPrimary,
                  progress,
                ),
                size: 28,
              ),
            ),
          ),
          // Action Buttons
          Row(
            children: [
              BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  final isFavorite = state.favoriteIds.contains(destinationId);
                  return GestureDetector(
                    onTap: () {
                      context.read<FavoriteCubit>().toggleFavorite(destinationId);
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.lerp(
                        ColorsResources.colorsPrimary,
                        Colors.white.withValues(alpha: 0.0), // transparent when scrolled
                        progress,
                      ),
                      radius: 20,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite 
                            ? Colors.red 
                            : Color.lerp(
                                Colors.white,
                                ColorsResources.colorsPrimary,
                                progress,
                              ),
                        size: 20,
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: Color.lerp(
                  ColorsResources.colorsPrimary,
                  Colors.white.withValues(alpha: 0.0), // transparent when scrolled
                  progress,
                ),
                radius: 20,
                child: Icon(
                  Icons.send,
                  color: Color.lerp(
                    Colors.white,
                    ColorsResources.colorsPrimary,
                    progress,
                  ),
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
