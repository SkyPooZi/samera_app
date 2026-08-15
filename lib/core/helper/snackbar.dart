import 'package:flutter/material.dart';
import '../styles/colors/colors.dart';

class SnackBarError {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorsResources.colorsWhite,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}

class SnackBarSuccess {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorsResources.colorsWhite,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
