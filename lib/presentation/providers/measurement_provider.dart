import 'package:flutter/material.dart';

import '../../data/models/measurement.dart';
import '../../data/models/service.dart';

class MeasurementProvider extends ChangeNotifier {
  ///attachments
  final List<String> attachments = [];

  void addAttachment() {
    attachments.add('photo.png');
    notifyListeners();
  }

  void removeAttachmentAt(int index) {
    attachments.removeAt(index);
    notifyListeners();
  }

  ///services
  final List<Service> services = [Service.empty];

  void addService() {
    services.add(Service.empty);
    notifyListeners();
  }

  void removeServiceAt(int index) {
    if (services.length == 1) return;
    services.removeAt(index);
    notifyListeners();
  }

  ///measurements
  final List<Measurement> additionalItems = [Measurement.empty];

  void addAdditionalItems() {
    additionalItems.add(Measurement.empty);
    notifyListeners();
  }

  void removeAdditionalItems(int index) {
    if (additionalItems.length == 1) return;
    additionalItems.removeAt(index);
    notifyListeners();
  }

  ///measurements
  final List<Measurement> measurements = [Measurement.empty];

  void addMeasurement() {
    measurements.add(Measurement.empty);
    notifyListeners();
  }

  void removeMeasurementAt(int index) {
    if (measurements.length == 1) return;
    measurements.removeAt(index);
    notifyListeners();
  }
}
