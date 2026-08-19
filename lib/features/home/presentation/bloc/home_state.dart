import 'package:equatable/equatable.dart';
import '../../domain/entities/destination_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DestinationEntity> recommendations;

  const HomeLoaded(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
