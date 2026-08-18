import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';

class ForgotPasswordTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const ForgotPasswordTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
  });

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
              color: const Color(0xFFFFEDD5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFF97316),
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
                  label,
                  style: tsLabelLargeMedium(
                    Colors.grey.shade500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                  child: TextField(
                    controller: controller,
                    style: tsBodySmallMedium(Colors.black87),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: tsBodySmallMedium(
                        Colors.grey.shade400,
                      ),
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
        ],
      ),
    );
  }
}
