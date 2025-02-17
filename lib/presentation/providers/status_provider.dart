import 'package:flutter/material.dart';

import '../../data/models/status.dart';
import '../../domain/use_cases/status_use_cases.dart';

class StatusProvider extends ChangeNotifier {
  final GetStatusesUseCase _getStatusesUseCase;

  List<Status> _statuses = [];
  List<Status> get statuses => _statuses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StatusProvider(this._getStatusesUseCase);

  Future<void> fetchStatuses() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getStatusesUseCase.execute();

    if (response.success && response.data != null) {
      _statuses = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
