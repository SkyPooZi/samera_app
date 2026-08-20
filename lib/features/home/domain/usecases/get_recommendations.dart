import '../entities/destination_entity.dart';
import '../repositories/home_repository.dart';

class GetRecommendations {
  final HomeRepository repository;

  GetRecommendations(this.repository);

  Future<List<DestinationEntity>> call() async {
    return await repository.getRecommendations();
  }
}
