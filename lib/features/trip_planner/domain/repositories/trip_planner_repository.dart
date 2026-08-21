import 'package:samera_app/features/trip_planner/domain/entities/trip_plan_entity.dart';
import 'package:samera_app/features/trip_planner/domain/entities/trip_preference_entity.dart';

abstract class TripPlannerRepository {
  Future<TripPlanEntity> generateTripPlan(TripPreferenceEntity preference);
  Future<void> saveTripPlan(TripPlanEntity tripPlan);
  Future<List<TripPlanEntity>> getSavedTripPlans();
  Future<void> deleteTripPlan(String tripPlanId);
}
