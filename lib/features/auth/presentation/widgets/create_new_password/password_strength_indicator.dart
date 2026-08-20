import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int strength; // 0 to 6

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    final clampedStrength = strength.clamp(0, 6);
    
    String strengthText = "Lemah";
    Color strengthColor = Colors.red;
    
    if (clampedStrength >= 4) {
      strengthText = "Kuat";
      strengthColor = ColorsResources.colorsPrimary;
    } else if (clampedStrength >= 2) {
      strengthText = "Sedang";
      strengthColor = Colors.orange;
    }

    return Row(
      children: [
        ...List.generate(6, (index) {
          final isActive = index < clampedStrength;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: isActive ? ColorsResources.colorsPrimary : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
        const SizedBox(width: 4),
        Text(
          strengthText,
          style: tsLabelLargeMedium(strengthColor),
        ),
      ],
    );
  }
}
