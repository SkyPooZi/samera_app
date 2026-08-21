import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSocialButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? svgAsset;
  final String text;
  final TextStyle textStyle;

  const AuthSocialButton({
    super.key,
    this.icon,
    this.iconColor,
    this.svgAsset,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.012,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgAsset != null)
            SvgPicture.asset(
              svgAsset!,
              width: size.width * 0.06,
              height: size.width * 0.06,
            )
          else if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: size.width * 0.06,
            ),
          SizedBox(width: size.width * 0.015),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
