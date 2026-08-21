class TripPreferenceEntity {
  final double budget;
  final int durationDays;
  final String transportation;
  final List<String> interests;
  final String? favoriteCity;
  final int numberOfPeople;

  const TripPreferenceEntity({
    required this.budget,
    required this.durationDays,
    required this.transportation,
    required this.interests,
    this.favoriteCity,
    required this.numberOfPeople,
  });
}
