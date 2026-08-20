import '../entities/region_entity.dart';
import '../../../home/domain/entities/destination_entity.dart';

abstract class ExploreRepository {
  Future<List<RegionEntity>> getRegions();
  Future<List<DestinationEntity>> getDestinations();
  Future<List<DestinationEntity>> getDestinationsByCategory(String categoryId);
}
