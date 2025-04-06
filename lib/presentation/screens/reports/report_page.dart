import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/appointment.dart';
import '../../../../data/models/employee.dart';
import '../../../../data/models/product.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../data/models/services.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/chart_widget.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/tab_header.dart';
import '../home/widgets/dashboard_containers.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Text('Reports & Analytics', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(
      child: Consumer<TransactionProvider>(
        builder:
            (
              BuildContext context,
              TransactionProvider provider,
              Widget? child,
            ) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Report Filters", style: AppTexts.titleTextStyle),
                5.hGap,
                Text(
                  "Customize your report view",
                  style: AppTexts.inputHintTextStyle,
                ),
                20.hGap,
                _buildDropdown('Date Range', DummyData.reportDateRanges),
                _buildDropdown('Employee', Employee.names),
                _buildDropdown('Service', Service.names),
                TabHeader(
                  provider: provider,
                  tabs: [
                    Tab(text: 'Sales Overview'),
                    Tab(text: 'Employee Performance'),
                    Tab(text: 'Service Analysis'),
                  ],
                ),
                BorderedContainer(child: _buildTabContent(provider)),
              ],
            ).padAll(AppPaddings.appPaddingInt),
      ),
    ),
  );

  Widget _buildDropdown(String title, List<String> list) => Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.headingTextStyle),
        10.hGap,
        CustomDropdownMenu(items: list, initialValue: list.first),
      ],
    ),
  );

  Widget _buildTabContent(TransactionProvider provider) {
    switch (provider.tabIndex) {
      case 1:
        return _buildEmployeeSales(provider);
      case 2:
        return _buildTopProducts(provider);
      default:
        return _buildSalesOverview(provider);
    }
  }

  Widget _buildSalesOverview(TransactionProvider provider) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Sales Overview", style: AppTexts.titleTextStyle),
      Text("Last 7 days", style: AppTexts.inputHintTextStyle),
      Divider(color: AppColors.accent).padSymmetric(vertical: 10.h),
      ChartWidget(
        cashData: provider.chartData,
        cashFocus: provider.isCashFocus,
      ),
      20.hGap,
      DashboardContainers(data: provider.totalMetrics),
    ],
  );

  Widget _buildEmployeeSales(TransactionProvider provider) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Employee Sales", style: AppTexts.titleTextStyle),
      Text("Sales by employee", style: AppTexts.inputHintTextStyle),
      Divider(color: AppColors.accent).padSymmetric(vertical: 10.h),
      ...List.generate(
        provider.employeeSales.length,
        (index) =>
            provider.employeeSales.isEmpty
                ? Center(child: CircularProgressIndicator(color: Colors.black))
                : Padding(
                  padding:
                      index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.employeeSales[index]['employee_name'],
                                style: AppTexts.headingTextStyle,
                              ),
                              Text(
                                "${provider.employeeSales[index]['total_quantity'].toString()} units sold",
                                style: AppTexts.inputHintTextStyle,
                              ),
                            ],
                          ),
                          Text(
                            "\$${provider.employeeSales[index]['total_amount'].toString()}",
                            style: AppTexts.headingTextStyle,
                          ),
                        ],
                      ),
                      10.hGap,
                    ],
                  ),
                ),
      ),
    ],
  );

  Widget _buildTopProducts(TransactionProvider provider) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Service Analysis", style: AppTexts.titleTextStyle),
      Text("Performance by service type", style: AppTexts.inputHintTextStyle),
      Divider(color: AppColors.accent).padSymmetric(vertical: 10.h),
      ChartWidget(
        cashData: provider.chartData,
        cashFocus: provider.isCashFocus,
      ),
    ],
  );
}
