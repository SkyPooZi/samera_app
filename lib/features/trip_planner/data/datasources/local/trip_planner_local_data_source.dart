import 'package:samera_app/features/home/data/models/destination_model.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
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
    final prefs = await SharedPreferences.getInstance();
    
    debugPrint('[TripPlanner] ===== SAVE START =====');
    debugPrint('[TripPlanner] New Trip ID: ${tripPlan.id}');
    
    final existingPlans = await getSavedTripPlans();
    
    debugPrint('[TripPlanner] EXISTING PLAN COUNT: ${existingPlans.length}');
    debugPrint('[TripPlanner] EXISTING PLAN IDS: ${existingPlans.map((p) => p.id).toList()}');
    
    // Hapus jika ID sudah ada (Replace/Update)
    existingPlans.removeWhere((plan) => plan.id == tripPlan.id);
    
    // Append
    debugPrint('[TripPlanner] APPENDING: ${tripPlan.id}');
    existingPlans.add(tripPlan);
    
    debugPrint('[TripPlanner] PLAN COUNT AFTER APPEND: ${existingPlans.length}');
    debugPrint('[TripPlanner] PLAN IDS AFTER APPEND: ${existingPlans.map((p) => p.id).toList()}');
    
    final List<Map<String, dynamic>> jsonList = existingPlans.map((plan) => plan.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    
    final success = await prefs.setString(_savedTripPlansKey, jsonString);
    
    debugPrint('[TripPlanner] SET STRING RESULT: $success');
    debugPrint('[TripPlanner] ===== SAVE END =====');
  }

  @override
  Future<List<TripPlanModel>> getSavedTripPlans() async {
    debugPrint('[TripPlanner] ===== LOAD SAVED PLANS =====');
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_savedTripPlansKey);
    
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonList;
      try {
        jsonList = jsonDecode(jsonString);
        debugPrint('[TripPlanner] Raw saved data contains ${jsonList.length} items');
      } catch (e, stackTrace) {
        debugPrint('[TripPlanner] STORAGE DECODE ERROR');
        debugPrint('[TripPlanner] Error: $e');
        debugPrint('[TripPlanner] StackTrace: $stackTrace');
        throw Exception('Failed to decode saved trip plans: $e');
      }
      
      final List<TripPlanModel> result = [];
      for (var i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        try {
          final plan = TripPlanModel.fromJson(json as Map<String, dynamic>);
          // Filter legacy corrupt ID caused by literal string bug
          if (plan.id == r"trip_${DateTime.now().millisecondsSinceEpoch}") {
            debugPrint('[TripPlanner] Found corrupted legacy ID, skipping...');
            continue;
          }
          result.add(plan);
        } catch (e, stackTrace) {
          debugPrint('[TripPlanner] STORAGE PARSE ERROR at index $i');
          debugPrint('[TripPlanner] Raw data: $json');
          debugPrint('[TripPlanner] Error: $e');
          debugPrint('[TripPlanner] StackTrace: $stackTrace');
          throw Exception('Failed to parse trip plan at index $i: $e');
        }
      }
      debugPrint('[TripPlanner] Parsed saved plans count: ${result.length}');
      return result;
    }
    
    debugPrint('[TripPlanner] No saved plans found (null or empty string).');
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
