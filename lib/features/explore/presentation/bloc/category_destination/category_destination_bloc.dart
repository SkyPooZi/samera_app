import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_destinations_by_category.dart';
import 'category_destination_event.dart';
import 'category_destination_state.dart';

class CategoryDestinationBloc extends Bloc<CategoryDestinationEvent, CategoryDestinationState> {
  final GetDestinationsByCategory getDestinationsByCategory;

  CategoryDestinationBloc({required this.getDestinationsByCategory}) : super(CategoryDestinationInitial()) {
    on<LoadDestinationsByCategory>((event, emit) async {
      emit(CategoryDestinationLoading());
      try {
        final destinations = await getDestinationsByCategory(event.categoryId);
        emit(CategoryDestinationLoaded(destinations));
      } catch (e) {
        emit(CategoryDestinationError(e.toString()));
      }
    });
  }
}
