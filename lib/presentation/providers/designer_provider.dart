import 'package:flutter/material.dart';

import '../../core/dto/designer_dto.dart';
import '../../core/dto/user_dto.dart';
import '../../data/models/designer.dart';
import '../../data/models/user.dart';
import '../../domain/use_cases/designer_use_cases.dart';
import '../../domain/use_cases/user_use_cases.dart';

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

    DesignerDTO requestDTO = DesignerDTO(
        action: 'create',
        code: '',
        name: '',
        firmName: '',
        address: '',
        contactNo: '',
        profileBgColor: '');
    final response = await _getDesignersUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _designers = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
