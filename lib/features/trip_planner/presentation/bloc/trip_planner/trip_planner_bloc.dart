import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'trip_planner_event.dart';
import 'trip_planner_state.dart';
import '../../../domain/usecases/generate_trip_plan.dart';
import '../../../domain/usecases/save_trip_plan.dart';
import '../../../domain/exceptions/trip_planner_exceptions.dart';

class TripPlannerBloc extends Bloc<TripPlannerEvent, TripPlannerState> {
  final GenerateTripPlan generateTripPlan;
  final SaveTripPlan saveTripPlanUseCase;

  TripPlannerBloc({
    required this.generateTripPlan,
    required this.saveTripPlanUseCase,
  }) : super(const TripPlannerState()) {
    on<UpdateTripPreference>((event, emit) {
      emit(state.copyWith(
        budget: event.budget,
        duration: event.duration,
        transportation: event.transportation,
        interest: event.interest,
        favoriteCity: event.favoriteCity,
        groupSize: event.groupSize,
        status: TripPlannerStatus.initial, // reset status ketika diedit
      ));
    });

    on<GenerateTripPlanEvent>((event, emit) async {
      emit(state.copyWith(status: TripPlannerStatus.loading));
      try {
        final plan = await generateTripPlan(event.preference);
        emit(state.copyWith(status: TripPlannerStatus.loaded, tripPlan: plan));
      } on InsufficientBudgetException catch (e) {
        final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
        final budgetStr = currencyFormat.format(e.budget);
        final costStr = currencyFormat.format(e.minimumEstimatedCost);
        final errorMsg = "Budget tidak mencukupi untuk transportasi yang dipilih.\n\nBudget Anda: $budgetStr\nEstimasi biaya transportasi: $costStr\n\nSolusi: Naikkan budget atau pilih transportasi yang lebih hemat.";
        emit(state.copyWith(status: TripPlannerStatus.error, errorMessage: errorMsg));
      } on NoItineraryFoundException {
        emit(state.copyWith(status: TripPlannerStatus.error, errorMessage: "Tidak ditemukan itinerary yang sesuai dengan preferensi Anda."));
      } catch (e) {
        String msg = e.toString();
        // Fallback membersihkan prefix Exception: jika masih ada
        if (msg.startsWith('Exception: ')) {
          msg = msg.replaceFirst('Exception: ', '');
        }
        emit(state.copyWith(status: TripPlannerStatus.error, errorMessage: msg));
      }
    });

    on<SaveTripPlanEvent>((event, emit) async {
      emit(state.copyWith(status: TripPlannerStatus.saving));
      try {
        await saveTripPlanUseCase(event.tripPlan);
        // Pertahankan objek tripPlan saat ini di state, agar layar tidak blank
        emit(state.copyWith(status: TripPlannerStatus.saved));
      } catch (e) {
        emit(state.copyWith(status: TripPlannerStatus.error, errorMessage: e.toString()));
      }
    });

    on<ChangeSelectedDayEvent>((event, emit) {
      emit(state.copyWith(selectedDay: event.day));
    });
  }
}
