import 'package:samera_app/features/home/domain/entities/destination_entity.dart';

class ItineraryItemEntity {
  final DestinationEntity destination;
  final int day;
  final String startTime;
  final String endTime;
  final int visitDuration;
  final double estimatedCost;
  final int order;

  const ItineraryItemEntity({
    required this.destination,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.visitDuration,
    required this.estimatedCost,
    required this.order,
  });
}
