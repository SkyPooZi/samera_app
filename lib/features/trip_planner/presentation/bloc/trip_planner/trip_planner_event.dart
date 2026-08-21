import 'package:samera_app/features/trip_planner/domain/entities/trip_plan_entity.dart';

import '../../../domain/entities/trip_preference_entity.dart';

abstract class TripPlannerEvent {}

class UpdateTripPreference extends TripPlannerEvent {
  final String? budget;
  final String? duration;
  final String? transportation;
  final String? interest;
  final String? favoriteCity;
  final String? groupSize;

  UpdateTripPreference({
    this.budget,
    this.duration,
    this.transportation,
    this.interest,
    this.favoriteCity,
    this.groupSize,
  });
}

class GenerateTripPlanEvent extends TripPlannerEvent {
  final TripPreferenceEntity preference;

  GenerateTripPlanEvent(this.preference);
}

class SaveTripPlanEvent extends TripPlannerEvent {
  final TripPlanEntity tripPlan;

  SaveTripPlanEvent(this.tripPlan);
}

class ChangeSelectedDayEvent extends TripPlannerEvent {
  final int day;

  ChangeSelectedDayEvent(this.day);
}

class DeleteTripPlanEvent extends TripPlannerEvent {
  final String tripPlanId;

  DeleteTripPlanEvent(this.tripPlanId);
}
