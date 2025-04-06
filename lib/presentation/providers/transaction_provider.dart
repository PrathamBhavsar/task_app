import 'package:flutter/material.dart';

import '../../data/models/chart_data.dart';

class TransactionProvider extends ChangeNotifier {
  Map<String, List<ChartData>> chartData = {};

  Future<void> fetchSalesOverviewData() async {}

  List<dynamic> employeeSales = [];

  Future<void> fetchEmployeeSalesList() async {}

  List<dynamic> productSales = [];

  Future<void> fetchProductSalesList() async {}

  Map<String, dynamic> totalMetrics = {};

  Future<void> fetchTotalMetricsList() async {}

  bool _isCashFocus = true;
  bool get isCashFocus => _isCashFocus;

  void toggleCashFocus() {
    _isCashFocus = !_isCashFocus;
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

  int _services = 1;
  int get services => _services;

  void addService() {
    _services++;
    notifyListeners();
  }

  void removeService() {
    if (_services == 1) return;
    _services--;
    notifyListeners();
  }

  int _products = 1;
  int get products => _products;

  void addProduct() {
    _products++;
    notifyListeners();
  }

  void removeProduct() {
    if (_products == 1) return;
    _products--;
    notifyListeners();
  }

  String _selectedMode = 'Cash';

  String get selectedPaymentMode => _selectedMode;

  void setPaymentMode(String gender) {
    _selectedMode = gender;
    notifyListeners();
  }
}
