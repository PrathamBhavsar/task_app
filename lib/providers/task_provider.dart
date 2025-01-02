import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_app/controllers/supabase_controller.dart';

class TaskProvider extends ChangeNotifier {
  static final TaskProvider instance = TaskProvider._privateConstructor();

  TaskProvider._privateConstructor() {
    _init();
  }

  final Logger logger = Logger();

  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();

  Map<String, List<Map<String, dynamic>>> fetchedData = {};
  bool isAgencyRequired = true;

  /// Initialize and fetch all necessary data
  void _init() async {
    await fetchData('clients');
    await fetchData('designers');
    await fetchData('users',
        filters: {'role': 'Salesperson'}, key: 'salespersons');
    await fetchData('users', filters: {'role': 'Agency'}, key: 'agencies');
    await fetchData('task_status', orderBy: 'order', ascending: true);
    await fetchData('task_priority');
  }

  /// Generic method to fetch data
  Future<void> fetchData(
    String table, {
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    String? key,
  }) async {
    final data = await SupabaseController.instance.getRows(
      table: table,
      filters: filters,
      orderBy: orderBy,
      ascending: ascending,
    );

    final storageKey = key ?? table;
    fetchedData[storageKey] = data;
    logger.d(fetchedData);
    notifyListeners();
  }

  /// Toggle agency requirement
  void toggleAgencyRequired() {
    isAgencyRequired = !isAgencyRequired;
    notifyListeners();
  }

  /// Set the due date
  void setDueDate(DateTime newDueDate) {
    dueDate = newDueDate;
    notifyListeners();
  }

  /// Set the start date
  void setStartDate(DateTime newStartDate) {
    startDate = newStartDate;
    notifyListeners();
  }

  /// Add selected users
  void addSelectedUsers(
    List<Map<String, dynamic>> users,
    TextEditingController controller,
    String key,
  ) {
    fetchedData[key] = [...users];
    logger.i(fetchedData[key]);
    controller.text = users.map((user) => user['name']).join(', ');
    notifyListeners();
  }
}
