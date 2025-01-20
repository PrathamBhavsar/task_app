import 'package:flutter/material.dart';
import 'package:task_app/constants/dummy_data.dart';

class QuotationProvider with ChangeNotifier {
  static final QuotationProvider instance =
      QuotationProvider._privateConstructor();

  QuotationProvider._privateConstructor();

  final Map<String, Map<String, Map<String, String>>> roomDetails =
      DummyData.roomDetails;

  double getRate(String roomName, String windowName) {
    return double.tryParse(
            roomDetails[roomName]?[windowName]?['rate'] ?? '0') ??
        0;
  }

  void setRate(String roomName, String windowName, double newRate) {
    if (roomDetails.containsKey(roomName) &&
        roomDetails[roomName]!.containsKey(windowName)) {
      roomDetails[roomName]![windowName]!['rate'] = newRate.toString();

      // Update the amount dynamically based on the rate and area
      double area =
          double.tryParse(roomDetails[roomName]![windowName]!['area'] ?? '0') ??
              0;
      double amount = area * newRate;

      roomDetails[roomName]![windowName]!['amount'] = amount.toStringAsFixed(2);

      notifyListeners();
    }
  }
}
