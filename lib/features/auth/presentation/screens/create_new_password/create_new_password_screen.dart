import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import '../../widgets/create_new_password/create_new_password_button.dart';
import '../../widgets/create_new_password/create_new_password_card.dart';
import '../../widgets/create_new_password/create_new_password_text_field.dart';
import '../../widgets/create_new_password/password_requirement_box.dart';
import '../../widgets/create_new_password/password_strength_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  int _calculateStrength(String password) {
    if (password.isEmpty) return 0;
    
    int strength = 0;
    if (password.length >= 8) strength += 2;
    if (password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'))) strength += 2;
    if (password.contains(RegExp(r'[0-9]'))) strength += 1;
    if (password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) strength += 1;
    
    return strength; // max 6
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strength = _calculateStrength(_passwordController.text);
    final isValid = strength >= 4 && 
                    _passwordController.text == _confirmController.text && 
                    _passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF2EB), // cream background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black87),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              CreateNewPasswordCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreateNewPasswordTextField(
                      label: "Password Baru",
                      controller: _passwordController,
                      onChanged: (value) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    PasswordStrengthIndicator(strength: strength),
                    const SizedBox(height: 24),
                    CreateNewPasswordTextField(
                      label: "Konfirmasi password",
                      controller: _confirmController,
                      onChanged: (value) => setState(() {}),
                    ),
                    if (_confirmController.text.isNotEmpty && _confirmController.text != _passwordController.text)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Password tidak cocok",
                          style: tsBodySmallMedium(Colors.red),
                        ),
                      ),
                    const SizedBox(height: 24),
                    PasswordRequirementBox(password: _passwordController.text),
                    const SizedBox(height: 32),
                    CreateNewPasswordButton(
                      text: "Konfirmasi",
                      textStyle: tsBodyMediumSemiBold(Colors.white),
                      isValid: isValid,
                      validColor: ColorsResources.colorsPrimary,
                      invalidColor: Colors.grey.shade400,
                      onPressed: () {
                        // Handle password reset
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
