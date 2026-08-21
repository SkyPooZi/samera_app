import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_regions.dart';
import '../../../domain/usecases/get_destinations_by_region.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetRegions getRegions;
  final GetDestinationsByRegion getDestinationsByRegion;

  ExploreBloc({
    required this.getRegions,
    required this.getDestinationsByRegion,
  }) : super(ExploreInitial()) {
    on<LoadRegions>((event, emit) async {
      emit(ExploreLoading());
      try {
        final regions = await getRegions();
        const initialRegionId = 'yogyakarta';
        final recommendations = await getDestinationsByRegion(initialRegionId);
        
        emit(ExploreLoaded(
          regions: regions,
          selectedRegionId: initialRegionId,
          recommendations: recommendations,
        ));
      } catch (e) {
        emit(ExploreError(e.toString()));
      }
    });

    on<SelectRegion>((event, emit) async {
      if (state is ExploreLoaded) {
        final currentState = state as ExploreLoaded;
        try {
          final recommendations = await getDestinationsByRegion(event.regionId);
          emit(currentState.copyWith(
            selectedRegionId: event.regionId,
            recommendations: recommendations,
          ));
        } catch (e) {
          emit(ExploreError(e.toString()));
        }
      }
    });

    on<LoadDetailRecommendations>((event, emit) async {
      if (state is ExploreLoaded) {
        final currentState = state as ExploreLoaded;
        try {
          final detailRecommendations = await getDestinationsByRegion(
            event.regionQuery,
            onlyRecommended: false,
          );
          emit(currentState.copyWith(
            detailRecommendations: detailRecommendations,
          ));
        } catch (e) {
          // Tetap biarkan state berjalan jika gagal fetch detail recommendations
        }
      }
    });
  }
}
