import 'package:flutter/material.dart';

import '../../data/repositories/task_repository.dart';
import '../../data/states/get_tasks_states.dart';
import '../../domain/entities/task.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository;

  // String _currentCustomer = customers.first.name;
  TaskProvider(this._repository);

  List<Task> _tasks = [];
  GetTasksState _getTasksState = None();

  GetTasksState get getTasksState => _getTasksState;

  void _setGetTasksState(GetTasksState state) {
    _getTasksState = state;
    notifyListeners();
  }

  Future<void> fetchAllTasks() async {
    _setGetTasksState(Fetching());
    final result = await _repository.getAll();

    result.fold(
      (err) {
        _setGetTasksState(Failed(err));
        _tasks = [];
      },
      (taskList) {
        _setGetTasksState(Fetched(taskList));
        _tasks = taskList;
      },
    );
  }

  String get currentCustomer => '_currentCustomer';

  void setCustomer(String value) {
    // _currentCustomer = value;
    // notifyListeners();
  }

  void resetFields() {
    // _currentCustomer = customers.first.name;
    // _currentAgency = agencies.first.name;
    _currentPriority = 'Low';
    _currentStatus = 'Pending';
    _taskDetailIndex = 0;
  }

  // String _currentAgency = agencies.first.name;

  String get currentAgency => '_currentAgency';

  void setAgency(String value) {
    // print(value);
    // _currentAgency = value;
    // notifyListeners();
  }

  String _currentPriority = 'Low';

  String get currentPriority => _currentPriority;

  void setPriority(String value) {
    _currentPriority = value;
    notifyListeners();
    _currentPriority = 'Low';
  }

  String _currentStatus = 'Pending';

  String get currentStatus => _currentStatus;

  void setStatus(String value) {
    _currentStatus = value;
    notifyListeners();
    _currentStatus = 'Pending';
  }

  int _taskDetailIndex = 0;

  bool get isProductSelected => _taskDetailIndex == 1;

  bool get isMeasurementSent => _taskDetailIndex == 2;

  void increaseTaskDetailIndex() {
    _taskDetailIndex++;
    notifyListeners();
  }

  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  bool get isFirst => _tabIndex == 0;

  bool get isThird => _tabIndex == 2;

  void updateSubTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }
}
