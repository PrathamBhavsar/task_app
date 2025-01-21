import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'measurement_provider.dart';

class QuotationProvider with ChangeNotifier {
  static final QuotationProvider instance =
      QuotationProvider._privateConstructor();

  QuotationProvider._privateConstructor();
  var log = Logger();

  final Map<String, Map<String, Map<String, String>>> roomDetails =
      MeasurementProvider.instance.windowMeasurements;

  // New variable for quotation-specific use
  final Map<String, Map<String, Map<String, dynamic>>> quotationDetails = {};

  void saveAllQuotations(
      Map<String, Map<String, Map<String, dynamic>>> updatedQuotation) {
    // Clear the quotationDetails before saving new data
    quotationDetails.clear();

    // Iterate over measurements to preserve its structure and merge data
    roomDetails.forEach((roomName, windows) {
      quotationDetails[roomName] = {};

      windows.forEach((windowName, measurements) {
        final updatedData = updatedQuotation[roomName]?[windowName] ?? {};

        // Create a new map combining measurements and updated quotation details
        quotationDetails[roomName]![windowName] = {
          'area': measurements['area'],
          'type': measurements['type'],
          'material': updatedData['material'] ?? '',
          'rate': updatedData['rate'] ?? '',
          'remarks': measurements['remarks'],
          // Calculate the amount dynamically
          'amount': ((double.tryParse(measurements['area'] ?? '0') ?? 0) *
                  (updatedData['rate'] ?? 0))
              .toStringAsFixed(2),
        };
      });
    });

    log.d(quotationDetails);
    notifyListeners();
  }

  double getRate(String roomName, String windowName) => double.tryParse(
            roomDetails[roomName]?[windowName]?['rate'] ?? '0') ??
        0;

  String getMaterial(String roomName, String windowName) => quotationDetails[roomName]?[windowName]?['material'] ?? "";

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
