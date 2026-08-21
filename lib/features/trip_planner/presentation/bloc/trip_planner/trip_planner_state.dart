import '../../../domain/entities/trip_plan_entity.dart';

enum TripPlannerStatus { initial, loading, loaded, saving, saved, error, deleting, deleted }

class TripPlannerState {
  final String budget;
  final String duration;
  final String transportation;
  final String interest;
  final String favoriteCity;
  final String groupSize;
  
  final TripPlannerStatus status;
  final TripPlanEntity? tripPlan;
  final String? errorMessage;
  final int selectedDay;

  const TripPlannerState({
    this.budget = '',
    this.duration = '',
    this.transportation = '',
    this.interest = '',
    this.favoriteCity = '',
    this.groupSize = '',
    this.status = TripPlannerStatus.initial,
    this.tripPlan,
    this.errorMessage,
    this.selectedDay = 1,
  });

  TripPlannerState copyWith({
    String? budget,
    String? duration,
    String? transportation,
    String? interest,
    String? favoriteCity,
    String? groupSize,
    TripPlannerStatus? status,
    TripPlanEntity? tripPlan,
    String? errorMessage,
    int? selectedDay,
  }) {
    return TripPlannerState(
      budget: budget ?? this.budget,
      duration: duration ?? this.duration,
      transportation: transportation ?? this.transportation,
      interest: interest ?? this.interest,
      favoriteCity: favoriteCity ?? this.favoriteCity,
      groupSize: groupSize ?? this.groupSize,
      status: status ?? this.status,
      tripPlan: tripPlan ?? this.tripPlan,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
