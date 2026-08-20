import '../../domain/entities/region_entity.dart';
import '../../../home/domain/entities/destination_entity.dart';
import '../../domain/repositories/explore_repository.dart';
import '../datasources/local/explore_local_data_source.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreLocalDataSource localDataSource;

  ExploreRepositoryImpl({required this.localDataSource});

  @override
  Future<List<RegionEntity>> getRegions() async {
    return await localDataSource.getRegions();
  }

  @override
  Future<List<DestinationEntity>> getDestinations() async {
    return await localDataSource.getDestinations();
  }

  @override
  Future<List<DestinationEntity>> getDestinationsByCategory(String categoryId) async {
    return await localDataSource.getDestinationsByCategory(categoryId);
  }
}
