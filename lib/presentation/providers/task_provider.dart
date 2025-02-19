import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../data/models/user.dart';
import '../../domain/use_cases/task_use_cases.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase _getTasksUseCase;

  late Task _selectedTask;
  Task get selectedTask => _selectedTask;

  List<Task> _dueTodayTasks = [];
  List<Task> get dueTodayTasks => _dueTodayTasks;

  List<Task> _pastDueTasks = [];
  List<Task> get pastDueTasks => _pastDueTasks;

  List<Task> _allTasks = [];
  List<Task> get allTasks => _allTasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskProvider(this._getTasksUseCase);

  int _selectedListIndex = 0;
  int get selectedListIndex => _selectedListIndex;

  /// Updates task list index
  void updateSelectedListIndex(int index) {
    _selectedListIndex = index;
    notifyListeners();
  }

  int _todayTaskPageIndex = 0;
  int get currentTodayTaskPage => _todayTaskPageIndex;

  /// Updates current task page index
  void updateTodayTaskPageIndex(int page) {
    _todayTaskPageIndex = page;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getTasksUseCase.execute(
      // GetTasksDTO(id: AuthenticationProvider.instance.currentUser!.id),
      GetTasksDTO(id: 'FA14A924AC8106FD9673AF8F99653DD3'),
    );

    if (response.success && response.data != null) {
      _allTasks = response.data!;
      filterTasksByDueDate();
      fetchAllUsersForTasks();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<DashboardStatus> _dashboardDetails = [];
  List<DashboardStatus> get dashboardDetails => _dashboardDetails;

  Future<void> fetchDashboardDetails() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getTasksUseCase.getDashboardDetails();

    if (response.success && response.data != null) {
      _dashboardDetails = response.data!;
    }

    await fetchTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTask(String id) async {
    _isLoading = true;
    notifyListeners();

    final response = await _getTasksUseCase.getTask(id);

    if (response.success && response.data != null) {
      _selectedTask = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterTasksByDueDate() {
    final today = DateTime.now();
    final todayString = DateFormat('yyyy-MM-dd').format(today);

    _dueTodayTasks = _allTasks.where((task) {
      final taskDueDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(task.dueDate));
      return taskDueDate == todayString;
    }).toList();

    _pastDueTasks = _allTasks.where((task) {
      final taskDueDate = DateTime.parse(task.dueDate);
      return taskDueDate.isAfter(today);
    }).toList();
  }

  /// Groups tasks by their category
  Map<String, List<Task>> get categorizedTasks {
    Map<String, List<Task>> groupedTasks = {};

    for (var task in _allTasks) {
      String category = task.status.split(':').first.trim();

      if (!groupedTasks.containsKey(category)) {
        groupedTasks[category] = [];
      }
      groupedTasks[category]!.add(task);
    }

    return groupedTasks;
  }

  Map<String, List<User>> _taskUsers = {};
  Map<String, List<User>> get taskUsers => _taskUsers;

  Future<void> fetchAllUsersForTasks() async {
    if (_allTasks.isEmpty) return;

    List<String> taskIds = _allTasks.map((task) => task.id).toList();
    final response = await _getTasksUseCase.getUsersForTasks(taskIds);

    if (response.success && response.data != null) {
      _taskUsers = response.data!;
    }

    notifyListeners();
  }
}
