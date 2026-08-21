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
      id: json['id'] as String,
      city: json['city'] as String,
      numberOfPeople: json['numberOfPeople'] as int,
      budget: (json['budget'] as num).toDouble(),
      transportation: json['transportation'] as String,
      interests: List<String>.from(json['interests'] ?? []),
      durationDays: json['durationDays'] as int,
      items: (json['items'] as List)
          .map((item) => ItineraryItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalDestination: json['totalDestination'] as int,
      estimatedBudget: (json['estimatedBudget'] as num).toDouble(),
      transportCost: (json['transportCost'] as num?)?.toDouble() ?? 0.0,
      destinationCost: (json['destinationCost'] as num?)?.toDouble() ?? 0.0,
      remainingBudget: (json['remainingBudget'] as num).toDouble(),
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
