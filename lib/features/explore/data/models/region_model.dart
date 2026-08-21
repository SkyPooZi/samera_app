import '../../domain/entities/region_entity.dart';

class RegionStatsModel extends RegionStatsEntity {
  const RegionStatsModel({
    required super.destinations,
    required super.heritage,
    required super.cuisine,
    required super.experiences,
  });

  factory RegionStatsModel.fromJson(Map<String, dynamic> json) {
    return RegionStatsModel(
      destinations: json['destinations'] ?? 0,
      heritage: json['heritage'] ?? 0,
      cuisine: json['cuisine'] ?? 0,
      experiences: json['experiences'] ?? 0,
    );
  }
}

class RegionModel extends RegionEntity {
  const RegionModel({
    required super.id,
    required super.name,
    required super.province,
    required super.provinceId,
    required super.image,
    required super.tagline,
    required super.description,
    required super.stats,
    required super.sortOrder,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      province: json['province'] ?? '',
      provinceId: json['provinceId'] ?? '',
      image: json['image'] ?? '',
      tagline: json['tagline'] ?? '',
      description: json['description'] ?? '',
      stats: RegionStatsModel.fromJson(json['stats'] ?? {}),
      sortOrder: json['sortOrder'] ?? 0,
    );
  }
}
