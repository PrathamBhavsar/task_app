import 'package:flutter/material.dart';

import '../../../../../../../constants/app_colors.dart';
import '../../../../../../../helpers/number_helper.dart';
import '../../../../../../../providers/measurement_provider.dart';
import '../../../../../../../widgets/custom_text_field.dart';

class CostItem extends StatelessWidget {
  final MeasurementProvider provider;
  final int index;
  const CostItem({super.key, required this.provider, required this.index});

  @override
  Widget build(BuildContext context) {
    final cost = provider.costs[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: AppBorders.radius, border: Border.all(width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: provider.dropdownItems.contains(cost.name)
                    ? cost.name
                    : null,
                isExpanded: true,
                items: provider.dropdownItems
                    .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text(item, style: AppTexts.tileTitle2)))
                    .toList(),
                onChanged: (value) => provider.updateCost(index, name: value),
                decoration: const InputDecoration(labelText: 'Select Cost'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          controller: provider.rateControllers[index],
                          labelTxt: "Rate",
                          onChangedFunc: (value) => provider.updateCost(index,
                              rate: double.tryParse(value) ?? 0))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: CustomTextField(
                          controller: provider.qtyControllers[index],
                          labelTxt: "Quantity",
                          onChangedFunc: (value) => provider.updateCost(index,
                              qty: double.tryParse(value) ?? 0))),
                  const SizedBox(width: 10),
                  Text("₹ ${NumberHelper.format(cost.total)}",
                      style: AppTexts.inputTextStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
