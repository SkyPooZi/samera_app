import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class PasswordRequirementBox extends StatelessWidget {
  final String password;

  const PasswordRequirementBox({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final hasMinLength = password.length >= 8;
    final hasUpperAndLowerCase = password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4EE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password harus mengandung:",
            style: tsLabelLargeSemiBold(const Color(0xFF575F6F)),
          ),
          const SizedBox(height: 12),
          _buildRequirement("Minimal 8 karakter", hasMinLength),
          const SizedBox(height: 8),
          _buildRequirement("Huruf besar dan kecil", hasUpperAndLowerCase),
          const SizedBox(height: 8),
          _buildRequirement("Angka", hasNumber),
          const SizedBox(height: 8),
          _buildRequirement("Karakter spesial (!@#\$%^&*)", hasSpecialChar),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: isMet ? ColorsResources.colorsPrimary : Colors.grey.shade400,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: tsLabelLargeMedium(
            isMet ? const Color(0xFF575F6F) : Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
