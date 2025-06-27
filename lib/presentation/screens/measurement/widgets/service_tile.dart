import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/service.dart';
import '../../../../domain/entities/service_master.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_bloc.dart';
import '../../../blocs/measurement/measurement_event.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/drop_down_menu.dart';
import '../../../widgets/labeled_text_field.dart';

class ServiceTile extends StatefulWidget {
  const ServiceTile({
    required this.index,
    required this.serviceMasters,
    required this.selectedServiceMaster,
    super.key,
    required this.service,
  });

  final int index;
  final List<ServiceMaster> serviceMasters;
  final ServiceMaster selectedServiceMaster;
  final Service service;

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  late TextEditingController quantityController;
  late TextEditingController rateController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    quantityController = TextEditingController(
      text: widget.service.quantity.toString(),
    );
    rateController = TextEditingController(
      text: widget.service.rate.toStringAsFixed(2),
    );
    amountController = TextEditingController(
      text: widget.service.amount.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(ServiceTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newQty = widget.service.quantity.toString();
    final newRate = widget.service.rate.toStringAsFixed(2);
    final newAmount = widget.service.amount.toStringAsFixed(2);

    if (quantityController.text != newQty &&
        quantityController.selection.baseOffset == -1) {
      quantityController.text = newQty;
    }

    if (rateController.text != newRate &&
        rateController.selection.baseOffset == -1) {
      rateController.text = newRate;
    }

    if (amountController.text != newAmount &&
        amountController.selection.baseOffset == -1) {
      amountController.text = newAmount;
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    rateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
      child: BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${widget.index + 1}', style: AppTexts.titleTextStyle),
                IconButton(
                  onPressed: () {
                    context.read<MeasurementBloc>().add(
                      ServiceRemoved(widget.index),
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
            10.hGap,
            _buildDropdown<ServiceMaster>(
              title: 'Service Type',
              list: widget.serviceMasters,
              initialValue: widget.selectedServiceMaster,
              onChanged: (selected) {
                rateController.text = selected.rate.toString();
                amountController.text = (selected.rate * 1).toStringAsFixed(2);

                final quantity = int.tryParse(quantityController.text);
                final rate = double.tryParse(rateController.text);

                context.read<MeasurementBloc>().add(
                  ServiceFieldUpdated(
                    index: widget.index,
                    quantity: quantity,
                    rate: rate,
                  ),
                );

                context.read<MeasurementBloc>().add(
                  ServiceMasterUpdated(
                    index: widget.index,
                    serviceMaster: selected,
                  ),
                );
              },
              labelBuilder: (p) => p.name,
              idBuilder: (p) => p.serviceMasterId?.toString() ?? '',
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: LabeledTextInput(
                    title: 'Quantity',
                    hint: '1',
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final quantity = int.tryParse(value);
                      context.read<MeasurementBloc>().add(
                        ServiceFieldUpdated(
                          index: widget.index,
                          quantity: quantity,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: LabeledTextInput(
                    title: 'Rate',
                    hint: '0.00',
                    controller: rateController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (value) {
                      final rate = double.tryParse(value);
                      context.read<MeasurementBloc>().add(
                        ServiceFieldUpdated(index: widget.index, rate: rate),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: LabeledTextInput(
                    title: 'Amount',
                    hint: '0.00',
                    controller: amountController,
                    isEnabled: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildDropdown<T>({
    required String title,
    required List<T> list,
    required ValueChanged<T> onChanged,
    T? initialValue,
    String Function(T)? labelBuilder,
    String Function(T)? idBuilder,
  }) {
    final effectiveLabelBuilder = labelBuilder ?? (value) => value.toString();
    final effectiveIdBuilder =
        idBuilder ?? (value) => value.hashCode.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hGap,
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        ModelDropdownMenu<T>(
          items: list,
          initialValue: initialValue,
          onChanged: onChanged,
          labelBuilder: effectiveLabelBuilder,
          idBuilder: effectiveIdBuilder,
        ),
        10.hGap,
      ],
    );
  }
}
