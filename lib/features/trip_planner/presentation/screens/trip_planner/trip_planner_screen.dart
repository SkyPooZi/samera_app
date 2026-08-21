import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/images/images.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_planner/trip_preference_card.dart';
import 'package:samera_app/features/trip_planner/presentation/screens/trip_plan/trip_plan_screen.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_planner/trip_input_dialog.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_planner/trip_dropdown_dialogs.dart';
import 'package:samera_app/features/trip_planner/presentation/bloc/trip_planner/trip_planner_bloc.dart';
import 'package:samera_app/features/trip_planner/presentation/bloc/trip_planner/trip_planner_event.dart';
import 'package:samera_app/features/trip_planner/presentation/bloc/trip_planner/trip_planner_state.dart';
import 'package:samera_app/features/trip_planner/domain/entities/trip_preference_entity.dart';
import 'package:samera_app/core/utils/format_utils.dart';

class TripPlannerScreen extends StatelessWidget {
  const TripPlannerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<TripPlannerBloc, TripPlannerState>(
        listener: (context, state) {
          if (state.status == TripPlannerStatus.loaded) {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TripPlanScreen()),
            );
          } else if (state.status == TripPlannerStatus.error) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Gagal menghitung trip'),
              ),
            );
          }
        },
        builder: (context, state) {
          final isFormValid = state.budget.isNotEmpty &&
              state.duration.isNotEmpty &&
              state.transportation.isNotEmpty &&
              state.interest.isNotEmpty &&
              state.favoriteCity.isNotEmpty &&
              state.groupSize.isNotEmpty;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  height: height * 0.35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/bg-trip-planner-asset.png',
                      ),
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
                              // Robot Image
                              SizedBox(
                                height: 120,
                                child: ClipRRect(
                                  child: Image.asset(
                                    ImagesThemes.imgRobotFace,
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
                                'Asisten perjalanan pribadi Anda',
                                style: tsBodyMediumSemiBold(Colors.white)
                                    .copyWith(
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.3,
                                          ),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
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
                        'Ayo, atur preferensi trip Anda!',
                        style: tsBodyMediumSemiBold(Colors.black87),
                      ),
                      SizedBox(height: height * 0.03),

                      TripPreferenceCard(
                        icon: Icons.account_balance_wallet,
                        iconBackgroundColor: Colors.green.withValues(alpha: 0.1),
                        iconColor: Colors.green,
                        title: 'Anggaran',
                        value: FormatUtils.formatBudgetLabel(state.budget),
                        onTap: () => showTripInputDialog(
                          context,
                          title: 'Atur Anggaran',
                          placeholder: 'contoh: 5000000',
                          isNumeric: true,
                          isBudget: true,
                          onSave: (val) => context.read<TripPlannerBloc>().add(
                            UpdateTripPreference(budget: val),
                          ),
                        ),
                      ),

                      TripPreferenceCard(
                        icon: Icons.calendar_today,
                        iconBackgroundColor: Colors.blue.withValues(alpha: 0.1),
                        iconColor: Colors.blue,
                        title: 'Durasi',
                        value: state.duration.isNotEmpty ? state.duration : '-',
                        onTap: () => showTripInputDialog(
                          context,
                          title: 'Atur Durasi',
                          placeholder: 'contoh: 3',
                          isNumeric: true,
                          onSave: (val) => context.read<TripPlannerBloc>().add(
                            UpdateTripPreference(duration: val),
                          ),
                        ),
                      ),

                      TripPreferenceCard(
                        icon: Icons.directions_car,
                        iconBackgroundColor: Colors.indigo.withValues(alpha: 0.1),
                        iconColor: Colors.indigo,
                        title: 'Transportasi',
                        value: FormatUtils.formatTransportationLabel(state.transportation),
                        onTap: () => showTransportationDialog(
                          context,
                          currentValue: state.transportation,
                          onSave: (val) => context.read<TripPlannerBloc>().add(
                            UpdateTripPreference(transportation: val),
                          ),
                        ),
                      ),

                      TripPreferenceCard(
                        icon: Icons.favorite,
                        iconBackgroundColor: Colors.red.withValues(alpha: 0.1),
                        iconColor: Colors.red,
                        title: 'Minat',
                        value: state.interest.isEmpty
                            ? 'Pilih minat Anda'
                            : FormatUtils.formatInterestLabel(state.interest),
                        onTap: () => showInterestDialog(
                          context,
                          currentValues: state.interest.isEmpty
                              ? []
                              : state.interest.split(','),
                          onSave: (vals) => context.read<TripPlannerBloc>().add(
                            UpdateTripPreference(interest: vals.join(',')),
                          ),
                        ),
                      ),

                      TripPreferenceCard(
                        icon: Icons.location_on,
                        iconBackgroundColor: Colors.teal.withValues(alpha: 0.1),
                        iconColor: Colors.teal,
                        title: 'Kota Favorit',
                        value: FormatUtils.formatCityLabel(state.favoriteCity),
                        onTap: () => showCityDialog(
                          context,
                          currentValue: state.favoriteCity,
                          onSave: (val) => context.read<TripPlannerBloc>().add(
                            UpdateTripPreference(favoriteCity: val),
                          ),
                        ),
                      ),

                      TripPreferenceCard(
                        icon: Icons.group,
                        iconBackgroundColor: Colors.purple.withValues(alpha: 0.1),
                        iconColor: Colors.purple,
                        title: 'Jumlah Orang',
                        value: state.groupSize.isNotEmpty
                            ? state.groupSize
                            : '-',
                        onTap: () => showTripInputDialog(
                          context,
                          title: 'Atur Jumlah Orang',
                          placeholder: 'contoh: 2',
                          isNumeric: true,
                          onSave: (val) => context.read<TripPlannerBloc>().add(
                            UpdateTripPreference(groupSize: val),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),
                      SizedBox(
                        width: double.infinity,
                        height: 56, // Fixed height for standard button
                        child: ElevatedButton(
                          onPressed: (state.status == TripPlannerStatus.loading || !isFormValid)
                              ? null
                              : () {
                                  final pref = TripPreferenceEntity(
                                    budget: double.tryParse(state.budget) ?? 0,
                                    durationDays:
                                        int.tryParse(state.duration) ?? 1,
                                    transportation: state.transportation.isEmpty
                                        ? 'motor'
                                        : state.transportation,
                                    interests: state.interest.isEmpty
                                        ? []
                                        : state.interest.split(','),
                                    favoriteCity: state.favoriteCity,
                                    numberOfPeople:
                                        int.tryParse(state.groupSize) ?? 1,
                                  );



                                  context.read<TripPlannerBloc>().add(
                                    GenerateTripPlanEvent(pref),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFE813C),
                            disabledBackgroundColor: Colors.grey[300],
                            disabledForegroundColor: Colors.grey[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: state.status == TripPlannerStatus.loading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
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
          );
        },
      ),
    );
  }
}