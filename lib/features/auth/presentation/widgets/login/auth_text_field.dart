import 'package:flutter/material.dart';

import '../../../../../core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

import 'package:flutter/services.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.015,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.02),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDD5), // Hardcoded icon background color
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              widget.icon,
              color: ColorsResources.colorsPrimary, // Hardcoded icon color
              size: size.width * 0.045,
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: tsLabelLargeMedium(
                    Colors.grey.shade500,
                  ), // Hardcoded style
                ),
                SizedBox(
                  height: size.height * 0.035,
                  child: TextField(
                    controller: widget.controller,
                    maxLength: widget.maxLength,
                    inputFormatters: widget.inputFormatters,
                    onChanged: widget.onChanged,
                    obscureText: widget.isPassword
                        ? !_isPasswordVisible
                        : false,
                    style: tsBodySmallMedium(Colors.black87), // Hardcoded style
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      counterText: "", // Hide default counter
                      hintStyle: tsBodySmallMedium(
                        Colors.grey.shade400,
                      ), // Hardcoded style
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: size.height * 0.015,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.isPassword)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.01),
                child: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey.shade400,
                  size: size.width * 0.045,
                ),
              ),
            )
          else if (widget.maxLength != null)
            AnimatedBuilder(
              animation: widget.controller,
              builder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(right: size.width * 0.01),
                  child: Text(
                    "${widget.controller.text.length}/${widget.maxLength}",
                    style: tsBodySmallMedium(Colors.grey.shade400),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
