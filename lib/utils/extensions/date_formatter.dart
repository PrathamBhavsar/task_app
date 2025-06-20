import 'package:intl/intl.dart';

extension PrettyPaidAt on String {
  String toPrettyDateTime() {
    DateTime date = DateTime.parse(this);

    final monthDay = DateFormat('MMM d').format(date);
    final time = DateFormat('h:mma').format(date);

    return '$monthDay, $time';
  }
}

extension PrettyPaidAtDateTime on DateTime {
  String toPrettyDateTime() {
    final localDate = toLocal();
    final monthDay = DateFormat('MMM d').format(localDate);
    final time = DateFormat('h:mma').format(localDate);
    return '$monthDay, $time';
  }

  String toPrettyDate() {
    final localDate = toLocal();
    final formattedDate = DateFormat('MMM d, yyyy').format(localDate);
    return formattedDate;
  }

  /// Converts to ISO string in local time (not UTC)
  String toLocalIsoString() {
    final local = toLocal();
    return DateFormat("yyyy-MM-ddTHH:mm:ss").format(local);
  }
}
