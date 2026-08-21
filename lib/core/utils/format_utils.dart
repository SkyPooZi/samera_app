import 'package:intl/intl.dart';

class FormatUtils {
  static String formatCityLabel(String id) {
    if (id.isEmpty) return '';
    return id
        .split('_')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join(' ');
  }

  static String formatTransportationLabel(String id) {
    if (id == 'motor') return 'Motor';
    if (id == 'mobil') return 'Mobil';
    if (id == 'kereta') return 'Kereta';
    if (id == 'pesawat') return 'Pesawat';
    if (id == 'kapal') return 'Kapal';
    return '';
  }

  static String formatInterestLabel(String ids) {
    if (ids.isEmpty) return 'Pilih minat Anda';
    final map = {
      'destination': 'Destinasi',
      'heritage': 'Sejarah',
      'cuisine': 'Kuliner',
      'culture': 'Budaya',
      'local_experience': 'Aktivitas Lokal',
    };
    return ids.split(',').map((id) => map[id.trim()] ?? id).join(', ');
  }

  static String formatBudgetLabel(String budget) {
    if (budget.isEmpty) return '-';
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatCurrency.format(int.parse(budget));
  }

  static String formatDuration(int minutes) {
    if (minutes < 60) return '$minutes Menit';
    int h = minutes ~/ 60;
    int m = minutes % 60;
    if (m == 0) return '$h Jam';
    if (m == 30) return '$h,5 Jam';
    return '$h Jam $m Menit';
  }
}
