import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  static const String _favoriteKey = 'favorite_destinations';

  FavoriteCubit() : super(const FavoriteState()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoriteKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        final ids = decoded.map((e) => e.toString()).toList();
        emit(state.copyWith(favoriteIds: ids));
      } catch (e) {
        emit(state.copyWith(favoriteIds: []));
      }
    } else {
      emit(state.copyWith(favoriteIds: []));
    }
  }

  Future<void> toggleFavorite(String destinationId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentIds = List<String>.from(state.favoriteIds);
    
    if (currentIds.contains(destinationId)) {
      currentIds.remove(destinationId);
    } else {
      currentIds.add(destinationId);
    }

    emit(state.copyWith(favoriteIds: currentIds));
    await prefs.setString(_favoriteKey, jsonEncode(currentIds));
  }
}
