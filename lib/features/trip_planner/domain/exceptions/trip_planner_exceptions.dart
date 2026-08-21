class InsufficientBudgetException implements Exception {
  final double budget;
  final double minimumEstimatedCost;
  final String transportation;

  InsufficientBudgetException({
    required this.budget,
    required this.minimumEstimatedCost,
    required this.transportation,
  });

  @override
  String toString() {
    return 'INSUFFICIENT_BUDGET: Budget tidak mencukupi untuk transportasi yang dipilih.';
  }
}

class NoItineraryFoundException implements Exception {
  @override
  String toString() {
    return 'Tidak ditemukan itinerary yang sesuai dengan preferensi Anda.';
  }
}
