import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samera_app/features/trip_planner/domain/usecases/get_saved_trip_plans.dart';

import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetSavedTripPlans getSavedTripPlans;

  AccountBloc({required this.getSavedTripPlans}) : super(AccountInitial()) {
    on<LoadSavedTripPlans>(_onLoadSavedTripPlans);
  }

  Future<void> _onLoadSavedTripPlans(
    LoadSavedTripPlans event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      print('[Account] Loading saved trip plans...');
      final tripPlans = await getSavedTripPlans();
      
      // Sort newest first. Assuming ID is timestamp based or just reverse the list if local storage appends.
      // Or we can just reverse the list.
      final sortedPlans = List.of(tripPlans.reversed);
      
      // Get username from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('registered_username');

      print('[Account] Saved trip plans count: ${sortedPlans.length}');
      if (sortedPlans.isNotEmpty) {
        print('[Account] Latest trip plan: ${sortedPlans.first.city}');
      }

      emit(AccountLoaded(
        savedTripPlans: sortedPlans,
        username: username,
      ));
    } catch (e) {
      print('[Account] Error loading trip plans: $e');
      emit(AccountError(e.toString()));
    }
  }
}
