import 'package:flutter/material.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../domain/use_cases/task_use_cases.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase _getTasksUseCase;

  List<DashboardStatus> _dashboardDetails = [];
  List<DashboardStatus> get dashboardDetails => _dashboardDetails;

  late Task _selectedTask;
  Task get selectedTask => _selectedTask;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskProvider(this._getTasksUseCase);

  int _currentTaskPage = 0;
  int get currentTaskPage => _currentTaskPage;

  void updateCurrentTaskPage(int page) {
    _currentTaskPage = page;
    notifyListeners();
  }

  int _currentTodayTaskPage = 0;
  int get currentTodayTaskPage => _currentTodayTaskPage;

  void updateCurrentTodayTaskPage(int page) {
    _currentTodayTaskPage = page;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getTasksUseCase.execute(
      // GetTasksDTO(id: AuthenticationProvider.instance.currentUser!.id),
      GetTasksDTO(id: '31633932636230632D663066312D3437'),
    );

    if (response.success && response.data != null) {
      _tasks = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDashboardDetails() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getTasksUseCase.getDashboardDetails();

    if (response.success && response.data != null) {
      _dashboardDetails = response.data!;
      print(_dashboardDetails);
    }

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
}
