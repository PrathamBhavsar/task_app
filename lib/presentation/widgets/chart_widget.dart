import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/constants/app_constants.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.cashData,
    required this.cashFocus,
  });

  final Map<String, List<ChartData>> cashData;
  final bool cashFocus;

  @override
  Widget build(BuildContext context) =>
      cashData.isEmpty
          ? Center(child: CircularProgressIndicator(color: Colors.black))
          : SfCartesianChart(
            legend: Legend(isVisible: true, alignment: ChartAlignment.far),
            primaryXAxis: CategoryAxis(),
            series:
                cashData.entries
                    .map(
                      (entry) => LineSeries<ChartData, String>(
                        name: entry.key,
                        isVisibleInLegend: true,
                        color:
                            entry.key == (cashFocus ? "cash" : "card")
                                ? Colors.black
                                : AppColors.accent,
                        dataSource: entry.value,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        markerSettings: const MarkerSettings(isVisible: true),
                      ),
                    )
                    .toList(),
          );
}

Color getColor(String key) {
  Map<String, Color> colorMap = {
    'cash': Colors.black,
    'card': AppColors.accent,
  };
  return colorMap[key] ?? Colors.black;
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;

  final double y;
}
