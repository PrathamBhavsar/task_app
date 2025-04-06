import 'package:flutter/material.dart';

import '../../data/models/employee.dart';
import '../../utils/extensions/date_formatter.dart';
import '../widgets/chart_widget.dart';

class AppointmentProvider extends ChangeNotifier {
  List<String> get summaryValues => [
    _name,
    _phone,
    _persons,
    "01",
    DateTime.now().toFormattedWithSuffix(),
  ];

  void reset() {
    _name = "";
    _phone = "";
    _persons = "";
    notifyListeners();
  }

  String _persons = "1";
  void setPersons(String value) {
    _persons = value;
    notifyListeners();
  }

  String _name = "";
  String get name => _name;
  void nameOnChanged(String value) {
    _name = value;
    notifyListeners();
  }

  String _phone = "";
  String get phone => _phone;
  void phoneOnChanged(String value) {
    _phone = value;
    notifyListeners();
  }

  String _selectedGender = 'Male';

  String get selectedGender => _selectedGender;

  void setGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }
}
