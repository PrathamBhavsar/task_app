import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TaskProvider extends ChangeNotifier {
  static final TaskProvider instance = TaskProvider._privateConstructor();

  TaskProvider._privateConstructor();
  var logger = Logger();

  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();
  List<Map<String, dynamic>> selectedAssignees = [];
  List<Map<String, dynamic>> selectedDesigners = [];
  List<Map<String, dynamic>> selectedClients = [];

  List<Map<String, dynamic>> userNames = [];

  bool isAgencyRequired = true;

  /// toggle switch
  void toggleAgencyRequired() {
    isAgencyRequired = !isAgencyRequired;
    notifyListeners();
  }

  /// Method to set the due date
  void setDueDate(DateTime newDueDate) {
    dueDate = newDueDate;
    notifyListeners();
  }

  /// Method to set the start date
  void setStartDate(DateTime newStartDate) {
    startDate = newStartDate;
    notifyListeners();
  }

  /// Fetch Users from Supabase
  Future<void> getUsers(String table) async {
    userNames.clear();
    // final response = await SupabaseController.instance.getUsers(table);
    // userNames.addAll(response ?? []);
    notifyListeners();
  }

  // Add selected users for Assignees
  void addAssignees(
      List<Map<String, dynamic>> users, TextEditingController controller) {
    selectedAssignees = [...users];
    logger.i(selectedAssignees);
    controller.text = selectedAssignees.map((user) => user["name"]).join(", ");
    notifyListeners();
  }

  /// Add selected users for Designers
  void addDesigners(
      List<Map<String, dynamic>> users, TextEditingController controller) {
    selectedDesigners = [...users];
    logger.i(selectedDesigners);
    controller.text = selectedDesigners.map((user) => user["name"]).join(", ");
    notifyListeners();
  }

  /// Add selected users for Clients
  void addClients(
      List<Map<String, dynamic>> users, TextEditingController controller) {
    selectedClients = [...users];
    logger.i(selectedClients);
    controller.text = selectedClients.map((user) => user["name"]).join(", ");
    notifyListeners();
  }
}
