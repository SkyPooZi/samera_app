import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_event.dart';
import '../bloc/account/account_state.dart';
import 'account_trip_card.dart';

class AccountTripPlannerSection extends StatelessWidget {
  const AccountTripPlannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'List Trip Plan',
                style: tsTitleSmallSemiBold(ColorsResources.colorsBlack),
              ),
              GestureDetector(
                onTap: () {
                  context.push('/account/saved-trips');
                },
                child: Text(
                  'Lihat Semua',
                  style: tsBodyMediumMedium(
                    ColorsResources.colorsBlack.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AccountError) {
              return Center(child: Text(state.message));
            }
            if (state is AccountLoaded) {
              final plans = state.savedTripPlans;
              if (plans.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Belum ada trip plan',
                        style: tsBodyMediumMedium(ColorsResources.colorsBlack),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AccountBloc>().add(LoadSavedTripPlans());
                          context.push('/trip-planner');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsResources.colorsPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Mulai Buat Trip',
                          style: tsBodyMediumSemiBold(Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Take top 2
              final displayPlans = plans.take(2).toList();
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDDB),
                  borderRadius: BorderRadius.circular(24),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.05],
                  ),
                ),
                child: Column(
                  children: displayPlans.asMap().entries.map((entry) {
                    final index = entry.key;
                    final plan = entry.value;
                    final title = plan.items.isNotEmpty ? plan.items.first.destination.name : plan.city;
                    final location = plan.items.isNotEmpty ? plan.items.first.destination.location : plan.city;
                    final image = plan.items.isNotEmpty ? plan.items.first.destination.image : '';

                    return Padding(
                      padding: EdgeInsets.only(bottom: index == displayPlans.length - 1 ? 0 : 16.0),
                      child: AccountTripCard(
                        title: title,
                        date: '${plan.durationDays} Hari',
                        location: location,
                        imageUrl: image,
                        onTap: () {
                          context.push('/trip-plan', extra: plan);
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
