import '../../domain/entities/trip_plan_entity.dart';
import 'itinerary_item_model.dart';

class TripPlanModel extends TripPlanEntity {
  const TripPlanModel({
    required super.id,
    required super.city,
    required super.numberOfPeople,
    required super.budget,
    required super.transportation,
    required super.interests,
    required super.durationDays,
    required super.items,
    required super.totalDestination,
    required super.estimatedBudget,
    required super.transportCost,
    required super.destinationCost,
    required super.remainingBudget,
  });

  factory TripPlanModel.fromJson(Map<String, dynamic> json) {
    return TripPlanModel(
      id: json['id']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      numberOfPeople: json['numberOfPeople'] as int? ?? 1,
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
      transportation: json['transportation']?.toString() ?? '',
      interests: (json['interests'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      durationDays: json['durationDays'] as int? ?? 1,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => ItineraryItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalDestination: json['totalDestination'] as int? ?? 0,
      estimatedBudget: (json['estimatedBudget'] as num?)?.toDouble() ?? 0.0,
      transportCost: (json['transportCost'] as num?)?.toDouble() ?? 0.0,
      destinationCost: (json['destinationCost'] as num?)?.toDouble() ?? 0.0,
      remainingBudget: (json['remainingBudget'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'numberOfPeople': numberOfPeople,
      'budget': budget,
      'transportation': transportation,
      'interests': interests,
      'durationDays': durationDays,
      'items': items.map((item) {
        if (item is ItineraryItemModel) {
          return item.toJson();
        }
        return ItineraryItemModel(
          destination: item.destination,
          day: item.day,
          startTime: item.startTime,
          endTime: item.endTime,
          visitDuration: item.visitDuration,
          estimatedCost: item.estimatedCost,
          order: item.order,
        ).toJson();
      }).toList(),
      'totalDestination': totalDestination,
      'estimatedBudget': estimatedBudget,
      'transportCost': transportCost,
      'destinationCost': destinationCost,
      'remainingBudget': remainingBudget,
    };
  }
}
