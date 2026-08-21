import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/styles/colors/colors.dart';
import '../core/styles/icons/icons.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LogoutConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardTheme.color,
      title: Center(
        child: SvgPicture.asset(IconsThemes.iconWarning),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Apakah Anda yakin ingin keluar Akun?",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: TextButton(
                onPressed: () {
                  onCancel();
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? ColorsResources.colorsBlack
                          : ColorsResources.colorsWhite,
                  foregroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? ColorsResources.colorsWhite
                          : ColorsResources.colorsBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Tidak",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? ColorsResources.colorsWhite
                            : ColorsResources.colorsBlack,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextButton(
                onPressed: () {
                  onConfirm();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).cardTheme.color,
                  foregroundColor: ColorsResources.colorsRed,
                  side: const BorderSide(
                    color: ColorsResources.colorsRed,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Iya",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorsResources.colorsRed,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
