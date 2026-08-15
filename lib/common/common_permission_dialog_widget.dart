import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/styles/animations/animations.dart';
import 'common_button.dart';

class CommonPermissionDialogWidget extends StatelessWidget {
  final bool isPermissionLocation;
  final VoidCallback onPressed;

  const CommonPermissionDialogWidget({
    super.key,
    required this.isPermissionLocation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Center(
          child: Lottie.asset(
        AnimationsThemes.animationFailed,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              isPermissionLocation == true
                  ? "Izin lokasi diperlukan! \nBerikan izin akses lokasi melalui pengaturan aplikasi Anda."
                  : "Lokasi Diperlukan! \nAktifkan lokasi di pengaturan perangkat Anda.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        CommonButton(
          text: "Oke",
          onPressed: onPressed,
          haveRequirement: false,
        ),
      ],
    );
  }
}
