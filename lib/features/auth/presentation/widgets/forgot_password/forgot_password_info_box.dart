import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class ForgotPasswordInfoBox extends StatelessWidget {
  final String text;
  const ForgotPasswordInfoBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4EE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: ColorsResources.colorsPrimary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: tsLabelLargeMedium(ColorsResources.colorsPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
