import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../config/router.dart';
import '../core/helper/snackbar.dart';
import '../core/styles/colors/colors.dart';
import 'bloc/logout/logout_cubit.dart';
import 'common_logout_dialog_widget.dart';

class CommonLogout extends StatelessWidget {
  const CommonLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LogoutConfirmationDialog(
              onConfirm: () {
                context.read<LogoutCubit>().logoutEvent();
                context.pop();
                SnackBarSuccess.showSuccess(
                  context,
                  "Berhasil masuk",
                );
                context.pushReplacementNamed(Routes.login);
              },
              onCancel: () {
                context.pop();
              },
            );
          },
        );
      },
      icon: Icon(
        Icons.logout,
        color: Theme.of(context).brightness == Brightness.light
            ? ColorsResources.colorsBlack
            : ColorsResources.colorsWhite,
      ),
    );
  }
}
