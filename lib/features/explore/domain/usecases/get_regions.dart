import '../entities/region_entity.dart';
import '../repositories/explore_repository.dart';

class GetRegions {
  final ExploreRepository repository;

  GetRegions(this.repository);

  Future<List<RegionEntity>> call() async {
    return await repository.getRegions();
  }
}
