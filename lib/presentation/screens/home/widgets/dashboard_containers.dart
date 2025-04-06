import 'package:flutter/material.dart';

import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/data_container.dart';

class DashboardContainers extends StatelessWidget {
  const DashboardContainers({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: DummyData.ownerDashboard[0]['title'],
              subtitle: DummyData.ownerDashboard[0]['subtitle'],
              data: data['total_costs'].toString(),
              padding: EdgeInsets.zero,
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: DummyData.ownerDashboard[1]['title'],
              subtitle: DummyData.ownerDashboard[1]['subtitle'],
              data: data['total_appointments'].toString(),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      10.hGap,
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: DummyData.ownerDashboard[2]['title'],
              subtitle: DummyData.ownerDashboard[2]['subtitle'],
              data: data['total_product_sales'].toString(),
              padding: EdgeInsets.zero,
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: DummyData.ownerDashboard[3]['title'],
              subtitle: DummyData.ownerDashboard[3]['subtitle'],
              data: data['total_employees'].toString(),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    ],
  );
}
