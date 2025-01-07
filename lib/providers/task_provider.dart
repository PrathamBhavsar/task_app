import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/constants/app_keys.dart';
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
    IndexKeys.salespersonIndex: [],
    IndexKeys.designerIndex: [],
    IndexKeys.agencyIndex: [],
    IndexKeys.clientIndex: 0,
    IndexKeys.statusIndex: 0,
    IndexKeys.priorityIndex: 0,
  };

  /// create task
  Future<void> createTask(name, remarks) async {
    final sales = fetchedData[AppKeys.fetchedSalespersons];
    final agency = fetchedData[AppKeys.fetchedAgencies];
    final designer = fetchedData[AppKeys.fetchedDesigners];

    final List<String> selectedSalespersonIds =
        (selectedIndices[IndexKeys.salespersonIndex] as List<dynamic>)
            .map((index) => sales![index][SupabaseKeys.id] as String)
            .toList();

    final List<String> selectedAgencyIds =
        (selectedIndices[IndexKeys.agencyIndex] as List<dynamic>)
            .map((index) => agency![index][SupabaseKeys.id] as String)
            .toList();

    final List<String> selectedDesignerIds =
        (selectedIndices[IndexKeys.designerIndex] as List<dynamic>)
            .map((index) => designer![index][SupabaseKeys.id] as String)
            .toList();

    await SupabaseController.instance.createTask(
      name: name,
      remarks: remarks,
      status: fetchedData[AppKeys.fetchedStatus]![
          selectedIndices[IndexKeys.statusIndex]][AppKeys.nameKey],
      dueDate: dueDate,
      priority: fetchedData[AppKeys.fetchedPriority]![
          selectedIndices[IndexKeys.priorityIndex]][AppKeys.nameKey],
      startDate: startDate,
      selectedClientId: fetchedData[AppKeys.fetchedClients]![
          selectedIndices[IndexKeys.clientIndex]],
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
    final sales = fetchedData[AppKeys.fetchedSalespersons];
    final List<String> selectedSalespersonIds =
        (selectedIndices[IndexKeys.salespersonIndex] as List<dynamic>)
            .map((index) => sales![index][SupabaseKeys.id] as String)
            .toList();

    // Prepare agencies
    final agencies = fetchedData[AppKeys.fetchedAgencies];

    final List<String> selectedAgencyIds =
        (selectedIndices[IndexKeys.agencyIndex] as List<dynamic>? ?? [])
            .map((index) => agencies![index][SupabaseKeys.id] as String)
            .toList();

    // Prepare designers
    final designers = fetchedData[AppKeys.fetchedDesigners];

    final List<String> selectedDesignerIds =
        (selectedIndices[IndexKeys.designerIndex] as List<dynamic>? ?? [])
            .map((index) => designers![index][SupabaseKeys.id] as String)
            .toList();

    // Perform all Supabase updates
    await SupabaseController.instance.updateTask(
      dealNo: dealNo,
      name: name,
      remarks: remarks,
      status: fetchedData[AppKeys.fetchedStatus]![
          selectedIndices[IndexKeys.statusIndex]][AppKeys.nameKey],
      dueDate: dueDate,
      priority: fetchedData[AppKeys.fetchedPriority]![
          selectedIndices[IndexKeys.priorityIndex]][AppKeys.nameKey],
      startDate: startDate,
      selectedClientId: fetchedData[AppKeys.fetchedClients]![
          selectedIndices[IndexKeys.clientIndex]],
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
    final List<dynamic> taskSalesperson =
        taskData[TaskKeys.taskSalespersons] ?? [];
    final List<dynamic> taskDesigner =
        taskData[TaskKeys.taskDesigners]?.where((e) => e != null).toList() ??
            [];
    final List<dynamic> taskAgency =
        taskData[TaskKeys.taskAgencies]?.where((e) => e != null).toList() ?? [];
    final List<dynamic> taskClients = taskData[TaskKeys.taskClients] ?? [];
    final String taskStatus = taskData[TaskKeys.taskStatus];
    final String taskPriority = taskData[TaskKeys.taskPriority];

    // Extract lists from fetchedData
    final List<Map<String, dynamic>> fetchedSalesperson =
        List<Map<String, dynamic>>.from(
            fetchedData[AppKeys.fetchedSalespersons] ?? []);
    final List<Map<String, dynamic>> fetchedDesigner =
        List<Map<String, dynamic>>.from(
            fetchedData[AppKeys.fetchedDesigners] ?? []);
    final List<Map<String, dynamic>> fetchedAgency =
        List<Map<String, dynamic>>.from(
            fetchedData[AppKeys.fetchedAgencies] ?? []);
    final List<Map<String, dynamic>> fetchedClient =
        List<Map<String, dynamic>>.from(
            fetchedData[AppKeys.fetchedClients] ?? []);
    final List<Map<String, dynamic>> fetchedPriority =
        List<Map<String, dynamic>>.from(
            fetchedData[AppKeys.fetchedPriority] ?? []);
    final List<Map<String, dynamic>> fetchedStatus =
        List<Map<String, dynamic>>.from(
            fetchedData[AppKeys.fetchedStatus] ?? []);

    // Set isAgencyRequired to true only if agency is present
    if (taskAgency.isNotEmpty) {
      isAgencyRequired = true;
      notifyListeners();
    }

    // Find matching indices for salespersons or default to an empty list
    selectedIndices[IndexKeys.salespersonIndex] = taskSalesperson.isNotEmpty
        ? fetchedSalesperson
            .asMap()
            .entries
            .where((entry) => taskSalesperson
                .any((salesperson) => salesperson['id'] == entry.value["id"]))
            .map((entry) => entry.key)
            .toList()
        : [];

    // Find matching indices for designers or default to an empty list
    selectedIndices[IndexKeys.designerIndex] = taskDesigner.isNotEmpty
        ? fetchedDesigner
            .asMap()
            .entries
            .where((entry) => taskDesigner.any((designer) =>
                designer[SupabaseKeys.id] == entry.value[SupabaseKeys.id]))
            .map((entry) => entry.key)
            .toList()
        : [];

    // Find matching indices for agencies or default to an empty list
    selectedIndices[IndexKeys.agencyIndex] = taskAgency.isNotEmpty
        ? fetchedAgency
            .asMap()
            .entries
            .where((entry) => taskAgency.any((agency) =>
                agency[SupabaseKeys.id] == entry.value[SupabaseKeys.id]))
            .map((entry) => entry.key)
            .toList()
        : [];

    // Find matching index for client or default to 0
    selectedIndices[IndexKeys.clientIndex] = taskClients.isNotEmpty
        ? fetchedClient.indexWhere((client) =>
            client[SupabaseKeys.id] == taskClients[0][SupabaseKeys.id])
        : 0;

    // Find matching index for priority or default to 0
    selectedIndices[IndexKeys.priorityIndex] = taskPriority != null
        ? fetchedPriority
            .indexWhere((map) => map[AppKeys.nameKey] == taskPriority)
        : 0;

    // Find matching index for status or default to 0
    selectedIndices[IndexKeys.statusIndex] = taskStatus != null
        ? fetchedStatus.indexWhere((map) => map[AppKeys.nameKey] == taskStatus)
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

    fetchedData[AppKeys.fetchedUnopenedTasks] =
        (data[AppKeys.fetchedUnopenedTasks] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ??
            [];

    fetchedData[AppKeys.fetchedPendingTasks] =
        (data[AppKeys.fetchedPendingTasks] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ??
            [];

    fetchedData[AppKeys.fetchedSharedTasks] =
        (data[AppKeys.fetchedSharedTasks] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ??
            [];

    fetchedData[AppKeys.fetchedQuotationTasks] =
        (data[AppKeys.fetchedQuotationTasks] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ??
            [];

    fetchedData[AppKeys.fetchedPaymentTasks] =
        (data[AppKeys.fetchedPaymentTasks] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ??
            [];

    fetchedData[AppKeys.fetchedCompleteTasks] =
        (data[AppKeys.fetchedCompleteTasks] as List<dynamic>?)
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
