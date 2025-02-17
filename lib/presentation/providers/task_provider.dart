import 'package:flutter/material.dart';

import '../../data/models/task.dart';
import '../../domain/use_cases/task_use_cases.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase _getTasksUseCase;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskProvider(this._getTasksUseCase);

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getTasksUseCase.execute();

    if (response.success && response.data != null) {
      _tasks = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
