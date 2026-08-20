import 'package:equatable/equatable.dart';
import '../../../domain/entities/region_entity.dart';
import '../../../../home/domain/entities/destination_entity.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<RegionEntity> regions;
  final String selectedRegionId;
  final List<DestinationEntity> recommendations;
  final List<DestinationEntity>? detailRecommendations;

  const ExploreLoaded({
    required this.regions,
    required this.selectedRegionId,
    required this.recommendations,
    this.detailRecommendations,
  });

  @override
  List<Object> get props => [
        regions,
        selectedRegionId,
        recommendations,
        detailRecommendations ?? const [],
      ];

  ExploreLoaded copyWith({
    List<RegionEntity>? regions,
    String? selectedRegionId,
    List<DestinationEntity>? recommendations,
    List<DestinationEntity>? detailRecommendations,
  }) {
    return ExploreLoaded(
      regions: regions ?? this.regions,
      selectedRegionId: selectedRegionId ?? this.selectedRegionId,
      recommendations: recommendations ?? this.recommendations,
      detailRecommendations: detailRecommendations ?? this.detailRecommendations,
    );
  }
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);

  @override
  List<Object> get props => [message];
}
