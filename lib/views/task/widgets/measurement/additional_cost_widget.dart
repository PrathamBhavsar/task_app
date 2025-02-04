import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../providers/measurement_provider.dart';

class AdditionalCostsWidget extends StatelessWidget {
  const AdditionalCostsWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<MeasurementProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Additional Costs",
              style: AppTexts.tileTitle1,
            ),
            AppPaddings.gapH(10),
            ...List.generate(provider.costs.length, (index) {
              final cost = provider.costs[index];
              if (provider.costs.isEmpty) return Text("No costs added");
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      initialValue: cost.name,
                      style: txtStyle,
                      decoration: const InputDecoration(
                        labelText: "Cost name",
                        labelStyle: labelStyle,
                      ),
                      onChanged: (value) =>
                          provider.updateCost(index, name: value),
                    ),
                  ),
                  AppPaddings.gapW(5),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      // initialValue: cost.rate.toString(),
                      style: txtStyle,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Rate", labelStyle: labelStyle),
                      onChanged: (value) => provider.updateCost(index,
                          rate: double.tryParse(value) ?? 0),
                    ),
                  ),
                  AppPaddings.gapW(5),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      // initialValue: cost.area.toString(),
                      style: txtStyle,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Area", labelStyle: labelStyle),
                      onChanged: (value) => provider.updateCost(index,
                          area: double.tryParse(value) ?? 0),
                    ),
                  ),
                  AppPaddings.gapW(5),
                  Text(
                    "\₹ ${cost.total.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.close_rounded,
                  //     color: Colors.red,
                  //     size: 16,
                  //   ),
                  //   onPressed: () => provider.removeCost(index),
                  // ),
                ],
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: provider.addCost,
                  icon: Icon(Icons.add),
                  label: Text(
                    "Add Cost",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton.icon(
                  onPressed: provider.removeCost,
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.redAccent,
                  ),
                  label: Text(
                    "Remove Cost",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: \₹ ${provider.totalAdditionalCost.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

  static const TextStyle labelStyle = TextStyle();
  static const TextStyle txtStyle = TextStyle(
    fontWeight: FontWeight.w600,
  );
}
