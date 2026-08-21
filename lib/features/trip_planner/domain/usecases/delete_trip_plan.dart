import '../repositories/trip_planner_repository.dart';

class DeleteTripPlan {
  final TripPlannerRepository repository;

  DeleteTripPlan(this.repository);

  Future<void> call(String tripPlanId) async {
    return await repository.deleteTripPlan(tripPlanId);
  }
}
