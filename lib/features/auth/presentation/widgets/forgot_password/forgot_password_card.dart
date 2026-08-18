import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordCardContainer extends StatelessWidget {
  final Widget child;

  const ForgotPasswordCardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: size.width,
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            size.height * 0.06, 
            size.width * 0.06,
            size.height * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: child,
        ),
        Positioned(
          top: 0,
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFEF2E8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/mail-asset.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
