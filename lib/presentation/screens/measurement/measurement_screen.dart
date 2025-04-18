import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/measurement_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Submit Measurements', style: AppTexts.titleTextStyle)],
      ),
    ),
    body: SafeArea(
      child: Consumer<MeasurementProvider>(
        builder:
            (
              BuildContext context,
              MeasurementProvider provider,
              Widget? child,
            ) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter the measurements for Window Measurement - Johnson Residence',
                    style: AppTexts.inputHintTextStyle,
                  ),

                  20.hGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Measurements', style: AppTexts.labelTextStyle),
                      IntrinsicWidth(
                        child: ActionButton(
                          label: 'Add Measurement',
                          prefixIcon: Icons.add,
                          onPress: () => provider.addMeasurement(),
                        ),
                      ),
                    ],
                  ),
                  10.hGap,
                  ...List.generate(
                    provider.measurements.length,
                    (index) => buildMeasurementTile(index, provider),
                  ),
                  20.hGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service Charges', style: AppTexts.labelTextStyle),
                      IntrinsicWidth(
                        child: ActionButton(
                          label: 'Add Service',
                          prefixIcon: Icons.add,
                          onPress: () => provider.addService(),
                        ),
                      ),
                    ],
                  ),
                  10.hGap,
                  ...List.generate(
                    provider.services.length,
                    (index) => buildServiceTile(index, provider),
                  ),
                  Divider(color: AppColors.accent).padSymmetric(vertical: 10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total: \$0.00',
                      style: AppTexts.labelTextStyle.copyWith(
                        fontVariations: [FontVariation.weight(600)],
                      ),
                    ),
                  ),
                  _buildTextInput('Additional Notes', 'Add additional note'),
                  Text('Attachments', style: AppTexts.labelTextStyle),

                  ...List.generate(
                    provider.attachments.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: BorderedContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.attachments[index],
                              style: AppTexts.headingTextStyle,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed:
                                  () => provider.removeAttachmentAt(index),
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.errorRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.hGap,
                  BorderedContainer(
                    child: Column(
                      children: [
                        Icon(
                          CustomIcon.cloudUpload,
                          size: 30.sp,
                          color: Colors.black,
                        ),
                        Text('Upload Files', style: AppTexts.headingTextStyle),
                        Text(
                          'Upload photos, diagrams, or documents',
                          style: AppTexts.inputHintTextStyle,
                        ),
                        10.hGap,
                        ActionButton(
                          label: 'Browse Files',
                          onPress: () => provider.addAttachment(),
                        ),
                      ],
                    ),
                  ),
                  20.hGap,
                  ActionButton(
                    label: 'Submit Measurements',
                    onPress: () {},
                    backgroundColor: Colors.black,
                    fontColor: Colors.white,
                  ),
                  10.hGap,
                  ActionButton(label: 'Cancel', onPress: () {}),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );

  Padding buildMeasurementTile(int index, MeasurementProvider provider) =>
      Padding(
        padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
        child: BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#${index + 1}', style: AppTexts.titleTextStyle),
                  IconButton(
                    onPressed: () => provider.removeMeasurementAt(index),
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.errorRed,
                    ),
                  ),
                ],
              ),
              10.hGap,
              _buildTextInput('Location', 'Enter room location'),
              Row(
                children: [
                  Expanded(child: _buildTextInput('Width (inches)', '0.00')),
                  10.wGap,
                  Expanded(child: _buildTextInput('Height (inches)', '0.00')),
                ],
              ),
              _buildTextInput('Notes', 'Enter note here', isMultiline: true),
            ],
          ),
        ),
      );

  Padding buildServiceTile(int index, MeasurementProvider provider) => Padding(
    padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
    child: BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('#${index + 1}', style: AppTexts.titleTextStyle),
              IconButton(
                onPressed: () => provider.removeServiceAt(index),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.errorRed,
                ),
              ),
            ],
          ),
          10.hGap,
          _buildTextInput('Service Type', 'Enter service type'),
          Row(
            children: [
              Expanded(child: _buildTextInput('Quantity', '0')),
              10.wGap,
              Expanded(child: _buildTextInput('Rate', '0.00')),
              10.wGap,
              Expanded(child: _buildTextInput('Amount', '0.00')),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _buildTextInput(
    String title,
    String hint, {
    bool isMultiline = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomTextField(hintTxt: hint, isMultiline: isMultiline),
      10.hGap,
    ],
  );
}
