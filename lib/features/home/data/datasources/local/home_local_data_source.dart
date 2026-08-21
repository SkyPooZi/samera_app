import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/destination_model.dart';

abstract class HomeLocalDataSource {
  Future<List<DestinationModel>> getRecommendations();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<DestinationModel>> getRecommendations() async {
    final List<String> paths = [
      'assets/data/jawa_tengah/destination.json',
      'assets/data/jawa_tengah/heritage.json',
      'assets/data/jawa_tengah/cuisine.json',
      'assets/data/jawa_tengah/culture.json',
      'assets/data/jawa_tengah/local_experience.json',
      'assets/data/yogyakarta/destination.json',
      'assets/data/yogyakarta/heritage.json',
      'assets/data/yogyakarta/cuisine.json',
      'assets/data/yogyakarta/culture.json',
      'assets/data/yogyakarta/local_experience.json',
    ];

    List<DestinationModel> allDestinations = [];

    for (String path in paths) {
      try {
        final String jsonString = await rootBundle.loadString(path);
        final dynamic jsonData = json.decode(jsonString);
        
        List<DestinationModel> currentFileItems = [];
        List<dynamic> rawItems = [];

        if (jsonData is List) {
          rawItems = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          rawItems = jsonData['data'] as List<dynamic>;
        }

        for (final item in rawItems) {
          final destination = DestinationModel.fromJson(item as Map<String, dynamic>);
          

          currentFileItems.add(destination);
        }

        allDestinations.addAll(currentFileItems);

      } catch (e) {
        continue;
      }
    }
    final recommendations = allDestinations.where((item) => item.panorama360 != null && item.panorama360!.enabled).toList();
    
    return recommendations;
  }
}
