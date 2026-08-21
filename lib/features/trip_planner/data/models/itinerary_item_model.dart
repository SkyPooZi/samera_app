import 'package:samera_app/features/home/data/models/destination_model.dart';
import '../../domain/entities/itinerary_item_entity.dart';

class ItineraryItemModel extends ItineraryItemEntity {
  const ItineraryItemModel({
    required super.destination,
    required super.day,
    required super.startTime,
    required super.endTime,
    required super.visitDuration,
    required super.estimatedCost,
    required super.order,
  });

  factory ItineraryItemModel.fromJson(Map<String, dynamic> json) {
    return ItineraryItemModel(
      destination: DestinationModel.fromJson(json['destination'] as Map<String, dynamic>),
      day: json['day'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      visitDuration: json['visitDuration'] as int,
      estimatedCost: (json['estimatedCost'] as num).toDouble(),
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': (destination as DestinationModel).toJson(),
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'visitDuration': visitDuration,
      'estimatedCost': estimatedCost,
      'order': order,
    };
  }
}
