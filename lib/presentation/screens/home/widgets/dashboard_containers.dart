import 'package:flutter/material.dart';

import '../../../../utils/extensions/padding.dart';
import '../../../widgets/data_container.dart';

class DashboardContainers extends StatelessWidget {
  const DashboardContainers({required this.list, super.key});

  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: list[0]['title'],
              subtitle: list[0]['subtitle'],
              data: list[0]['data'],
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: list[1]['title'],
              subtitle: list[1]['subtitle'],
              data: list[1]['data'],
            ),
          ),
        ],
      ),
      10.hGap,
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: list[2]['title'],
              subtitle: list[2]['subtitle'],
              data: list[2]['data'],
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: list[3]['title'],
              subtitle: list[3]['subtitle'],
              data: list[3]['data'],
            ),
          ),
        ],
      ),
    ],
  );
}
