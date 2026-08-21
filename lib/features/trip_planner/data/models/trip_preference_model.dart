import '../../domain/entities/trip_preference_entity.dart';

class TripPreferenceModel extends TripPreferenceEntity {
  const TripPreferenceModel({
    required super.budget,
    required super.durationDays,
    required super.transportation,
    required super.interests,
    super.favoriteCity,
    required super.numberOfPeople,
  });
}
