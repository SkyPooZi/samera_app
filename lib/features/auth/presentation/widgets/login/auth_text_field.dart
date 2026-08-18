import 'package:flutter/material.dart';

import '../../../../../core/styles/typography/text_styles.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    required this.controller,
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
              color: const Color(0xFFF97316), // Hardcoded icon color
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
                    obscureText: widget.isPassword
                        ? !_isPasswordVisible
                        : false,
                    style: tsBodySmallMedium(Colors.black87), // Hardcoded style
                    decoration: InputDecoration(
                      hintText: widget.hint,
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
            ),
        ],
      ),
    );
  }
}
