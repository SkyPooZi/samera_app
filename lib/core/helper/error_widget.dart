import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../styles/animations/animations.dart';
import '../styles/typography/text_styles.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String error;

  const ErrorWidgetCustom({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            AnimationsThemes.animationError,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            width: screenWidth * 0.8,
          ),
        ),
        Text(
          'Oh tidak!',
          style: tsBodySmallSemiBold(
            Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$error\n Silahkan Refresh',
          style: tsBodySmallRegular(
            Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
