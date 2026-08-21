import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:go_router/go_router.dart';

class PolicySection {
  final String title;
  final String content;

  PolicySection({required this.title, required this.content});
}

class PolicyDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<PolicySection> sections;
  final String lastUpdated;

  const PolicyDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.sections,
    required this.lastUpdated,
  });

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
              // Custom Back Button
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: tsHeadlineSmallBold(ColorsResources.colorsBlack),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: tsBodyMediumRegular(ColorsResources.colorsBlack.withValues(alpha: 0.8)).copyWith(height: 1.5),
              ),
              const SizedBox(height: 24),
              ...sections.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final section = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$index. ${section.title}',
                        style: tsTitleSmallSemiBold(ColorsResources.colorsBlack),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        section.content,
                        style: tsBodyMediumRegular(ColorsResources.colorsBlack.withValues(alpha: 0.8)).copyWith(height: 1.5),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              Text(
                'Terakhir diperbarui: $lastUpdated',
                style: tsBodySmallMedium(ColorsResources.colorsBlack.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
