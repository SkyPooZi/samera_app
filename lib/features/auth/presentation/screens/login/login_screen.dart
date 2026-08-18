import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/helper/snackbar.dart';
import '../../../../../core/helper/validate_helper.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import '../../../../navigation/presentation/screens/navbar_screen.dart';
import '../../widgets/login/auth_button.dart';
import '../../widgets/login/auth_card_container.dart';
import '../../widgets/login/auth_social_button.dart';
import '../../widgets/login/auth_text_field.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _emailError;

  @override
  void dispose() {
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
            image: AssetImage('assets/images/bg-login-asset.jpg'),
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
                          style: tsDisplayMediumSemiBold(
                            const Color(0xFF293822),
                          ).copyWith(fontFamily: 'RobotoSlab'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                        child: RichText(
                          text: TextSpan(
                            text: "Your Journey, Our Guide ",
                            style: tsBodyMediumSemiBold(const Color(0xFF293822))
                                .copyWith(fontFamily: 'RobotoSlab'),
                            children: [
                              TextSpan(
                                text: "\u2665\uFE0E",
                                style: tsBodyMediumSemiBold(
                                  const Color(0xFF293822),
                                ).copyWith(fontFamily: 'RobotoSlab'),
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
                                  "Welcome Back!",
                                  style: tsTitleMediumSemiBold(
                                    const Color(0xFF575F6F),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.005,
                                  ),
                                  child: Text(
                                    "Login to contiune your adventure",
                                    style: tsBodySmallMedium(
                                      Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AuthTextField(
                                        label: "Email Or Phone",
                                        hint: "skypo@example.com",
                                        icon: Icons.email_outlined,
                                        controller: emailController,
                                      ),
                                      if (_emailError != null)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                                          child: Text(
                                            _emailError!,
                                            style: tsBodySmallMedium(Colors.red),
                                          ),
                                        ),
                                    ],
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
                                    top: size.height * 0.01,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const ForgotPasswordScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style: tsLabelLargeSemiBold(
                                          const Color(0xFFF97316),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                  ),
                                  child: AnimatedBuilder(
                                    animation: Listenable.merge([
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
                                              ));

                                      return AuthButton(
                                        text: "Login",
                                        isLoading: _isLoading,
                                        isValid: isValid,
                                        validColor: const Color(0xFFF97316),
                                        invalidColor: Colors.grey.shade400,
                                        textStyle: tsBodyMediumSemiBold(
                                          Colors.white,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                            _emailError = null;
                                          });

                                          final prefs = await SharedPreferences.getInstance();
                                          final savedEmail = prefs.getString('registered_email');
                                          final savedPassword = prefs.getString('registered_password');

                                          await Future.delayed(const Duration(milliseconds: 500));

                                          if (mounted) {
                                            setState(() {
                                              _isLoading = false;
                                            });

                                            if (savedEmail == null || savedEmail != emailController.text) {
                                              setState(() {
                                                _emailError = "Email tidak terdaftar";
                                              });
                                            } else if (savedPassword != passwordController.text) {
                                              SnackBarError.showError(
                                                context,
                                                "Password salah",
                                              );
                                            } else {
                                              await prefs.setBool('isLogin', true);
                                              SnackBarSuccess.showSuccess(
                                                context,
                                                "Berhasil masuk",
                                              );
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const NavbarScreen(index: 0),
                                                ),
                                              );
                                            }
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
                                          svgAsset:
                                              'assets/icons/google-asset.svg',
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
                                        "Dont' have an account? ",
                                        style: tsBodySmallMedium(
                                          Colors.grey.shade500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        ),
                                        child: Text(
                                          "Sign Up",
                                          style: tsBodySmallBold(
                                            const Color(0xFFF97316),
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
