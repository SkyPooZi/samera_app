import 'package:samera_app/features/home/data/models/destination_model.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';
import 'package:flutter/services.dart';
import 'package:samera_app/features/trip_planner/data/models/trip_plan_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class TripPlannerLocalDataSource {
  Future<List<DestinationEntity>> getAllDestinations();
  Future<void> saveTripPlan(TripPlanModel tripPlan);
  Future<List<TripPlanModel>> getSavedTripPlans();
  Future<void> deleteTripPlan(String tripPlanId);
}

class TripPlannerLocalDataSourceImpl implements TripPlannerLocalDataSource {
  static const String _savedTripPlansKey = 'saved_trip_plans';

  @override
  Future<List<DestinationEntity>> getAllDestinations() async {
    final List<DestinationEntity> allDestinations = [];
    
    final regions = ['jawa_tengah', 'yogyakarta'];
    final files = ['destination.json', 'heritage.json', 'cuisine.json', 'culture.json', 'local_experience.json'];

    for (var region in regions) {
      for (var file in files) {
        final assetPath = 'assets/data/$region/$file';
        try {
          final String response = await rootBundle.loadString(assetPath);
          final dynamic decoded = jsonDecode(response);
          
          List<dynamic> data;
          if (decoded is List) {
            data = decoded;
          } else if (decoded is Map && decoded.containsKey('data')) {
            data = decoded['data'];
          } else {
            data = [];
          }

          int parsedCount = 0;
          for (var item in data) {
            try {
              final destination = DestinationModel.fromJson(item);
              allDestinations.add(destination);
              parsedCount++;
              // Terlalu berisik jika di-print per item sesuai ukuran array, jadi dinonaktifkan
            } catch (e) {
            }
          }
          
        } catch (e) {
        }
      }
    }
    
    // Remove duplicates based on ID
    final uniqueDestinations = <String, DestinationEntity>{};
    for (var dest in allDestinations) {
      uniqueDestinations[dest.id] = dest;
    }
    
    
    if (uniqueDestinations.isEmpty) {
      throw Exception('Trip Planner failed to load destination data.');
    }

    return uniqueDestinations.values.toList();
  }

  @override
  Future<void> saveTripPlan(TripPlanModel tripPlan) async {
    
    final savedPlans = await getSavedTripPlans();
    
    // Hapus jika ID sudah ada (Replace/Update)
    savedPlans.removeWhere((plan) => plan.id == tripPlan.id);
    savedPlans.add(tripPlan);
    
    final List<Map<String, dynamic>> jsonList = savedPlans.map((plan) => plan.toJson()).toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedTripPlansKey, jsonEncode(jsonList));
    
  }

  @override
  Future<List<TripPlanModel>> getSavedTripPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_savedTripPlansKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final result = jsonList.map((json) => TripPlanModel.fromJson(json as Map<String, dynamic>)).toList();
        return result;
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> deleteTripPlan(String tripPlanId) async {
    final savedPlans = await getSavedTripPlans();
    savedPlans.removeWhere((plan) => plan.id == tripPlanId);
    
    final List<Map<String, dynamic>> jsonList = savedPlans.map((plan) => plan.toJson()).toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedTripPlansKey, jsonEncode(jsonList));
    
  }
}
