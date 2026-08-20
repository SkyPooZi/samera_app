import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_recommendations.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecommendations getRecommendations;

  HomeBloc({required this.getRecommendations}) : super(HomeInitial()) {
    on<LoadRecommendations>((event, emit) async {
      emit(HomeLoading());
      try {
        final recommendations = await getRecommendations();
        emit(HomeLoaded(recommendations));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
