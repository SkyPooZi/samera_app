import 'package:flutter/material.dart';

import '../../../../../core/helper/validate_helper.dart';

import '../../../../../core/styles/typography/text_styles.dart';
import '../../../../../core/styles/images/images.dart';
import '../../widgets/forgot_password/forgot_password_button.dart';
import '../../widgets/forgot_password/forgot_password_card.dart';
import '../../widgets/forgot_password/forgot_password_info_box.dart';
import '../../widgets/forgot_password/forgot_password_text_field.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router.dart';
import '../inbox_verification_code/inbox_verification_screen.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.05,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        child: Text(
                          "Forgot\nPassword?",
                          style: tsRobotoDisplayMediumSemiBold(
                            const Color(0xFF1E8276),
                          ).copyWith(height: 1.1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: "Jangan khawatir, kami akan membantu Anda\nmelanjutkan petualangan Anda. ",
                            style: tsBodySmallSemiBold(const Color(0xFF293822)),
                            children: [
                              TextSpan(
                                text: "\u2764\uFE0E",
                                style: tsBodyMediumSemiBold(
                                  const Color(0xFFD32F2F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.08,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        child: ForgotPasswordCardContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Masukan Email",
                                style: tsTitleMediumSemiBold(
                                  const Color(0xFF575F6F),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  bottom: size.height * 0.03,
                                ),
                                child: Text(
                                  "Kami akan mengirimkan kode verifikasi\nemail kamu.",
                                  textAlign: TextAlign.center,
                                  style: tsLabelLargeMedium(
                                    Colors.grey.shade500,
                                  ).copyWith(height: 1.4),
                                ),
                              ),
                              ForgotPasswordTextField(
                                label: "Email",
                                hint: "skypo@example.com",
                                icon: Icons.email_rounded,
                                controller: emailController,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                child: const ForgotPasswordInfoBox(
                                  text: "Pastikan email yang kamu masukkan\nsudah benar dan aktif",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.03,
                                ),
                                child: AnimatedBuilder(
                                  animation: emailController,
                                  builder: (context, child) {
                                    final isValid = emailController.text.isNotEmpty &&
                                        ValidateHelper.isEmailValidateBool(emailController.text);
                                    
                                    return ForgotPasswordButton(
                                      text: "Kirim Kode",
                                      textStyle: tsBodyMediumSemiBold(Colors.white),
                                      isValid: isValid,
                                      validColor: ColorsResources.colorsPrimary,
                                      invalidColor: Colors.grey.shade400,
                                      onPressed: () {
                                        context.pushNamed(
                                          Routes.inboxVerification,
                                          extra: emailController.text,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.03,
                                  bottom: size.height * 0.01,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ingat password? ",
                                      style: tsLabelLargeMedium(
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
