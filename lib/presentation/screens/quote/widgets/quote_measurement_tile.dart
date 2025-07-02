import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/quote_measurement.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/quote/cubits/quote_cubit.dart';
import '../../../widgets/bordered_container.dart' show BorderedContainer;
import '../../../widgets/labeled_text_field.dart' show LabeledTextInput;

class QuoteMeasurementTile extends StatefulWidget {
  const QuoteMeasurementTile({
    required this.quoteMeasurement,
    required this.index,
    super.key,
  });

  final int index;
  final QuoteMeasurement quoteMeasurement;

  @override
  State<QuoteMeasurementTile> createState() => _QuoteMeasurementTileState();
}

class _QuoteMeasurementTileState extends State<QuoteMeasurementTile> {
  late TextEditingController quantityController;
  late TextEditingController rateController;
  late TextEditingController discountController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    quantityController = TextEditingController(
      text: widget.quoteMeasurement.quantity.toString(),
    );
    rateController = TextEditingController(
      text: widget.quoteMeasurement.rate.toStringAsFixed(2),
    );
    discountController = TextEditingController(
      text: widget.quoteMeasurement.totalPrice.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(QuoteMeasurementTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newQty = widget.quoteMeasurement.quantity.toString();
    final newRate = widget.quoteMeasurement.rate.toStringAsFixed(2);
    final newDiscount = widget.quoteMeasurement.discount.toStringAsFixed(2);

    if (quantityController.text != newQty &&
        quantityController.selection.baseOffset == -1) {
      quantityController.text = newQty;
    }

    if (rateController.text != newRate &&
        rateController.selection.baseOffset == -1) {
      rateController.text = newRate;
    }

    if (discountController.text != newDiscount &&
        discountController.selection.baseOffset == -1) {
      discountController.text = newDiscount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.quoteMeasurement.measurement.location} (${widget.quoteMeasurement.measurement.height} x ${widget.quoteMeasurement.measurement.width})",
            style: AppTexts.labelTextStyle,
          ),
          10.hGap,
          Row(
            children: [
              Expanded(
                child: LabeledTextInput(
                  title: 'Quantity',
                  hint: '1',
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final quantity = int.tryParse(value);
                    context.read<QuoteCubit>().updateQuoteMeasurement(
                      widget.index,
                      quantity: quantity,
                    );
                  },
                ),
              ),
              10.wGap,
              Expanded(
                child: LabeledTextInput(
                  title: 'Rate',
                  hint: '0.00',
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final rate = double.tryParse(value);
                    context.read<QuoteCubit>().updateQuoteMeasurement(
                      widget.index,
                      rate: rate,
                    );
                  },
                ),
              ),
              10.wGap,
              Expanded(
                child: LabeledTextInput(
                  title: 'Discount %',
                  hint: '0.00',
                  controller: discountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final discount = double.tryParse(value);
                    context.read<QuoteCubit>().updateQuoteMeasurement(
                      widget.index,
                      discount: discount,
                    );
                  },
                ),
              ),
            ],
          ),
          Text(
            'Total: ₹${widget.quoteMeasurement.totalPrice.toStringAsFixed(2)}',
            style: AppTexts.labelTextStyle,
          ),
        ],
      ),
    );
  }
}
