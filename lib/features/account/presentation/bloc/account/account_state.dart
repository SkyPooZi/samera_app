import 'package:equatable/equatable.dart';
import 'package:samera_app/features/trip_planner/domain/entities/trip_plan_entity.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final List<TripPlanEntity> savedTripPlans;
  final String? username;

  const AccountLoaded({
    required this.savedTripPlans,
    this.username,
  });

  @override
  List<Object?> get props => [savedTripPlans, username];
}

class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object?> get props => [message];
}
