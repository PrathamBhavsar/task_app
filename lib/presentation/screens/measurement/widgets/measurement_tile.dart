import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_bloc.dart';
import '../../../blocs/measurement/measurement_event.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/labeled_text_field.dart';

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
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    locationController.dispose();
    widthController.dispose();
    heightController.dispose();
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
                      () => context.read<MeasurementBloc>().add(
                        MeasurementRemoved(widget.index),
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
              onChanged: (value) {
                context.read<MeasurementBloc>().add(
                  MeasurementFieldUpdated(index: widget.index, location: value),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: LabeledTextInput(
                    title: 'Width (inches)',
                    hint: '0.00',
                    keyboardType: TextInputType.number,
                    controller: widthController,
                    onChanged: (value) {
                      final width = double.tryParse(value);

                      context.read<MeasurementBloc>().add(
                        MeasurementFieldUpdated(
                          index: widget.index,
                          width: width,
                        ),
                      );
                    },
                  ),
                ),
                10.wGap,
                Expanded(
                  child: LabeledTextInput(
                    title: 'Height (inches)',
                    hint: '0.00',
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    onChanged: (value) {
                      final height = double.tryParse(value);

                      context.read<MeasurementBloc>().add(
                        MeasurementFieldUpdated(
                          index: widget.index,
                          height: height,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            LabeledTextInput(
              title: 'Notes',
              hint: 'Enter note here',
              isMultiline: true,
              controller: noteController,
              onChanged: (value) {
                context.read<MeasurementBloc>().add(
                  MeasurementFieldUpdated(index: widget.index, notes: value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
