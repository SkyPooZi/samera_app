import '../entities/trip_plan_entity.dart';
import '../repositories/trip_planner_repository.dart';

class GetSavedTripPlans {
  final TripPlannerRepository repository;

  GetSavedTripPlans(this.repository);

  Future<List<TripPlanEntity>> call() async {
    return await repository.getSavedTripPlans();
  }
}
