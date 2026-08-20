import 'package:flutter/material.dart';

class ExploreHeaderSection extends StatelessWidget {
  final Widget? child;
  final DecorationImage? backgroundImage;
  final EdgeInsetsGeometry? padding;

  const ExploreHeaderSection({
    super.key,
    this.child,
    this.backgroundImage,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: padding ?? EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: size.width * 0.06,
        right: size.width * 0.06,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        image: backgroundImage,
      ),
      child: child,
    );
  }
}
