import 'panorama_360_entity.dart';

class DestinationEntity {
  final String id;
  final String name;
  final String location;
  final String province;
  final String category;
  final String categoryId;
  final String image;
  final String regionId;
  final String city;
  final double rating;
  final int reviewCount;
  final String shortDescription;
  final String description;
  final int ticketPrice;
  final String ticketPriceLabel;
  final String address;
  final List<String> highlights;
  final List<String> gallery;
  final Panorama360Entity? panorama360;
  final bool isFavorite;
  final bool isRecommended;
  final int estimatedVisitDuration;
  final int estimatedFoodCost;
  final String recommendedTime;
  final List<String> interests;
  final String openingTime;
  final String closingTime;
  final double latitude;
  final double longitude;

  const DestinationEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.province,
    required this.category,
    required this.categoryId,
    required this.image,
    required this.regionId,
    required this.city,
    required this.rating,
    required this.reviewCount,
    required this.shortDescription,
    required this.description,
    required this.ticketPrice,
    required this.ticketPriceLabel,
    required this.address,
    required this.highlights,
    required this.gallery,
    this.panorama360,
    required this.isFavorite,
    required this.isRecommended,
    required this.estimatedVisitDuration,
    required this.estimatedFoodCost,
    required this.recommendedTime,
    required this.interests,
    required this.openingTime,
    required this.closingTime,
    required this.latitude,
    required this.longitude,
  });
}
