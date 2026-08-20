import '../../../../home/domain/entities/destination_entity.dart';

abstract class CategoryDestinationState {}

class CategoryDestinationInitial extends CategoryDestinationState {}

class CategoryDestinationLoading extends CategoryDestinationState {}

class CategoryDestinationLoaded extends CategoryDestinationState {
  final List<DestinationEntity> destinations;

  CategoryDestinationLoaded(this.destinations);
}

class CategoryDestinationError extends CategoryDestinationState {
  final String message;

  CategoryDestinationError(this.message);
}
