import 'package:flutter/material.dart';

import '../../data/models/designer.dart';
import '../../domain/use_cases/designer_use_cases.dart';

class DesignerProvider extends ChangeNotifier {
  final GetDesignersUseCase _getDesignersUseCase;

  List<Designer> _designers = [];
  List<Designer> get designers => _designers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DesignerProvider(this._getDesignersUseCase);

  Future<void> fetchDesigners() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getDesignersUseCase.execute();

    if (response.success && response.data != null) {
      _designers = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
