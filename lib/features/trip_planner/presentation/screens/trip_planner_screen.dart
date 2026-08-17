import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_preference_card.dart';
import 'package:samera_app/features/trip_planner/presentation/screens/trip_plan_screen.dart';

class TripPlannerScreen extends StatelessWidget {
  const TripPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: height * 0.35,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg-trip-planner-asset.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    // Illustration Placeholder (Stars/Temples)
                    // (Since we don't have the exact image asset, we'll keep it clean)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Robot SVG
                          SizedBox(
                            height: 120,
                            child: ClipRRect(
                              child: SvgPicture.asset(
                                'assets/icons/robot-face-asset.svg',
                                width: width * 0.6,
                              ),
                            ),
                          ),
                          Text(
                            'AI TRIP PLANNER',
                            style: tsHeadlineSmallBold(Colors.black87),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            'Your personal travel assistant',
                            style: tsBodyMediumSemiBold(Colors.grey[700]!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Section
            Container(
              transform: Matrix4.translationValues(0, -24, 0),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.03,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Come on, set your trip preferences!',
                    style: tsBodyMediumSemiBold(Colors.black87),
                  ),
                  SizedBox(height: height * 0.03),

                  TripPreferenceCard(
                    icon: Icons.account_balance_wallet,
                    iconBackgroundColor: Colors.green.withOpacity(0.1),
                    iconColor: Colors.green,
                    title: 'Budget',
                    value: 'Rp500.000',
                    onTap: () =>
                        _showInputDialog(context, 'Set Budget', 'e.g. 500000'),
                  ),

                  TripPreferenceCard(
                    icon: Icons.calendar_today,
                    iconBackgroundColor: Colors.blue.withOpacity(0.1),
                    iconColor: Colors.blue,
                    title: 'Duration',
                    value: '2 day',
                    onTap: () => _showInputDialog(
                      context,
                      'Set Duration',
                      'e.g. 2 Days',
                    ),
                  ),

                  TripPreferenceCard(
                    icon: Icons.directions_car,
                    iconBackgroundColor: Colors.indigo.withOpacity(0.1),
                    iconColor: Colors.indigo,
                    title: 'Transportation',
                    value: 'Motor',
                    onTap: () => _showInputDialog(
                      context,
                      'Set Transportation',
                      'e.g. Motor',
                    ),
                  ),

                  TripPreferenceCard(
                    icon: Icons.favorite,
                    iconBackgroundColor: Colors.red.withOpacity(0.1),
                    iconColor: Colors.red,
                    title: 'Interest',
                    value: 'Heritage, Cuisine, Cul...',
                    onTap: () => _showInputDialog(
                      context,
                      'Set Interest',
                      'e.g. Heritage, Cuisine',
                    ),
                  ),

                  TripPreferenceCard(
                    icon: Icons.location_on,
                    iconBackgroundColor: Colors.teal.withOpacity(0.1),
                    iconColor: Colors.teal,
                    title: 'Favorite Place',
                    value: 'Malioboro',
                    onTap: () => _showInputDialog(
                      context,
                      'Set Favorite Place',
                      'e.g. Malioboro',
                    ),
                  ),

                  TripPreferenceCard(
                    icon: Icons.group,
                    iconBackgroundColor: Colors.purple.withOpacity(0.1),
                    iconColor: Colors.purple,
                    title: 'Number of people',
                    value: '2 People',
                    onTap: () => _showInputDialog(
                      context,
                      'Set Number of people',
                      'e.g. 2 People',
                    ),
                  ),

                  SizedBox(height: height * 0.02),
                  SizedBox(
                    width: double.infinity,
                    height: 56, // Fixed height for standard button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TripPlanScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFE813C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Hitung Trip Plan',
                        style: tsBodyLargeSemiBold(Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.1), // padding for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInputDialog(
    BuildContext context,
    String title,
    String placeholder,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: tsTitleMediumSemiBold(Colors.black87)),
          content: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: tsBodyMediumRegular(Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: tsBodyMediumMedium(Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A5ACD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Save', style: tsBodyMediumSemiBold(Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
