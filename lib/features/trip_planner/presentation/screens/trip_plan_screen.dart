import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_timeline_item.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_day_selector.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_stat_item.dart';

class TripPlanScreen extends StatelessWidget {
  const TripPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('TripPlan', style: tsTitleMediumSemiBold(Colors.black87)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: width * 0.06,
              right: width * 0.06,
              top: height * 0.02,
              bottom: height * 0.25, // Extra padding for the bottom panel
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day Tabs
                const TripDaySelector(),
                SizedBox(height: height * 0.04),

                // Timeline List
                const TripTimelineItem(
                  time: '08.00',
                  title: 'Keraton Yogyakarta',
                  description: 'Jelajahi istana kerjaan dan pelajari sejarah budaya Jawa.',
                  duration: '2 Jam',
                  imageUrl: 'https://images.unsplash.com/photo-1612634636157-10b4497967ef?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                const TripTimelineItem(
                  time: '10.30',
                  title: 'Taman Sari',
                  description: 'Jelajahi istana kerjaan dan pelajari sejarah budaya Jawa.',
                  duration: '2 Jam',
                  imageUrl: 'https://images.unsplash.com/photo-1630214801769-24784bfd2b9c?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                const TripTimelineItem(
                  time: '12.00',
                  title: 'Local Culinary',
                  description: 'Jelajahi istana kerjaan dan pelajari sejarah budaya Jawa.',
                  duration: '2 Jam',
                  imageUrl: 'https://media.istockphoto.com/id/2257797531/photo/nasi-gudeg-a-traditional-food-from-yogyakarta-indonesia-featuring-tender-young-jackfruit-stew.webp?a=1&b=1&s=612x612&w=0&k=20&c=Uh6V_lYmA-ebCS3wIkfF3Sxsk6DquXdBPr_st8PaoOU=',
                ),
                const TripTimelineItem(
                  time: '14.00',
                  title: 'Batik Workshop',
                  description: 'Jelajahi istana kerjaan dan pelajari sejarah budaya Jawa.',
                  duration: '2 Jam',
                  imageUrl: 'https://images.unsplash.com/photo-1616125162686-770bf85622b9?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  isLast: true,
                  dotColor: Colors
                      .teal, // Green dot for the last item as seen in image
                ),
              ],
            ),
          ),

          // Bottom Floating Panel
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                width * 0.06,
                width * 0.06,
                width * 0.06,
                width * 0.08,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TripStatItem(
                        icon: Icons.access_time_filled,
                        iconColor: Colors.blue,
                        title: 'Duration',
                        value: '2 Days',
                      ),
                      SizedBox(width: width * 0.05),
                      TripStatItem(
                        icon: Icons.location_on,
                        iconColor: Colors.green,
                        title: 'Total Destination',
                        value: '10',
                      ),
                      SizedBox(width: width * 0.05),
                      TripStatItem(
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.orange,
                        title: 'Estimasi Budget',
                        value: 'Rp375.000',
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.06),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFE813C),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                                SizedBox(width: width * 0.02),
                                Text(
                                  'Save Trip Plan',
                                  style: tsBodyLargeSemiBold(Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.ios_share,
                            color: Colors.black87,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
