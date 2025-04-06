import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/chart_data.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) => SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    series: <CartesianSeries>[
      LineSeries<ChartData, String>(
        color: Colors.black,
        initialIsVisible: true,
        dataSource: [
          ChartData('Jan', 15),
          ChartData('Feb', 25),
          ChartData('Mar', 30),
          ChartData('Apr', 40),
          ChartData('May', 32),
          ChartData('Jun', 40),
          ChartData('Jul', 45),
        ],
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
      ),
    ],
  );
}