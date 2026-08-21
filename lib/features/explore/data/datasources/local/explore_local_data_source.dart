import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:samera_app/features/home/data/models/destination_model.dart';
import '../../models/region_model.dart';

abstract class ExploreLocalDataSource {
  Future<List<RegionModel>> getRegions();
  Future<List<DestinationModel>> getDestinations();
  Future<List<DestinationModel>> getDestinationsByCategory(String categoryId);
}

class ExploreLocalDataSourceImpl implements ExploreLocalDataSource {
  @override
  Future<List<RegionModel>> getRegions() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/regions.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((item) => RegionModel.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to load regions: $e');
    }
  }

  @override
  Future<List<DestinationModel>> getDestinations() async {
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

    return allDestinations;
  }

  @override
  Future<List<DestinationModel>> getDestinationsByCategory(String categoryId) async {
    // Mapping default filename
    final categoryFiles = {
      'destination': 'destination.json',
      'heritage': 'heritage.json',
      'cuisine': 'cuisine.json',
      'culture': 'culture.json',
      'local_experience': 'local_experience.json',
    };

    final fileName = categoryFiles[categoryId];
    if (fileName == null) {
      throw Exception('Unsupported category: $categoryId');
    }

    final List<String> paths = [
      'assets/data/jawa_tengah/$fileName',
      'assets/data/yogyakarta/$fileName',
    ];

    List<DestinationModel> allDestinations = [];

    for (String path in paths) {
      try {
        final String jsonString = await rootBundle.loadString(path);
        final dynamic jsonData = json.decode(jsonString);
        
        List<dynamic> rawItems = [];

        if (jsonData is List) {
          rawItems = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          rawItems = jsonData['data'] as List<dynamic>;
        }

        for (final item in rawItems) {
          final destination = DestinationModel.fromJson(item as Map<String, dynamic>);
          allDestinations.add(destination);
        }
      } catch (e) {
        continue;
      }
    }

    return allDestinations;
  }
}
