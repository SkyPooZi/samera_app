import '../../domain/entities/trip_plan_entity.dart';
import '../../domain/entities/trip_preference_entity.dart';
import '../../domain/entities/itinerary_item_entity.dart';
import '../../domain/repositories/trip_planner_repository.dart';
import '../datasources/local/trip_planner_local_data_source.dart';
import '../models/trip_plan_model.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';
import '../../domain/exceptions/trip_planner_exceptions.dart';

class TripPlannerRepositoryImpl implements TripPlannerRepository {
  final TripPlannerLocalDataSource localDataSource;

  TripPlannerRepositoryImpl({required this.localDataSource});

  @override
  Future<TripPlanEntity> generateTripPlan(TripPreferenceEntity preference) async {

    final allDestinations = await localDataSource.getAllDestinations();
    
    if (allDestinations.isEmpty) {
    }

    
    List<DestinationEntity> cityCandidates = [];
    if (preference.favoriteCity != null && preference.favoriteCity!.isNotEmpty) {
      String fav = preference.favoriteCity!.toLowerCase();
      for (var destination in allDestinations) {
        if (destination.city.toLowerCase() == fav ||
            destination.location.toLowerCase().contains(fav) ||
            fav.contains(destination.city.toLowerCase())) {
          cityCandidates.add(destination);
        } else {
        }
      }
      if (cityCandidates.isEmpty) {
         cityCandidates = allDestinations;
      }
    } else {
      cityCandidates = allDestinations;
    }

    
    List<DestinationEntity> interestCandidates = [];
    if (preference.interests.isNotEmpty) {
      for (var destination in cityCandidates) {
        bool matched = false;
        for (var interest in preference.interests) {
          if (destination.interests.map((e)=>e.toLowerCase()).contains(interest.toLowerCase()) ||
              destination.categoryId.toLowerCase() == interest.toLowerCase()) {
            matched = true;
            break;
          }
        }
        if (matched) {
          interestCandidates.add(destination);
        } else {
        }
      }
      if (interestCandidates.isEmpty) {
         interestCandidates = cityCandidates;
      }
    } else {
      interestCandidates = cityCandidates;
    }

    // 1. Scoring Destinations
    final scoredDestinations = interestCandidates.map((dest) {
      return _ScoredDestination(
        destination: dest,
        score: _calculateDestinationScore(dest, preference),
      );
    }).toList();

    // 2. Sorting by Highest Score
    scoredDestinations.sort((a, b) => b.score.compareTo(a.score));

    // 3. Scheduling
    
    List<ItineraryItemEntity> itinerary = [];
    double totalDestinationCost = 0;
    
    // 4. Base Transportation Cost
    double dailyTransportCost = 50000;
    if (preference.transportation.toLowerCase() == 'motor') {
      dailyTransportCost = 30000;
    } else if (preference.transportation.toLowerCase() == 'mobil') dailyTransportCost = 150000;
    else if (preference.transportation.toLowerCase() == 'kereta') dailyTransportCost = 250000;
    else if (preference.transportation.toLowerCase() == 'pesawat') dailyTransportCost = 800000;
    else if (preference.transportation.toLowerCase() == 'kapal') dailyTransportCost = 300000;
    
    double transportCost = dailyTransportCost * preference.durationDays;
    double currentCost = transportCost;

    if (preference.budget > 0 && currentCost > preference.budget) {
       throw InsufficientBudgetException(
         budget: preference.budget,
         minimumEstimatedCost: currentCost,
         transportation: preference.transportation,
       );
    }

    Set<String> visitedIds = {};

    for (int day = 1; day <= preference.durationDays; day++) {
      int currentMinutes = 8 * 60; // Mulai jam 08:00
      int endOfDayMinutes = 18 * 60; // Akhir jam 18:00
      List<ItineraryItemEntity> dayItems = [];

      for (var scored in scoredDestinations) {
        final dest = scored.destination;
        if (visitedIds.contains(dest.id)) continue;

        int visitDuration = dest.estimatedVisitDuration > 0 ? dest.estimatedVisitDuration : 90;

        if (currentMinutes + visitDuration <= endOfDayMinutes) {
          double itemCost = (dest.ticketPrice * preference.numberOfPeople).toDouble();
          
          if (currentCost + itemCost <= preference.budget || preference.budget <= 0) {
             String startTimeStr = _formatMinutesToTime(currentMinutes);
             int endTimeMinutes = currentMinutes + visitDuration;
             String endTimeStr = _formatMinutesToTime(endTimeMinutes);

             final newItem = ItineraryItemEntity(
               destination: dest,
               day: day,
               startTime: startTimeStr,
               endTime: endTimeStr,
               visitDuration: visitDuration,
               estimatedCost: itemCost,
               order: dayItems.length + 1,
             );
             
             dayItems.add(newItem);
             itinerary.add(newItem);
             
             currentCost += itemCost;
             totalDestinationCost += itemCost;
             visitedIds.add(dest.id);
             
             print('[TripPlanner] Destination: \${dest.name}');
             print('[TripPlanner] Ticket price/person: \${dest.ticketPrice}');
             print('[TripPlanner] People: \${preference.numberOfPeople}');
             print('[TripPlanner] Estimated cost: \$itemCost');

             currentMinutes = endTimeMinutes + 30; // 30 menit buffer perjalanan
          }
        }
      }
    }

    if (itinerary.isEmpty) {
       throw NoItineraryFoundException();
    }

    print('[TripPlanner] ===== COST CALCULATION =====');
    print('[TripPlanner] People: \${preference.numberOfPeople}');
    print('[TripPlanner] Transportation cost: \$transportCost');
    print('[TripPlanner] Destination ticket cost: \$totalDestinationCost');
    print('[TripPlanner] Total estimated budget: \$currentCost');

    return TripPlanEntity(
      id: 'trip_\${DateTime.now().millisecondsSinceEpoch}',
      city: preference.favoriteCity ?? '',
      numberOfPeople: preference.numberOfPeople,
      budget: preference.budget,
      transportation: preference.transportation,
      interests: preference.interests,
      durationDays: preference.durationDays,
      items: itinerary,
      totalDestination: itinerary.length,
      estimatedBudget: currentCost,
      transportCost: transportCost,
      destinationCost: totalDestinationCost,
      remainingBudget: (preference.budget - currentCost) > 0 ? (preference.budget - currentCost) : 0,
    );
  }

  @override
  Future<void> saveTripPlan(TripPlanEntity tripPlan) async {
    final model = TripPlanModel(
      id: tripPlan.id,
      city: tripPlan.city,
      numberOfPeople: tripPlan.numberOfPeople,
      budget: tripPlan.budget,
      transportation: tripPlan.transportation,
      interests: tripPlan.interests,
      durationDays: tripPlan.durationDays,
      items: tripPlan.items,
      totalDestination: tripPlan.totalDestination,
      estimatedBudget: tripPlan.estimatedBudget,
      transportCost: tripPlan.transportCost,
      destinationCost: tripPlan.destinationCost,
      remainingBudget: tripPlan.remainingBudget,
    );
    await localDataSource.saveTripPlan(model);
  }

  @override
  Future<List<TripPlanEntity>> getSavedTripPlans() async {
    return await localDataSource.getSavedTripPlans();
  }

  @override
  Future<void> deleteTripPlan(String tripPlanId) async {
    await localDataSource.deleteTripPlan(tripPlanId);
  }

  double _calculateDestinationScore(DestinationEntity dest, TripPreferenceEntity pref) {
    double score = 0;

    // Favourite City Match (+30)
    if (pref.favoriteCity != null && pref.favoriteCity!.isNotEmpty) {
       String fav = pref.favoriteCity!.toLowerCase();
       if (dest.city.toLowerCase() == fav || dest.location.toLowerCase().contains(fav)) {
          score += 30;
       }
    }

    // Interest Match (+30)
    if (pref.interests.isNotEmpty) {
       bool matched = false;
       for (var interest in pref.interests) {
          if (dest.interests.map((e)=>e.toLowerCase()).contains(interest.toLowerCase()) ||
              dest.categoryId.toLowerCase() == interest.toLowerCase()) {
             matched = true;
          }
       }
       if (matched) score += 30;
    }

    // Budget Compatibility (+15)
    double destCost = (dest.ticketPrice * pref.numberOfPeople) + (dest.estimatedFoodCost * pref.numberOfPeople).toDouble();
    if (destCost == 0 || pref.budget <= 0) {
       score += 15;
    } else if (destCost < (pref.budget / pref.durationDays)) {
       score += 15;
    }

    // Recommended Time Match (+10)
    score += 10;

    // Rating High (+10)
    if (dest.rating >= 4.0) {
       score += 10;
    }

    // Duration Compatible (+5)
    if (dest.estimatedVisitDuration <= 120) {
       score += 5;
    }

    return score > 100 ? 100 : score;
  }

  String _formatMinutesToTime(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int mins = totalMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
  }
}

class _ScoredDestination {
  final DestinationEntity destination;
  final double score;

  _ScoredDestination({required this.destination, required this.score});
}
