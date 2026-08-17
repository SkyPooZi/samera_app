import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

class ExploreDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ExploreDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181C24),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.5,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.4),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF181C24),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.06,
                          size.width * 0.08,
                          size.width * 0.06,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: tsHeadlineMediumSemiBold(Colors.white),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              'Kota Budaya & Pelajar',
                              style: tsBodyMediumMedium(Colors.grey[300]!),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatItem(
                                  Icons.location_on,
                                  '120+',
                                  'Destination',
                                ),
                                _buildDivider(),
                                _buildStatItem(
                                  Icons.account_balance,
                                  '35+',
                                  'Heritage',
                                ),
                                _buildDivider(),
                                _buildStatItem(
                                  Icons.restaurant,
                                  '80+',
                                  'Kuliner',
                                ),
                                _buildDivider(),
                                _buildStatItem(
                                  Icons.person,
                                  '50+',
                                  'Pengalaman',
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.03),
                            Text(
                              'Yogyakarta adalah jantung budaya jawa yang kaya akan sejarah, seni dan keramahan penduduknya.',
                              style: tsBodyMediumRegular(Colors.grey[300]!)
                                  .copyWith(height: 1.5),
                            ),
                            SizedBox(height: size.height * 0.04),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.5,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        padding: EdgeInsets.all(size.width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rekomendasi untuk anda',
                              style: tsBodyLargeSemiBold(Colors.black87),
                            ),
                            SizedBox(height: size.height * 0.3),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(count, style: tsBodyMediumSemiBold(Colors.white)),
        const SizedBox(height: 2),
        Text(label, style: tsLabelLargeMedium(Colors.grey[300]!)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: Colors.grey[600]);
  }
}
