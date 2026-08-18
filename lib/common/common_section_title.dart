import 'package:flutter/material.dart';
import '../core/styles/typography/text_styles.dart';
import '../core/styles/colors/colors.dart';

class CommonSectionTitle extends StatelessWidget {
  final String title;
  
  const CommonSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: tsTitleSmallSemiBold(ColorsResources.colorsBlack),
        ),
      ),
    );
  }
}
