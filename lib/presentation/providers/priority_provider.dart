import 'package:flutter/material.dart';

import '../../data/models/priority.dart';
import '../../domain/use_cases/priority_use_cases.dart';

class PriorityProvider extends ChangeNotifier {
  final GetPrioritiesUseCase _getPrioritiesUseCase;

  List<Priority> _priorities = [];
  List<Priority> get priorities => _priorities;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PriorityProvider(this._getPrioritiesUseCase);

  Future<void> fetchPriorities() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getPrioritiesUseCase.execute();

    if (response.success && response.data != null) {
      _priorities = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
