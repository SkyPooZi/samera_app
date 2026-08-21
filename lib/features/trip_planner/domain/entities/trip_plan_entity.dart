import 'itinerary_item_entity.dart';

class TripPlanEntity {
  final String id;
  final String city;
  final int numberOfPeople;
  final double budget;
  final String transportation;
  final List<String> interests;
  final int durationDays;
  final List<ItineraryItemEntity> items;
  final int totalDestination;
  final double estimatedBudget;
  final double transportCost;
  final double destinationCost;
  final double remainingBudget;

  const TripPlanEntity({
    required this.id,
    required this.city,
    required this.numberOfPeople,
    required this.budget,
    required this.transportation,
    required this.interests,
    required this.durationDays,
    required this.items,
    required this.totalDestination,
    required this.estimatedBudget,
    required this.transportCost,
    required this.destinationCost,
    required this.remainingBudget,
  });
}
