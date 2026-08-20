import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';

class CreateNewPasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CreateNewPasswordTextField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CreateNewPasswordTextField> createState() => _CreateNewPasswordTextFieldState();
}

class _CreateNewPasswordTextFieldState extends State<CreateNewPasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: tsLabelLargeSemiBold(Colors.black87),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _isObscured,
            onChanged: widget.onChanged,
            style: tsBodyMediumMedium(Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              isDense: true,
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF575F6F),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
