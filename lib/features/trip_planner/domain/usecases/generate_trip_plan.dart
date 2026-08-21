import '../entities/trip_plan_entity.dart';
import '../entities/trip_preference_entity.dart';
import '../repositories/trip_planner_repository.dart';

class GenerateTripPlan {
  final TripPlannerRepository repository;

  GenerateTripPlan(this.repository);

  Future<TripPlanEntity> call(TripPreferenceEntity preference) {
    return repository.generateTripPlan(preference);
  }
}
