import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isValid;
  final Color validColor;
  final Color invalidColor;
  final TextStyle textStyle;

  const AuthButton({
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
        padding: EdgeInsets.symmetric(vertical: size.height * 0.016),
        decoration: BoxDecoration(
          color: isValid ? validColor : invalidColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: size.height * 0.02,
                  width: size.height * 0.02,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(text, style: textStyle),
        ),
      ),
    );
  }
}
