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
    );
  }
}
