import '../entities/trip_plan_entity.dart';
import '../repositories/trip_planner_repository.dart';

class SaveTripPlan {
  final TripPlannerRepository repository;

  SaveTripPlan(this.repository);

  Future<void> call(TripPlanEntity tripPlan) async {
    return await repository.saveTripPlan(tripPlan);
  }
}
