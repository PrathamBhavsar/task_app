import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_cubit.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/labeled_text_field.dart';
import 'unit_selector.dart';

class MeasurementTile extends StatefulWidget {
  const MeasurementTile({required this.index, super.key});

  final int index;

  @override
  State<MeasurementTile> createState() => _MeasurementTileState();
}

class _MeasurementTileState extends State<MeasurementTile> {
  late TextEditingController locationController;
  late TextEditingController widthController;
  late TextEditingController heightController;
  late TextEditingController areaController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    _initiateControllers();
  }

  void _initiateControllers() {
    locationController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
    areaController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    locationController.dispose();
    widthController.dispose();
    heightController.dispose();
    areaController.dispose();
    noteController.dispose();
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
                  onPressed:
                      () => context.read<MeasurementCubit>().removeMeasurement(
                        widget.index,
                      ),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
            10.hGap,
            LabeledTextInput(
              title: 'Location',
              hint: 'Enter room location',
              controller: locationController,
              onChanged:
                  (value) =>
                      context.read<MeasurementCubit>().updateMeasurementField(
                        index: widget.index,
                        location: value,
                      ),
            ),
            Row(
              children: [
                Expanded(
                  child: LabeledTextInput(
                    title: 'Width',
                    hint: '0.00',
                    keyboardType: TextInputType.number,
                    controller: widthController,
                    onChanged: (value) {
                      final width = double.tryParse(value);

                      context.read<MeasurementCubit>().updateMeasurementField(
                        index: widget.index,
                        width: width,
                      );
                    },
                  ),
                ),
                10.wGap,
                Expanded(
                  child: LabeledTextInput(
                    title: 'Height',
                    hint: '0.00',
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    onChanged: (value) {
                      final height = double.tryParse(value);

                      context.read<MeasurementCubit>().updateMeasurementField(
                        index: widget.index,
                        height: height,
                      );
                    },
                  ),
                ),
                10.wGap,
                Expanded(
                  child: LabeledTextInput(
                    title: 'Area',
                    hint: '0.00',
                    keyboardType: TextInputType.number,
                    controller: areaController,
                    onChanged: (value) {
                      final area = double.tryParse(value);
                      context.read<MeasurementCubit>().updateMeasurementField(
                        index: widget.index,
                        area: area,
                      );
                    },
                  ),
                ),
              ],
            ),
            UnitSelector(index: widget.index),
            LabeledTextInput(
              title: 'Notes',
              hint: 'Enter note here',
              isMultiline: true,
              controller: noteController,
              onChanged:
                  (value) =>
                      context.read<MeasurementCubit>().updateMeasurementField(
                        index: widget.index,
                        notes: value,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
