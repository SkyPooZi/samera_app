import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    this.isLoading = false,
    this.elevation,
    super.key,
    required this.text,
    required this.onPressed,
    required this.haveRequirement,
    this.requirementComplete,
    this.width,
    this.height,
    this.style,
    this.borderRadius,
    this.backgroundColor,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.widget,
  });

  final double? elevation;
  final bool haveRequirement;
  final bool? requirementComplete;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? widget;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (onPressed != null)
          ? isLoading
              ? () {}
              : (haveRequirement
                  ? (requirementComplete == true ? onPressed : () {})
                  : onPressed)
          : null,
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 1,
        backgroundColor: isLoading
            ? Theme.of(context).colorScheme.secondary
            : haveRequirement
                ? (requirementComplete == true
                    ? (backgroundColor ?? Theme.of(context).colorScheme.primary)
                    : Theme.of(context).colorScheme.secondary)
                : backgroundColor ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.0,
          ),
        ),
        minimumSize: Size(width ?? 0, height ?? 0),
        padding: padding ??
            const EdgeInsets.only(
              left: 16.0,
              top: 12.0,
              right: 16.0,
              bottom: 12.0,
            ),
      ),
      child: Center(
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).cardColor,
                  strokeWidth: 3,
                ),
              )
            : widget ??
                Text(
                  text,
                  style: style ??
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).cardColor,
                          ),
                ),
      ),
    );
  }
}
