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

  /// create task
  Future<void> createTask(name, remarks) async {
    final sales = fetchedData['salespersons'];
    final agency = fetchedData['agencies'];
    final designer = fetchedData['designers'];

    final List<String> selectedSalespersonIds =
        (selectedIndices['salespersons'] as List<dynamic>)
            .map((index) => sales![index]['id'] as String)
            .toList();

    final List<String> selectedAgencyIds =
        (selectedIndices['agency'] as List<dynamic>)
            .map((index) => agency![index]['id'] as String)
            .toList();

    final List<String> selectedDesignerIds =
        (selectedIndices['designers'] as List<dynamic>)
            .map((index) => designer![index]['id'] as String)
            .toList();

    await SupabaseController.instance.createTask(
      name: name,
      remarks: remarks,
      status: fetchedData['task_status']![selectedIndices['status']]['slug'],
      dueDate: dueDate,
      priority: fetchedData['task_priority']![selectedIndices['priority']]
          ['name'],
      startDate: startDate,
      selectedClientId: fetchedData['clients']![selectedIndices['client']],
      selectedSalespersonIds: selectedSalespersonIds,
      selectedAgencyIds: selectedAgencyIds,
      selectedDesignerIds: selectedDesignerIds,
    );
  }

  /// update task
  Future<void> updateTask(
    String name,
    String remarks,
    String dealNo,
  ) async {
    // Prepare salespersons
    final sales = fetchedData['salespersons'];
    final List<String> selectedSalespersonIds =
        (selectedIndices['salespersons'] as List<dynamic>)
            .map((index) => sales![index]['id'] as String)
            .toList();

    // Prepare agencies
    final agencies = fetchedData['agencies'];

    final List<String> selectedAgencyIds =
        (selectedIndices['agency'] as List<dynamic>? ?? [])
            .map((index) => agencies![index]['id'] as String)
            .toList();

    // Prepare designers
    final designers = fetchedData['designers'];

    final List<String> selectedDesignerIds =
        (selectedIndices['designers'] as List<dynamic>? ?? [])
            .map((index) => designers![index]['id'] as String)
            .toList();

    // Perform all Supabase updates
    await SupabaseController.instance.updateTask(
      dealNo: dealNo,
      name: name,
      remarks: remarks,
      status: fetchedData['task_status']![selectedIndices['status']]['slug'],
      dueDate: dueDate,
      priority: fetchedData['task_priority']![selectedIndices['priority']]
          ['name'],
      startDate: startDate,
      selectedClientId: fetchedData['clients']![selectedIndices['client']],
      selectedSalespersonIds: selectedSalespersonIds,
      selectedAgencyIds: selectedAgencyIds,
      selectedDesignerIds: selectedDesignerIds,
      fetchedTaskData: fetchedTaskData,
    );
  }

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
    final List<dynamic> taskDesigner =
        taskData['task_designers']?.where((e) => e != null).toList() ?? [];
    final List<dynamic> taskAgency =
        taskData['task_agencies']?.where((e) => e != null).toList() ?? [];
    final List<dynamic> taskClients = taskData['task_clients'] ?? [];
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

    // Find matching indices for salespersons or default to an empty list
    selectedIndices['salespersons'] = taskSalesperson.isNotEmpty
        ? fetchedSalesperson
            .asMap()
            .entries
            .where((entry) => taskSalesperson
                .any((salesperson) => salesperson['id'] == entry.value["id"]))
            .map((entry) => entry.key)
            .toList()
        : [];

    // Find matching indices for designers or default to an empty list
    selectedIndices['designers'] = taskDesigner.isNotEmpty
        ? fetchedDesigner
            .asMap()
            .entries
            .where((entry) => taskDesigner
                .any((designer) => designer['id'] == entry.value["id"]))
            .map((entry) => entry.key)
            .toList()
        : [];

    // Find matching indices for agencies or default to an empty list
    selectedIndices['agency'] = taskAgency.isNotEmpty
        ? fetchedAgency
            .asMap()
            .entries
            .where((entry) =>
                taskAgency.any((agency) => agency['id'] == entry.value["id"]))
            .map((entry) => entry.key)
            .toList()
        : [];

    // Find matching index for client or default to 0
    selectedIndices['client'] = taskClients.isNotEmpty
        ? fetchedClient
            .indexWhere((client) => client['id'] == taskClients[0]['id'])
        : 0;

    // Find matching index for priority or default to 0
    selectedIndices['priority'] = taskPriority != null
        ? fetchedPriority.indexWhere((map) => map["name"] == taskPriority)
        : 0;

    // Find matching index for status or default to 0
    selectedIndices['status'] = taskStatus != null
        ? fetchedStatus.indexWhere((map) => map["slug"] == taskStatus)
        : 0;
  }

  Future<void> getTaskByDealNo(String dealNo) async {
    final data = await SupabaseController.instance.getTaskById(dealNo);
    fetchedTaskData = data;
    logger.d(data);

    setStartDate(DateTime.parse(data['start_date']));
    setDueDate(DateTime.parse(data['due_date']));

    setFetchedSelectedIndices(data);
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

    fetchedData['payment_tasks'] = (data['payment_tasks'] as List<dynamic>?)
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
