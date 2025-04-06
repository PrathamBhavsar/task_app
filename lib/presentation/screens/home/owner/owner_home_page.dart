import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/appointment.dart';
import '../../../../data/models/employee.dart';
import '../../../../data/models/product.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../providers/transaction_provider.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/chart_widget.dart';
import '../../../widgets/tab_header.dart';
import '../widgets/dashboard_containers.dart';

class OwnerHomePage extends StatelessWidget {
  const OwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TransactionProvider>(
    builder:
        (BuildContext context, TransactionProvider provider, Widget? child) =>
            Column(
              children: [
                DashboardContainers(data: provider.totalMetrics),
                TabHeader(
                  provider: provider,
                  tabs: [
                    Tab(text: 'Sales Overview'),
                    Tab(text: 'Employee Sales'),
                    Tab(text: 'Top Products'),
                  ],
                ),
                BorderedContainer(child: _buildTabContent(provider)),
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
      Text(
        "Your salon's performance over time",
        style: AppTexts.inputHintTextStyle,
      ),
      Divider(color: AppColors.accent).padSymmetric(vertical: 10.h),
      ChartWidget(
        cashData: provider.chartData,
        cashFocus: provider.isCashFocus,
      ),
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
      Text("Top Products", style: AppTexts.titleTextStyle),
      Text("Best-selling products", style: AppTexts.inputHintTextStyle),
      Divider(color: AppColors.accent).padSymmetric(vertical: 10.h),
      ...List.generate(
        provider.productSales.length,
        (index) =>
            provider.productSales.isEmpty
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
                                provider.productSales[index]['product_name'],
                                style: AppTexts.headingTextStyle,
                              ),
                              Text(
                                "${provider.productSales[index]['total_quantity'].toString()} units sold",
                                style: AppTexts.inputHintTextStyle,
                              ),
                            ],
                          ),
                          Text(
                            "\$${provider.productSales[index]['total_amount'].toString()}",
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
}
