import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/styles/colors/colors.dart';

class ShimmerCommon extends StatelessWidget {
  final double? height, width, radius;

  const ShimmerCommon({super.key, this.height, this.width, this.radius = 1});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outline,
      highlightColor: Theme.of(context).colorScheme.outline,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorsResources.colorsBlack.withAlpha(204),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        ),
      ),
    );
  }
}
