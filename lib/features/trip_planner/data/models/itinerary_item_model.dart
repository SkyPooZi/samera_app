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
      destination: json['destination'] != null
          ? DestinationModel.fromJson(json['destination'] as Map<String, dynamic>)
          : const DestinationModel(
              id: '', name: '', location: '', province: '', category: '', categoryId: '',
              image: '', regionId: '', city: '', rating: 0, reviewCount: 0,
              shortDescription: '', description: '', ticketPrice: 0, ticketPriceLabel: '',
              address: '', highlights: [], gallery: [], isFavorite: false,
              isRecommended: false, estimatedVisitDuration: 0, estimatedFoodCost: 0,
              recommendedTime: '', interests: [], openingTime: '', closingTime: '',
              latitude: 0, longitude: 0,
            ),
      day: json['day'] as int? ?? 1,
      startTime: json['startTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
      visitDuration: json['visitDuration'] as int? ?? 0,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble() ?? 0.0,
      order: json['order'] as int? ?? 0,
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
