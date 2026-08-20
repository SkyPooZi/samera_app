abstract class CategoryDestinationEvent {}

class LoadDestinationsByCategory extends CategoryDestinationEvent {
  final String categoryId;

  LoadDestinationsByCategory(this.categoryId);
}
