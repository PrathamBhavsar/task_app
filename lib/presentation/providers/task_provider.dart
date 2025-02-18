import 'package:flutter/material.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../domain/use_cases/task_use_cases.dart';
import 'auth_provider.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase _getTasksUseCase;

  List<DashboardStatus> _dashboardDetails = [];
  List<DashboardStatus> get dashboardDetails => _dashboardDetails;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskProvider(this._getTasksUseCase);

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

    final response = await _getTasksUseCase.executeDashboard();

    if (response.success && response.data != null) {
      _dashboardDetails = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
