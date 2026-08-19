import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class InboxVerificationButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isValid;
  final Color validColor;
  final Color invalidColor;
  final TextStyle textStyle;

  const InboxVerificationButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isValid = false,
    required this.validColor,
    required this.invalidColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (isValid && !isLoading) ? onPressed : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.016,
          horizontal: size.width * 0.04,
        ),
        decoration: BoxDecoration(
          color: isValid ? validColor : invalidColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: size.height * 0.02,
                  width: size.height * 0.02,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24), // balance for center alignment
                  Text(text, style: textStyle),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: ColorsResources.colorsPrimary,
                      size: 14,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
