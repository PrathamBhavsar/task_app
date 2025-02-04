import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../helpers/number_formatter.dart';
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...List.generate(provider.costs.length, (index) {
              final cost = provider.costs[index];

              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: provider.nameControllers[index],
                      style: txtStyle,
                      decoration: const InputDecoration(
                        labelText: "Cost name",
                        labelStyle: labelStyle,
                      ),
                      onChanged: (value) =>
                          provider.updateCost(index, name: value),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: provider.rateControllers[index],
                      style: txtStyle,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Rate",
                        labelStyle: labelStyle,
                      ),
                      onChanged: (value) => provider.updateCost(index,
                          rate: double.tryParse(value) ?? 0),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: provider.areaControllers[index],
                      style: txtStyle,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Area",
                        labelStyle: labelStyle,
                      ),
                      onChanged: (value) => provider.updateCost(index,
                          area: double.tryParse(value) ?? 0),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "₹ ${NumberFormatter.format(cost.total)}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: provider.addCost,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Add Cost",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton.icon(
                  onPressed: provider.removeCost,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.redAccent,
                  ),
                  label: const Text(
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
                "Total: ₹ ${NumberFormatter.format(provider.totalAdditionalCost)}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            AppPaddings.gapH(10),
          ],
        ),
      );

  static const TextStyle labelStyle = TextStyle();
  static const TextStyle txtStyle = TextStyle(
    fontWeight: FontWeight.w600,
  );
}
