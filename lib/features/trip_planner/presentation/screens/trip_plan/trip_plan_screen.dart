import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/trip_planner/presentation/bloc/trip_planner/trip_planner_event.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_plan/trip_day_selector.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_plan/trip_stat_item.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_plan/trip_timeline_item.dart';
import 'package:samera_app/features/trip_planner/presentation/widgets/trip_plan/trip_budget_detail_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samera_app/features/trip_planner/presentation/bloc/trip_planner/trip_planner_bloc.dart';
import 'package:samera_app/features/trip_planner/presentation/bloc/trip_planner/trip_planner_state.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/utils/format_utils.dart';

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
      body: BlocConsumer<TripPlannerBloc, TripPlannerState>(
        listener: (context, state) {
          if (state.status == TripPlannerStatus.saved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Trip plan berhasil disimpan!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.status == TripPlannerStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Gagal menyimpan trip plan."),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.tripPlan == null) {
            return const Center(child: Text("Tidak ada rencana trip"));
          }
          final plan = state.tripPlan!;
          
          final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
          final dayItems = plan.items.where((item) => item.day == state.selectedDay).toList();

          return Stack(
            fit: StackFit.expand,
            children: [
              // Main Scrollable Content
              SingleChildScrollView(
            padding: EdgeInsets.only(
              top: height * 0.02,
              bottom: height * 0.35, // Padded to avoid covering items by Bottom Floating Panel
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day Tabs
                  TripDaySelector(
                    totalDays: plan.durationDays,
                    selectedDay: state.selectedDay,
                    onDaySelected: (day) {
                      context.read<TripPlannerBloc>().add(ChangeSelectedDayEvent(day));
                    },
                  ),
                  SizedBox(height: height * 0.04),

                  // Timeline List dinamis dari engine
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: Column(
                      children: dayItems.map((item) {
                         return TripTimelineItem(
                           time: item.startTime,
                           title: item.destination.name,
                           description: item.destination.shortDescription.isNotEmpty ? item.destination.shortDescription : item.destination.category,
                           duration: FormatUtils.formatDuration(item.visitDuration),
                           imageUrl: item.destination.image,
                           isLast: dayItems.last == item,
                           dotColor: dayItems.last == item ? Colors.teal : const Color(0xFFFE813C),
                           onTap: () {
                             context.push('/detail-destination', extra: item.destination);
                           },
                         );
                      }).toList(),
                    ),
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
                width * 0.08 + MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
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
                        value: '${plan.durationDays} Days',
                      ),
                      SizedBox(width: width * 0.05),
                      TripStatItem(
                        icon: Icons.location_on,
                        iconColor: Colors.green,
                        title: 'Total Destination',
                        value: '${plan.totalDestination}',
                      ),
                      SizedBox(width: width * 0.05),
                      TripStatItem(
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.orange,
                        title: 'Estimasi Budget',
                        value: formatCurrency.format(plan.estimatedBudget),
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
                            onPressed: state.status == TripPlannerStatus.saving ? null : () {
                              context.read<TripPlannerBloc>().add(SaveTripPlanEvent(plan));
                            },
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
                                if (state.status == TripPlannerStatus.saving) ...[
                                  SizedBox(width: width * 0.02),
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => TripBudgetDetailDialog(plan: plan),
                            );
                          },
                          child: Text(
                            'Detail',
                            style: tsBodyMediumSemiBold(Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
     },
    ),
   );
  }
}
