import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class LoadRegions extends ExploreEvent {}

class SelectRegion extends ExploreEvent {
  final String regionId;

  const SelectRegion(this.regionId);

  @override
  List<Object> get props => [regionId];
}

class LoadDetailRecommendations extends ExploreEvent {
  final String regionQuery;

  const LoadDetailRecommendations(this.regionQuery);

  @override
  List<Object> get props => [regionQuery];
}
