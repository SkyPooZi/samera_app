import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class ExploreRegionCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const ExploreRegionCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: ColorsResources.colorsPrimary,
                  width: 2,
                )
              : null,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isSelected
                ? ColorsResources.colorsPrimary.withValues(alpha: 0.4)
                : Colors.black.withValues(alpha: 0.4),
          ),
          alignment: Alignment.bottomCenter,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: tsLabelLargeSemiBold(Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
