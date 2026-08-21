import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/images/images.dart';
import '../../widgets/setting_header/setting_header.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF5EB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingHeader(
                title: 'About Us',
                subtitle: 'Tentang aplikasi Samera',
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      ImagesThemes.imgLogoSamera,
                      height: 80,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Samera App',
                      style: tsHeadlineSmallBold(ColorsResources.colorsBlack),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Versi 1.0.0',
                      style: tsBodyMediumMedium(ColorsResources.colorsBlack.withValues(alpha: 0.6)),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Samera adalah aplikasi AI Trip Planner revolusioner yang dirancang khusus untuk memudahkan perjalanan Anda. '
                      'Dengan teknologi AI yang cerdas, Samera membantu Anda menemukan destinasi wisata, merencanakan itinerary harian, '
                      'serta memperkirakan budget yang dibutuhkan selama liburan. Jelajahi tempat-tempat baru dengan panduan interaktif '
                      '360° dan rekomendasi personalisasi terbaik untuk Anda.',
                      textAlign: TextAlign.center,
                      style: tsBodyMediumRegular(ColorsResources.colorsBlack.withValues(alpha: 0.8)).copyWith(
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 16),
                    Text(
                      'Dikembangkan oleh tim Samera © 2026',
                      style: tsBodySmallMedium(ColorsResources.colorsBlack.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
