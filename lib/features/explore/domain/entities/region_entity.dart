import 'package:equatable/equatable.dart';

class RegionStatsEntity extends Equatable {
  final int destinations;
  final int heritage;
  final int cuisine;
  final int experiences;

  const RegionStatsEntity({
    required this.destinations,
    required this.heritage,
    required this.cuisine,
    required this.experiences,
  });

  @override
  List<Object?> get props => [destinations, heritage, cuisine, experiences];
}

class RegionEntity extends Equatable {
  final String id;
  final String name;
  final String province;
  final String provinceId;
  final String image;
  final String tagline;
  final String description;
  final RegionStatsEntity stats;
  final int sortOrder;

  const RegionEntity({
    required this.id,
    required this.name,
    required this.province,
    required this.provinceId,
    required this.image,
    required this.tagline,
    required this.description,
    required this.stats,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        province,
        provinceId,
        image,
        tagline,
        description,
        stats,
        sortOrder,
      ];
}
