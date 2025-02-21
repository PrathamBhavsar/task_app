import 'package:flutter/material.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../core/dto/task_dtos.dart';
import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../data/models/taskWithDetails.dart';
import '../../data/models/taskWithUser.dart';
import '../../domain/use_cases/task_use_cases.dart';
import '../../utils/constants/app_keys.dart';
import 'home_provider.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase _getTasksUseCase;
  final HomeProvider _homeProvider;

  Task? _selectedTask;
  Task? get selectedTask => _selectedTask;

  List<TaskWithUsers> _dueTodayTasks = [];
  List<TaskWithUsers> get dueTodayTasks => _dueTodayTasks;

  List<TaskWithUsers> _pastDueTasks = [];
  List<TaskWithUsers> get pastDueTasks => _pastDueTasks;

  List<TaskWithUsers> _allTasksOverall = [];
  List<TaskWithUsers> get allTasksOverall => _allTasksOverall;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskProvider(this._getTasksUseCase, this._homeProvider);

  // Controllers initialized lazily
  late TextEditingController nameController;
  late TextEditingController remarkController;
  late TextEditingController addressController;
  late TextEditingController contactController;

  void initializeControllers() {
    nameController = TextEditingController(
        text: _selectedTaskWithDetails?.client.name ?? "");
    remarkController =
        TextEditingController(text: _selectedTaskWithDetails?.remarks ?? "");
    addressController = TextEditingController(
        text: _selectedTaskWithDetails?.client.address ?? "");
    contactController = TextEditingController(
        text: _selectedTaskWithDetails?.client.contactNo ?? "");
  }

  /// Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Set the due date
  DateTime dueDate = DateTime.now().add(Duration(days: 2));
  void setDueDate(DateTime newDueDate) {
    dueDate = newDueDate;
    notifyListeners();
  }

  /// Set the start date
  DateTime startDate = DateTime.now();
  void setStartDate(DateTime newStartDate) {
    startDate = newStartDate;
    notifyListeners();
  }

  /// Toggle agency requirement
  bool isAgencyRequired = false;
  void toggleAgencyRequired() {
    isAgencyRequired = !isAgencyRequired;
    notifyListeners();
  }

  int _selectedListIndex = 0;
  int get selectedListIndex => _selectedListIndex;

  void updateSelectedListIndex(int index) {
    _selectedListIndex = index;
    notifyListeners();
  }

  int _todayTaskPageIndex = 0;
  int get currentTodayTaskPage => _todayTaskPageIndex;

  void updateTodayTaskPageIndex(int page) {
    _todayTaskPageIndex = page;
    notifyListeners();
  }

  final Map<String, int> selectedIndices = {};

  void updateSelectedIndex(String field, dynamic index) {
    selectedIndices[field] = index;
    notifyListeners();
  }

  Future<void> fetchTasksOverall() async {
    _setLoading(true);

    final response = await _getTasksUseCase.fetchTasksOverall(
      GetTasksDTO(id: 'FA14A924AC8106FD9673AF8F99653DD3'),
    );

    if (response.success && response.data != null) {
      _allTasksOverall = response.data!;
      filterTasksByDueDate();
    }

    _setLoading(false);
  }

  Future<void> createTask() async {
    _setLoading(true);

    final response = await _getTasksUseCase.createTask(
      CreateTaskDTO(
        dealNo: 'dealNo',
        name: 'name',
        startDate: DateTime.now(),
        dueDate: DateTime.now(),
        priority: 'priority',
        createdBy: 'createdBy',
        remarks: 'remarks',
        status: 'status',
        clients: ['clients'],
        designers: ['designers'],
        agencies: ['agencies'],
        salespersons: ['salespersons'],
        attachments: [
          AttachmentDTO(url: 'url', name: 'name'),
        ],
      ),
    );

    _setLoading(false);
  }

  List<DashboardStatus> _dashboardDetails = [];
  List<DashboardStatus> get dashboardDetails => _dashboardDetails;

  Future<void> fetchDashboardDetails() async {
    _setLoading(true);

    final response = await _getTasksUseCase.getDashboardDetails();

    if (response.success && response.data != null) {
      _dashboardDetails = response.data!;
    }

    await fetchTasksOverall();
    _setLoading(false);
  }

  TaskWithDetails? _selectedTaskWithDetails;
  TaskWithDetails? get selectedTaskWithDetails => _selectedTaskWithDetails;

  Future<void> fetchTaskDetailsFromId(String taskId) async {
    _setLoading(true);

    final response = await _getTasksUseCase.getTaskDetailsFromId(taskId);
    if (response.success && response.data != null) {
      _selectedTaskWithDetails = response.data!;
    }

    _setLoading(false);
  }

  Future<void> fetchTask(String id) async {
    _setLoading(true);

    final response = await _getTasksUseCase.getTask(id);

    if (response.success && response.data != null) {
      _selectedTask = response.data!;
      _setSelectedIndices();
    }

    _setLoading(false);
  }

  /// Helper method to update selected indices dynamically
  void _setSelectedIndices() {
    final lookupTable = {
      IndexKeys.salespersonIndex: _homeProvider.users
          .indexWhere((user) => user.id == _selectedTask?.salespersonId),
      IndexKeys.designerIndex: _homeProvider.designers
          .indexWhere((designer) => designer.id == _selectedTask?.designerId),
      IndexKeys.agencyIndex: _homeProvider.users
          .indexWhere((user) => user.id == _selectedTask?.agencyId),
      IndexKeys.clientIndex: _homeProvider.clients
          .indexWhere((client) => client.id == _selectedTask?.clientId),
      IndexKeys.statusIndex: _homeProvider.statuses
          .indexWhere((status) => status.name == _selectedTask?.status),
      IndexKeys.priorityIndex: _homeProvider.priorities
          .indexWhere((priority) => priority.name == _selectedTask?.priority),
    };

    lookupTable.forEach((key, value) {
      selectedIndices[key] = (value >= 0) ? value : 0;
    });

    notifyListeners();
  }

  void filterTasksByDueDate() {
    final today = DateTime.now();

    _dueTodayTasks = _allTasksOverall
        .where((task) => DateTime.parse(task.dueDate).isAtSameMomentAs(today))
        .toList();

    _pastDueTasks = _allTasksOverall
        .where((task) => DateTime.parse(task.dueDate).isAfter(today))
        .toList();
  }

  /// Groups tasks by their category
  Map<String, List<TaskWithUsers>> get categorizedTasks {
    Map<String, List<TaskWithUsers>> groupedTasks = {};

    for (var task in _allTasksOverall) {
      String category = task.statusName.split(':').first.trim();

      if (!groupedTasks.containsKey(category)) {
        groupedTasks[category] = [];
      }
      groupedTasks[category]!.add(task);
    }

    return groupedTasks;
  }
}
