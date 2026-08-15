import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'bloc/success_failed_dialog/success_failed_dialog_cubit.dart';

class CommonSuccessFailedDialog extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onConfirm;

  const CommonSuccessFailedDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.onConfirm,
  });

  @override
  State<CommonSuccessFailedDialog> createState() =>
      _CommonSuccessFailedDialogState();
}

class _CommonSuccessFailedDialogState extends State<CommonSuccessFailedDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        context.read<SuccessFailedDialogCubit>().toggleVisible();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuccessFailedDialogCubit, SuccessFailedDialogState>(
        builder: (context, state) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Center(
          child: Lottie.asset(
            widget.icon,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: state.isButtonDisabled
                  ? null
                  : () {
                      widget.onConfirm();
                    },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                "Oke",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
