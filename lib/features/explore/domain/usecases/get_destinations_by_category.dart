import '../../../home/domain/entities/destination_entity.dart';
import '../repositories/explore_repository.dart';

class GetDestinationsByCategory {
  final ExploreRepository exploreRepository;

  GetDestinationsByCategory(this.exploreRepository);

  Future<List<DestinationEntity>> call(String categoryId) async {
    return await exploreRepository.getDestinationsByCategory(categoryId);
  }
}
