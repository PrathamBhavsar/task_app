import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/controllers/supabase_controller.dart';

class TaskProvider extends ChangeNotifier {
  static final TaskProvider instance = TaskProvider._privateConstructor();

  TaskProvider._privateConstructor();

  final Logger logger = Logger();

  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();

  Map<String, List<Map<String, dynamic>>> fetchedData = {};
  Map<String, List<Map<String, dynamic>>> fetchedTasksData = {};
  bool isAgencyRequired = true;
  int selectedStatusIndex = 0;
  Map<String, dynamic> selectedIndices = {
    'assignedFor': [],
    'designers': [],
    'agency': [],
    'status': 0,
    'priority': 0,
  };

  void updateSelectedIndex(String field, dynamic index) {
    selectedIndices[field] = index;
    notifyListeners();
  }

  /// Toggle selection for multi-select fields
  void toggleSelection(String field, int index) {
    if (!selectedIndices.containsKey(field)) return;

    if (selectedIndices[field]!.contains(index)) {
      selectedIndices[field]!.remove(index);
    } else {
      selectedIndices[field]!.add(index);
    }
    logger.d(selectedIndices[field]);
    notifyListeners();
  }

  /// Select only one for single-select fields
  void selectSingle(String field, int index) {
    if (!selectedIndices.containsKey(field)) return;

    selectedIndices[field] = [index];
    logger.d(selectedIndices[field]);
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
      fetchData('tasks',
          filters: {'status': 'Pending'},
          key: 'pending_tasks',
          orderBy: 'created_at',
          ascending: true),
      fetchData('tasks',
          filters: {'status': 'Measurement'},
          key: 'shared_tasks',
          orderBy: 'created_at',
          ascending: true),
      fetchData('tasks',
          filters: {'status': 'Closed'},
          key: 'completed_tasks',
          orderBy: 'created_at',
          ascending: true),
    ];

    // Await all futures in parallel
    await Future.wait(futures);
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

  /// String to color
  Color stringToColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return AppColors.orange; // Default color if none provided
    }
    return Color(int.parse(colorString, radix: 16));
  }
}
