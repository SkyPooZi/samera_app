import 'package:flutter/material.dart';
import '../../../../../core/styles/typography/text_styles.dart';
import '../../../../../core/styles/images/images.dart';
import '../../widgets/inbox_verification_code/inbox_otp_input.dart';
import '../../widgets/inbox_verification_code/inbox_verification_button.dart';
import '../../widgets/inbox_verification_code/inbox_verification_card.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router.dart';
import '../create_new_password/create_new_password_screen.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class InboxVerificationScreen extends StatefulWidget {
  final String email;
  
  const InboxVerificationScreen({super.key, required this.email});

  @override
  State<InboxVerificationScreen> createState() => _InboxVerificationScreenState();
}

class _InboxVerificationScreenState extends State<InboxVerificationScreen> {
  bool _isCodeComplete = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        child: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),
              // Illustration
              SizedBox(
                height: size.height * 0.2, // increased slightly to give the image more room
                child: Image.asset(
                  ImagesThemes.imgMail,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Cek Email Kamu",
                style: tsTitleLargeSemiBold(const Color(0xFF575F6F)),
              ),
              SizedBox(height: size.height * 0.01),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Kami telah mengirimkan kode verifikasi ke\n",
                  style: tsLabelLargeMedium(Colors.grey.shade500).copyWith(height: 1.4),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: tsLabelLargeSemiBold(ColorsResources.colorsPrimary),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              InboxVerificationCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Masukan kode Verifikasi",
                      style: tsTitleMediumSemiBold(const Color(0xFF575F6F)),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "kode telah dikirim ke email kamu.\nCek inbox atau folder spam.",
                      textAlign: TextAlign.center,
                      style: tsLabelLargeMedium(Colors.grey.shade500).copyWith(height: 1.4),
                    ),
                    SizedBox(height: size.height * 0.03),
                    InboxOtpInput(
                      onCompleted: (code) {
                        setState(() {
                          _isCodeComplete = code.length == 6;
                        });
                      },
                    ),
                    SizedBox(height: size.height * 0.04),
                    RichText(
                      text: TextSpan(
                        text: "kirim ulang code dalam ",
                        style: tsBodySmallMedium(Colors.grey.shade500),
                        children: [
                          TextSpan(
                            text: "00.45",
                            style: tsBodySmallBold(ColorsResources.colorsPrimary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    InboxVerificationButton(
                      text: "Kirim Kode",
                      textStyle: tsBodyMediumSemiBold(Colors.white),
                      isValid: _isCodeComplete,
                      validColor: ColorsResources.colorsPrimary,
                      invalidColor: Colors.grey.shade400,
                      onPressed: () {
                        context.pushNamed(Routes.createNewPassword);
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Column(
                      children: [
                        Text(
                          "Belum menerima code?",
                          style: tsBodySmallMedium(Colors.grey.shade500),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            // Resend logic
                          },
                          child: Text(
                            "Kirim Ulang Kode",
                            style: tsBodySmallBold(ColorsResources.colorsPrimary),
                          ),
                        ),
                      ],
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
