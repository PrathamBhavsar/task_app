import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/controllers/auth_controller.dart';
import 'package:task_app/controllers/supabase_controller.dart';
import 'package:task_app/models/user.dart';

class TaskProvider extends ChangeNotifier {
  static final TaskProvider instance = TaskProvider._privateConstructor();

  TaskProvider._privateConstructor();

  final Logger logger = Logger();

  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();

  Map<String, List<Map<String, dynamic>>> fetchedData = {};
  Map<String, List<Map<String, dynamic>>> fetchedTasksData = {};
  bool isAgencyRequired = true;
  int selectedListIndex = 0;
  Map<String, dynamic> selectedIndices = {
    'assignedFor': [],
    'designers': [],
    'agency': [],
    'status': 0,
    'priority': 0,
  };

  /// updates list index
  void setSelectedListIndex(int index) {
    selectedListIndex = index;
    notifyListeners();
  }

  /// updates selection
  void updateSelectedIndex(String field, dynamic index) {
    selectedIndices[field] = index;
    notifyListeners();
  }

  ///fetches all the tasks
  Future<void> fetchAllTasks() async {
    final futures = [
      fetchData('clients'),
      fetchData('designers'),
      fetchData('users', filters: {'role': 'Salesperson'}, key: 'salespersons'),
      fetchData('users', filters: {'role': 'Agency'}, key: 'agencies'),
      fetchData('task_status', orderBy: 'order', ascending: true),
      fetchData('task_priority'),
    ];

    // Await all futures in parallel
    await Future.wait(futures);

    logger.d(fetchedData);
    notifyListeners();
  }

  /// fetches all the data
  Future<void> fetchAllData() async {
    final futures = [
      fetchData('clients'),
      fetchData('designers'),
      fetchData('users', filters: {'role': 'Salesperson'}, key: 'salespersons'),
      fetchData('users', filters: {'role': 'Agency'}, key: 'agencies'),
      fetchData('task_status', orderBy: 'order', ascending: true),
      fetchData('task_priority'),
    ];

    // Await all futures in parallel
    await Future.wait(futures);
    final data = await SupabaseController.instance.getAllTasks();

    fetchedData['pending_tasks'] = (data['pending_tasks'] as List<dynamic>?)
            ?.map((item) => item as Map<String, dynamic>)
            .toList() ??
        [];

    fetchedData['shared_tasks'] = (data['shared_tasks'] as List<dynamic>?)
            ?.map((item) => item as Map<String, dynamic>)
            .toList() ??
        [];

    fetchedData['complete_tasks'] = (data['complete_tasks'] as List<dynamic>?)
            ?.map((item) => item as Map<String, dynamic>)
            .toList() ??
        [];

    logger.d(fetchedData);
    notifyListeners();
  }

  /// Generic method to fetch data
  Future<void> fetchData(
    String table, {
    Map<String, dynamic>? filters,
    String? select,
    String? orderBy,
    bool ascending = true,
    String? key,
  }) async {
    final data = await SupabaseController.instance.getRows(
      table: table,
      filters: filters,
      select: select,
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

  /// String to color
  Color stringToColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return AppColors.orange; // Default color if none provided
    }
    return Color(int.parse(colorString, radix: 16));
  }

  /// formats date
  String formatDate(dynamic date) {
    DateTime dateTime;

    if (date is String) {
      try {
        dateTime = DateTime.parse(date);
      } catch (e) {
        dateTime = DateTime.now();
      }
    } else if (date is DateTime) {
      dateTime = date;
    } else {
      throw ArgumentError('Invalid argument type');
    }

    return DateFormat('d MMM, yyyy').format(dateTime);
  }
}
