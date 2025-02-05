import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../constants/app_consts.dart';
import '../constants/dummy_data.dart';
import '../constants/enums.dart';
import '../constants/app_keys.dart';
import '../controllers/supabase_controller.dart';
import '../models/user.dart';

class TaskProvider extends ChangeNotifier {
  static final TaskProvider _instance = TaskProvider._privateConstructor();

  TaskProvider._privateConstructor();

  static TaskProvider get instance => _instance;

  final Logger logger = Logger();

  int _currentTaskPage = 0;
  int _currentTodayTaskPage = 0;

  int get currentTaskPage => _currentTaskPage;
  int get currentTodayTaskPage => _currentTodayTaskPage;

  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();

  Map<String, List<Map<String, dynamic>>> fetchedData =
      DummyData.dummyFetchedDataProvider;

  Map<String, dynamic> fetchedTaskData = DummyData.dummyTaskData;
  Map<String, dynamic> fetchedOverallData = {};

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

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

  Map<String, dynamic> fetchedDataCount = {};

  void updateCurrentTaskPage(int page) {
    _currentTaskPage = page;
    notifyListeners();
  }

  void updateCurrentTodayTaskPage(int page) {
    _currentTodayTaskPage = page;
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  void initializeControllers() {
    nameController.text = fetchedTaskData['name'] ?? '';
    remarkController.text = fetchedTaskData['remarks'] ?? '';
  }

  /// gets overall counts
  Future<void> getOverallCounts() async {
    final data = await SupabaseController.instance.getOverallCounts();
    fetchedDataCount = data;
    notifyListeners();
  }

  /// set current user
  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  /// get tabs
  List<Map<String, dynamic>> getTabsForRole(
      UserRole role, Map<String, List<dynamic>> fetchedData) {
    final int unopenedCount =
        fetchedData[AppKeys.fetchedUnopenedTasks]?.length ?? 0;
    final int pendingCount =
        fetchedData[AppKeys.fetchedPendingTasks]?.length ?? 0;
    final int sharedCount =
        fetchedData[AppKeys.fetchedSharedTasks]?.length ?? 0;
    final int quotationCount =
        fetchedData[AppKeys.fetchedQuotationTasks]?.length ?? 0;
    final int paymentCount =
        fetchedData[AppKeys.fetchedPaymentTasks]?.length ?? 0;
    final int completeCount =
        fetchedData[AppKeys.fetchedCompleteTasks]?.length ?? 0;

    final List<Map<String, dynamic>> allTabs = [
      {
        'label': 'Un-Opened',
        'key': AppKeys.fetchedUnopenedTasks,
        'count': unopenedCount,
        'color': AppColors.lightBlue,
      },
      {
        'label': 'Pending',
        'key': AppKeys.fetchedPendingTasks,
        'count': pendingCount,
        'color': AppColors.pink,
      },
      {
        'label': 'Shared',
        'key': AppKeys.fetchedSharedTasks,
        'count': sharedCount,
        'color': AppColors.orange,
      },
      {
        'label': 'Quotation',
        'key': AppKeys.fetchedQuotationTasks,
        'count': quotationCount,
        'color': AppColors.pink,
      },
      {
        'label': 'Payment',
        'key': AppKeys.fetchedPaymentTasks,
        'count': paymentCount,
        'color': AppColors.purple,
      },
      {
        'label': 'Complete',
        'key': AppKeys.fetchedCompleteTasks,
        'count': completeCount,
        'color': AppColors.green,
      },
    ];

    List<Map<String, dynamic>> filteredTabs =
        allTabs.where((tab) => tab['count'] > 0).toList();

    switch (role) {
      case UserRole.salesperson:
        return filteredTabs
            .where((tab) => tab['label'] != 'Un-Opened')
            .toList();
      case UserRole.agency:
        return filteredTabs.where((tab) => tab['label'] != 'Shared').toList();
      default:
        return filteredTabs;
    }
  }

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
          selectedIndices[IndexKeys.statusIndex]][AppKeys.name],
      dueDate: dueDate,
      priority: fetchedData[AppKeys.fetchedPriority]![
          selectedIndices[IndexKeys.priorityIndex]][AppKeys.name],
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
          selectedIndices[IndexKeys.statusIndex]][AppKeys.name],
      dueDate: dueDate,
      priority: fetchedData[AppKeys.fetchedPriority]![
          selectedIndices[IndexKeys.priorityIndex]][AppKeys.name],
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
            .where((entry) => taskSalesperson.any((salesperson) =>
                salesperson[SupabaseKeys.id] == entry.value[SupabaseKeys.id]))
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
        ? fetchedPriority.indexWhere((map) => map[AppKeys.name] == taskPriority)
        : 0;

    // Find matching index for status or default to 0
    selectedIndices[IndexKeys.statusIndex] = taskStatus != null
        ? fetchedStatus.indexWhere((map) => map[AppKeys.name] == taskStatus)
        : 0;
  }

  Future<void> getTaskByDealNo(String dealNo) async {
    // final data = await SupabaseController.instance.getTaskById(dealNo);
    final data = DummyData.dummyTaskData;
    fetchedTaskData = data;
    logger.d(data);
    initializeControllers();

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

  List<Map<String, dynamic>> getUserDetails(List<String> userIds) {
    final List<Map<String, dynamic>> userDetails = [];

    for (var userId in userIds) {
      // Check which list contains the userId
      final salesperson = fetchedData[AppKeys.fetchedSalespersons]!.firstWhere(
          (user) => user[SupabaseKeys.id] == userId,
          orElse: () => {});
      if (salesperson.isNotEmpty) {
        userDetails.add({
          UserDetails.profileBgColor: salesperson[UserDetails.profileBgColor],
          UserDetails.name: salesperson[UserDetails.name],
        });
        continue;
      }

      final agency = fetchedData[AppKeys.fetchedAgencies]!.firstWhere(
          (user) => user[SupabaseKeys.id] == userId,
          orElse: () => {});
      if (agency.isNotEmpty) {
        userDetails.add({
          UserDetails.profileBgColor: agency[UserDetails.profileBgColor],
          UserDetails.name: agency[UserDetails.name],
        });
        continue;
      }

      final designer = fetchedData[AppKeys.fetchedDesigners]!.firstWhere(
          (user) => user[SupabaseKeys.id] == userId,
          orElse: () => {});
      if (designer.isNotEmpty) {
        userDetails.add({
          UserDetails.profileBgColor: designer[UserDetails.profileBgColor],
          UserDetails.name: designer[UserDetails.name],
        });
        continue;
      }
    }

    return userDetails;
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
