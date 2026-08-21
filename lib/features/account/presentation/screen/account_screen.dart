import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_state.dart';
import '../widgets/account_stats_card.dart';
import '../widgets/account_trip_planner_section.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg-account-asset.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Right Action Icons
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0, top: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.push('/favorite');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: const BoxDecoration(
                                color: ColorsResources.colorsPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              context.push('/setting');
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.orange[400],
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Avatar Profile
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),

                  // Name
                  const SizedBox(height: 16),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      String username = '...';
                      if (state is AccountLoaded) {
                        username = state.username ?? 'SkyPoo';
                      } else if (state is AccountError) {
                        username = 'Error';
                      }
                      return Text(
                        username,
                        style: tsHeadlineSmallBold(ColorsResources.colorsBlack),
                      );
                    },
                  ),

                  // Stats Card
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: const AccountStatsCard(),
                  ),

                  // Trip Planner Section
                  const SizedBox(height: 32),
                  const AccountTripPlannerSection(),

                  // Bottom padding for scrolling over navbar
                  SizedBox(height: screenHeight * 0.15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
