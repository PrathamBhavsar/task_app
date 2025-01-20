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

  String getMaterial(String roomName, String windowName) {
    return roomDetails[roomName]?[windowName]?['material'] ?? "";
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

  double calculateTotalAmount() {
    double totalAmount = 0.0;

    roomDetails.forEach((roomName, windows) {
      windows.forEach((windowName, windowDetails) {
        double amount = double.tryParse(windowDetails['amount'] ?? '0') ?? 0;
        totalAmount += amount;
      });
    });

    return totalAmount;
  }

  double calculateRoomTotal(String roomName) {
    double roomTotal = 0.0;

    // Check if room exists
    if (roomDetails.containsKey(roomName)) {
      // Sum amounts for all windows in the room
      roomDetails[roomName]!.forEach((windowName, windowDetails) {
        double amount = double.tryParse(windowDetails['amount'] ?? '0') ?? 0;
        roomTotal += amount;
      });
    }

    return roomTotal;
  }
}
