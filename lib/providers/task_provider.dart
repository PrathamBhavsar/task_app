import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/constants/supabase_keys.dart';
import 'package:task_app/controllers/supabase_controller.dart';

class TaskProvider extends ChangeNotifier {
  static final TaskProvider instance = TaskProvider._privateConstructor();

  TaskProvider._privateConstructor();

  final Logger logger = Logger();

  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();

  Map<String, List<Map<String, dynamic>>> fetchedData = {};
  Map<String, dynamic> fetchedTaskData = {};

  bool isAgencyRequired = false;
  int selectedListIndex = 0;
  Map<String, dynamic> selectedIndices = {
    'salespersons': [],
    'designers': [],
    'agency': [],
    'client': 0,
    'status': 0,
    'priority': 0,
  };

  /// reset task indexes
  void resetTaskIndexes() {
    selectedIndices = {
      'salespersons': [],
      'designers': [],
      'agency': [],
      'client': 0,
      'status': 0,
      'priority': 0,
    };
    fetchedTaskData.clear();
    dueDate = DateTime.now().add(Duration(days: 2));
    startDate = DateTime.now();
  }

  /// sets task indexes
  void setFetchedSelectedIndices(Map<String, dynamic> taskData) {
    // Extract values from taskData
    final List<dynamic> taskSalesperson = taskData['task_salespersons'] ?? [];
    final List<dynamic> taskDesigner = taskData['task_designers'] ?? [];
    final List<dynamic> taskAgency = taskData['task_agencies'] ?? [];
    final List<dynamic> taskClients = taskData['task_clients'];
    final String taskStatus = taskData['status'];
    final String taskPriority = taskData['priority'];

    // Extract lists from fetchedData
    final List<Map<String, dynamic>> fetchedSalesperson =
        List<Map<String, dynamic>>.from(fetchedData["salespersons"] ?? []);
    final List<Map<String, dynamic>> fetchedDesigner =
        List<Map<String, dynamic>>.from(fetchedData["designers"] ?? []);
    final List<Map<String, dynamic>> fetchedAgency =
        List<Map<String, dynamic>>.from(fetchedData["agencies"] ?? []);
    final List<Map<String, dynamic>> fetchedClient =
        List<Map<String, dynamic>>.from(fetchedData["clients"] ?? []);
    final List<Map<String, dynamic>> fetchedPriority =
        List<Map<String, dynamic>>.from(fetchedData["task_priority"] ?? []);
    final List<Map<String, dynamic>> fetchedStatus =
        List<Map<String, dynamic>>.from(fetchedData["task_status"] ?? []);

    // Set isAgencyRequired to true only if agency is present
    if (taskAgency.isNotEmpty) {
      isAgencyRequired = true;
      notifyListeners();
    }

    // Find matching indices for salespersons
    selectedIndices['salespersons'] = fetchedSalesperson
        .asMap()
        .entries
        .where((entry) => taskSalesperson
            .any((salesperson) => salesperson['id'] == entry.value["id"]))
        .map((entry) => entry.key)
        .toList();

    // Find matching indices for designers
    selectedIndices['designers'] = fetchedDesigner
        .asMap()
        .entries
        .where((entry) =>
            taskDesigner.any((designer) => designer['id'] == entry.value["id"]))
        .map((entry) => entry.key)
        .toList();

    // Find matching indices for agencies
    selectedIndices['agency'] = fetchedAgency
        .asMap()
        .entries
        .where((entry) =>
            taskAgency.any((agency) => agency['id'] == entry.value["id"]))
        .map((entry) => entry.key)
        .toList();

    // Find matching index for priority (by name)
    selectedIndices['client'] = fetchedClient
        .asMap()
        .entries
        .where((entry) =>
            taskClients.any((client) => client['id'] == entry.value["id"]))
        .map((entry) => entry.key)
        .toList()
        .first; // Get the first matching index

    // Find matching index for priority (by name)
    selectedIndices['priority'] =
        fetchedPriority.indexWhere((map) => map["name"] == taskPriority);

    // Find matching index for status (by name)
    selectedIndices['status'] =
        fetchedStatus.indexWhere((map) => map["name"] == taskStatus);
  }

  Future<void> getTaskByDealNo(String dealNo) async {
    final data = await SupabaseController.instance.getTaskById(dealNo);
    fetchedTaskData = data;
    logger.d(data);

    setStartDate(DateTime.parse(data['start_date']));
    setDueDate(DateTime.parse(data['due_date']));

    setFetchedSelectedIndices(data);
    logger.i(selectedIndices);
    notifyListeners();
  }

  /// Updates task list index
  void setSelectedListIndex(int index) {
    selectedListIndex = index;
    notifyListeners();
  }

  /// Updates selection
  void updateSelectedIndex(String field, dynamic index) {
    selectedIndices[field] = index;
    notifyListeners();
    logger.i(selectedIndices);
  }

  /// Fetches all the data
  Future<void> fetchAllData() async {
    final futures = [
      fetchData(SupabaseKeys.clientsTable),
      fetchData(SupabaseKeys.designersTable),
      fetchData(SupabaseKeys.usersTable,
          filters: {'role': UserRole.salesperson.role}, key: 'salespersons'),
      fetchData(SupabaseKeys.usersTable,
          filters: {'role': UserRole.agency.role}, key: 'agencies'),
      fetchData(SupabaseKeys.taskStatusTable,
          orderBy: 'order', ascending: true),
      fetchData(SupabaseKeys.taskPriorityTable),
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
      return AppColors.orange;
    }
    return Color(int.parse(colorString, radix: 16));
  }

  /// Formats date
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
