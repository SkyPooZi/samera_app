import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/helper/snackbar.dart';
import '../../../../../core/helper/validate_helper.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import '../../../../../core/styles/images/images.dart';
import '../../../../../core/styles/icons/icons.dart';
import '../../widgets/login/auth_button.dart';
import '../../widgets/login/auth_card_container.dart';
import '../../widgets/login/auth_social_button.dart';
import '../../widgets/login/auth_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesThemes.imgBgLogin),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: size.height),
            width: size.width,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Text(
                          "Samera",
                          style: tsRobotoDisplayMediumSemiBold(const Color(0xFF293822)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                        child: RichText(
                          text: TextSpan(
                            text: "Your Journey, Our Guide ",
                            style: tsRobotoBodyMediumSemiBold(const Color(0xFF293822)),
                            children: [
                              TextSpan(
                                text: "\u2665\uFE0E",
                                style: tsRobotoBodyMediumSemiBold(const Color(0xFF293822)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.08),
                        child: AuthCardContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Create Account",
                                  style: tsTitleMediumSemiBold(
                                    const Color(0xFF575F6F),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.005,
                                  ),
                                  child: Text(
                                    "Register to contiune your adventure",
                                    style: tsBodySmallMedium(
                                      Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.03,
                                  ),
                                  child: AuthTextField(
                                    label: "Username",
                                    hint: "skypo_user",
                                    icon: Icons.person_outline,
                                    controller: nameController,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.015,
                                  ),
                                  child: AuthTextField(
                                    label: "Email Or Phone",
                                    hint: "skypo@example.com",
                                    icon: Icons.email_outlined,
                                    controller: emailController,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.015,
                                  ),
                                  child: AuthTextField(
                                    label: "Password",
                                    hint: "******",
                                    icon: Icons.lock_outline,
                                    isPassword: true,
                                    controller: passwordController,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.03,
                                  ),
                                  child: AnimatedBuilder(
                                    animation: Listenable.merge([
                                      nameController,
                                      emailController,
                                      passwordController,
                                    ]),
                                    builder: (context, child) {
                                      final isValid =
                                          (passwordController.text.isNotEmpty &&
                                              ValidateHelper.isPasswordValidateBool(
                                                passwordController.text,
                                              )) &&
                                          (emailController.text.isNotEmpty &&
                                              ValidateHelper.isEmailValidateBool(
                                                emailController.text,
                                              )) &&
                                          (nameController.text.isNotEmpty &&
                                              ValidateHelper.isNormalValidateBool(
                                                nameController.text,
                                              ));

                                      return AuthButton(
                                        text: "Sign Up",
                                        isLoading: _isLoading,
                                        isValid: isValid,
                                        validColor: ColorsResources.colorsPrimary,
                                        invalidColor: Colors.grey.shade400,
                                        textStyle: tsBodyMediumSemiBold(
                                          Colors.white,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          
                                          final prefs = await SharedPreferences.getInstance();
                                          await prefs.setString('registered_username', nameController.text);
                                          await prefs.setString('registered_email', emailController.text);
                                          await prefs.setString('registered_password', passwordController.text);
                                          
                                          await Future.delayed(const Duration(milliseconds: 500));
                                          
                                          if (mounted) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            SnackBarSuccess.showSuccess(
                                              context,
                                              "Berhasil mendaftar",
                                            );
                                            context.pop();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          "or contiune with",
                                          style: tsLabelLargeMedium(
                                            Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AuthSocialButton(
                                          svgAsset: IconsThemes.iconGoogle,
                                          text: "Google",
                                          textStyle: tsLabelLargeBold(
                                            Colors.black87,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: AuthSocialButton(
                                          icon: Icons.facebook,
                                          iconColor: Colors.blue,
                                          text: "Facebook",
                                          textStyle: tsLabelLargeBold(
                                            Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.025,
                                    bottom: size.height * 0.01,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account? ",
                                        style: tsBodySmallMedium(
                                          Colors.grey.shade500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => context.pop(),
                                        child: Text(
                                          "Login",
                                          style: tsBodySmallBold(
                                            ColorsResources.colorsPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.05),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
