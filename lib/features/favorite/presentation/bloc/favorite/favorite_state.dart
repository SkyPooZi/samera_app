import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final List<String> favoriteIds;

  const FavoriteState({
    this.favoriteIds = const [],
  });

  FavoriteState copyWith({
    List<String>? favoriteIds,
  }) {
    return FavoriteState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [favoriteIds];
}
