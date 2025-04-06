import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/chart_data.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Product Selection', 35),
      ChartData('Measurement', 20),
      ChartData('Quote', 15),
      ChartData('Sales Order', 18),
      ChartData('Delivery', 12),
    ];
    return SfCircularChart(
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          animationDuration: 0,
          dataSource: chartData,
          pointColorMapper: (ChartData data, _) => data.color,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
      ],
    );
  }
}


