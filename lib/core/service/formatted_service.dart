import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatService {
  final currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final formattedDate = DateFormat("d MMMM yyyy", 'id_ID');
  final sendDateFormat = DateFormat('yyyy-MM-dd');
  final monthYearFormat = DateFormat('MMMM yyyy');
  final shortDateFormat = DateFormat("E, d MMM yyyy", "id_ID");

  DateTime dateTimeParsed(String input) {
    return DateTime.parse(input).toLocal();
  }

  String toStringDateTimeRange(DateTimeRange input) {
    String startDate = DateFormat("d MMMM yyyy", 'id_ID').format(input.start);
    String endDate = DateFormat("d MMMM yyyy", 'id_ID').format(input.end);
    return '$startDate - $endDate';
  }

  String toShortDate(String input) {
    DateTime parsedDate = DateFormat("EEEE, d MMMM yyyy", "id_ID").parse(input);
    return shortDateFormat.format(parsedDate);
  }
}
