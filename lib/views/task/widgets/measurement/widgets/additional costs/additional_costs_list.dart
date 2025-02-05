import 'package:flutter/material.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../helpers/number_helper.dart';
import '../../../../../../providers/measurement_provider.dart';
import '../../../../../../widgets/action_button.dart';
import 'widgets/cost_tile.dart';

class AdditionalCostsList extends StatelessWidget {
  final MeasurementProvider provider;
  const AdditionalCostsList({required this.provider});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (provider.costs.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Additional Costs", style: AppTexts.tileTitle1),
                const SizedBox(height: 10),
                ...List.generate(provider.costs.length,
                    (index) => CostItem(provider: provider, index: index)),
                _CostControls(provider: provider),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      "Total: ₹ ${NumberHelper.format(provider.totalAdditionalCost)}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          if (provider.costs.isEmpty)
            ActionBtn(
              btnTxt: 'Add Additional Costs',
              onPress: provider.addCost,
              fontColor: AppColors.primary,
              backgroundColor: Colors.white,
            ),
        ],
      );
}

class _CostControls extends StatelessWidget {
  final MeasurementProvider provider;
  const _CostControls({required this.provider});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: provider.addCost,
              icon: const Icon(Icons.add),
              label: const Text("Add Cost")),
          TextButton.icon(
              onPressed: provider.removeCost,
              icon: const Icon(Icons.close_rounded, color: Colors.redAccent),
              label: const Text("Remove Cost",
                  style: TextStyle(color: Colors.redAccent))),
        ],
      );
}
