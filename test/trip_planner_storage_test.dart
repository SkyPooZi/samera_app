import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samera_app/features/trip_planner/data/datasources/local/trip_planner_local_data_source.dart';
import 'package:samera_app/features/trip_planner/data/models/trip_plan_model.dart';
import 'package:samera_app/features/trip_planner/data/models/itinerary_item_model.dart';
import 'package:samera_app/features/home/data/models/destination_model.dart';

void main() {
  test('Trip Planner Appends Correctly', () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    
    final ds = TripPlannerLocalDataSourceImpl();
    
    TripPlanModel createPlan(String id) {
      return TripPlanModel(
        id: id, city: 'City', numberOfPeople: 1, budget: 100, transportation: 'motor',
        interests: [], durationDays: 1, items: [],
        totalDestination: 0, estimatedBudget: 100, transportCost: 10, destinationCost: 10,
        remainingBudget: 80
      );
    }
    
    final planA = createPlan('trip_A');
    final planB = createPlan('trip_B');
    final planC = createPlan('trip_C');

    await ds.saveTripPlan(planA);
    var saved = await ds.getSavedTripPlans();
    expect(saved.length, 1);

    await ds.saveTripPlan(planB);
    saved = await ds.getSavedTripPlans();
    expect(saved.length, 2);

    await ds.saveTripPlan(planC);
    saved = await ds.getSavedTripPlans();
    expect(saved.length, 3);
    
    print('Final Saved IDs: \${saved.map((e)=>e.id).toList()}');
  });
}
