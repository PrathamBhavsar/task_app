import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../helpers/number_formatter.dart';
import '../../../../providers/measurement_provider.dart';
import '../../../../widgets/custom_text_feild.dart';

class AdditionalCostsWidget extends StatelessWidget {
  const AdditionalCostsWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<MeasurementProvider>(
        builder: (context, provider, child) {
          List<String> dropdownItems = [
            'Stitching - Full',
            'Stitching - Half',
            'Steaming - Full',
            'Steaming - Half',
            'Fitting'
          ];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Additional Costs", style: AppTexts.tileTitle1),
              AppPaddings.gapH(10),
              ...List.generate(provider.costs.length, (index) {
                final cost = provider.costs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppBorders.radius,
                      border: Border.all(width: 1),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: dropdownItems.contains(cost.name)
                                ? cost.name
                                : null,
                            isExpanded:
                                true, // Ensures the dropdown takes full width
                            items: dropdownItems
                                .map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: AppTexts.tileTitle2,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.updateCost(index, name: value);
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              prefixIconColor: AppColors.primary,
                              fillColor: AppColors.textFieldBg,
                              filled: true,
                              labelText: 'Select Cost',
                              labelStyle: AppTexts.inputLabelTextStyle,
                              border:
                                  AppBorders.outlineTFBorder(BorderSide.none),
                              focusedErrorBorder: AppBorders.outlineTFBorder(
                                const BorderSide(
                                    width: 2, color: AppColors.error),
                              ),
                              focusedBorder: AppBorders.outlineTFBorder(
                                const BorderSide(
                                    width: 2, color: AppColors.primary),
                              ),
                            ),
                            borderRadius: AppBorders
                                .radius, // Ensures dropdown menu has rounded corners
                            dropdownColor: AppColors
                                .textFieldBg, // Optional: Matches background
                          ),
                          AppPaddings.gapH(10),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  controller: provider.rateControllers[index],
                                  keyboardType: TextInputType.number,
                                  labelTxt: "Rate",
                                  onChangedFunc: (value) => provider.updateCost(
                                      index,
                                      rate: double.tryParse(value) ?? 0),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    controller: provider.qtyControllers[index],
                                    keyboardType: TextInputType.number,
                                    labelTxt: "Quantity",
                                    onChangedFunc: (value) =>
                                        provider.updateCost(index,
                                            qty: double.tryParse(value) ?? 0),
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "₹ ${NumberFormatter.format(cost.total)}",
                                    style: AppTexts.inputTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              AppPaddings.gapH(10),
            ],
          );
        },
      );

  static const TextStyle labelStyle = TextStyle();
  static const TextStyle txtStyle = TextStyle(
    fontWeight: FontWeight.w600,
  );
}
