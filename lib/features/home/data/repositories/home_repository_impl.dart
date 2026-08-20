import '../../domain/entities/destination_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/local/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<DestinationEntity>> getRecommendations() async {
    try {
      final localData = await localDataSource.getRecommendations();
      return localData;
    } catch (e) {
      throw Exception('Failed to load recommendations');
    }
  }
}
