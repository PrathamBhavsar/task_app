import 'package:flutter/material.dart';

import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/data_container.dart';

class DashboardContainers extends StatelessWidget {
  const DashboardContainers({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: DummyData.adminDashboard[0]['title'],
              subtitle: DummyData.adminDashboard[0]['subtitle'],
              data: DummyData.adminDashboard[0]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: DummyData.adminDashboard[1]['title'],
              subtitle: DummyData.adminDashboard[1]['subtitle'],
              data: DummyData.adminDashboard[1]['data'],
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
              title: DummyData.adminDashboard[2]['title'],
              subtitle: DummyData.adminDashboard[2]['subtitle'],
              data: DummyData.adminDashboard[2]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: DummyData.adminDashboard[3]['title'],
              subtitle: DummyData.adminDashboard[3]['subtitle'],
              data: DummyData.adminDashboard[3]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    ],
  );
}