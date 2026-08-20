import '../../../home/domain/entities/destination_entity.dart';
import '../repositories/explore_repository.dart';

class GetDestinationsByRegion {
  final ExploreRepository exploreRepository;

  GetDestinationsByRegion(this.exploreRepository);

  Future<List<DestinationEntity>> call(String regionId, {bool onlyRecommended = true}) async {
    final allDestinations = await exploreRepository.getDestinations();
    
    final regId = regionId.toLowerCase();
    
    // Filter destinasi berdasarkan province, location, atau id karena JSON belum memiliki regionId
    var filtered = allDestinations.where((destination) {
      final loc = destination.location.toLowerCase();
      final prov = destination.province.toLowerCase();
      final id = destination.id.toLowerCase();

      return prov.contains(regId) || 
             loc.contains(regId) || 
             id.contains(regId) || 
             (regId == 'yogyakarta' && id.contains('jogja'));
    }).toList();

    if (onlyRecommended) {
      filtered = filtered.where((destination) => destination.isRecommended).toList();
    }

    return filtered;
  }
}
