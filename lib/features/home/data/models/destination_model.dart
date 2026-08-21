import '../../domain/entities/destination_entity.dart';
import 'panorama_360_model.dart';

class DestinationModel extends DestinationEntity {
  const DestinationModel({
    required super.id,
    required super.name,
    required super.location,
    required super.province,
    required super.category,
    required super.categoryId,
    required super.image,
    required super.regionId,
    required super.city,
    required super.rating,
    required super.reviewCount,
    required super.shortDescription,
    required super.description,
    required super.ticketPrice,
    required super.ticketPriceLabel,
    required super.address,
    required super.highlights,
    required super.gallery,
    super.panorama360,
    required super.isFavorite,
    required super.isRecommended,
    required super.estimatedVisitDuration,
    required super.estimatedFoodCost,
    required super.recommendedTime,
    required super.interests,
    required super.openingTime,
    required super.closingTime,
    required super.latitude,
    required super.longitude,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      province: json['province'] ?? '',
      category: json['category'] ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      image: json['image'] ?? '',
      regionId: json['regionId']?.toString() ?? '',
      city: json['city'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      shortDescription: json['shortDescription'] ?? '',
      description: json['description'] ?? '',
      ticketPrice: json['ticketPrice'] ?? 0,
      ticketPriceLabel: json['ticketPriceLabel'] ?? '',
      address: json['address'] ?? '',
      highlights: (json['highlights'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      gallery: (json['gallery'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      panorama360: json['panorama360'] != null
          ? Panorama360Model.fromJson(json['panorama360'] as Map<String, dynamic>)
          : null,
      isFavorite: json['isFavorite'] ?? false,
      isRecommended: json['isRecommended'] ?? false,
      estimatedVisitDuration: json['estimatedVisitDuration'] ?? 60,
      estimatedFoodCost: json['estimatedFoodCost'] ?? 0,
      recommendedTime: json['recommendedTime'] ?? 'morning',
      interests: (json['interests'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      openingTime: json['openingTime'] ?? '08:00',
      closingTime: json['closingTime'] ?? '17:00',
      latitude: (json['latitude'] ?? -7.8000).toDouble(),
      longitude: (json['longitude'] ?? 110.3600).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'province': province,
      'category': category,
      'categoryId': categoryId,
      'image': image,
      'regionId': regionId,
      'city': city,
      'rating': rating,
      'reviewCount': reviewCount,
      'shortDescription': shortDescription,
      'description': description,
      'ticketPrice': ticketPrice,
      'ticketPriceLabel': ticketPriceLabel,
      'address': address,
      'highlights': highlights,
      'gallery': gallery,
      'panorama360': panorama360 != null
          ? (panorama360 as Panorama360Model).toJson()
          : null,
      'isFavorite': isFavorite,
      'isRecommended': isRecommended,
      'estimatedVisitDuration': estimatedVisitDuration,
      'estimatedFoodCost': estimatedFoodCost,
      'recommendedTime': recommendedTime,
      'interests': interests,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
