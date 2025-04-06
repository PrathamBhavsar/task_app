import 'package:intl/intl.dart';

extension PrettyDate on DateTime {
  String toFormattedWithSuffix() {
    final day = this.day;
    final suffix = _getDaySuffix(day);
    final dayName = DateFormat('E').format(this);
    final month = DateFormat('MMM').format(this);
    return '$dayName, ${day}$suffix $month';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
