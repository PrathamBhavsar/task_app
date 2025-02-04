import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../providers/measurement_provider.dart';
import '../../../../widgets/action_button.dart';
import '../../../../widgets/custom_text_feild.dart';

class MeasurementScreen2 extends StatefulWidget {
  const MeasurementScreen2({super.key});

  @override
  _MeasurementScreen2State createState() => _MeasurementScreen2State();
}

class _MeasurementScreen2State extends State<MeasurementScreen2> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
          child: Scaffold(
            extendBody: true,
            persistentFooterButtons: [
              Column(
                children: [
                  Text(
                    'Add photo from',
                    style: AppTexts.buttonText,
                  ),
                  AppPaddings.gapH(5),
                  Row(
                    children: [
                      Flexible(
                        child: ActionBtn(
                          btnTxt: 'Camera',
                          fontColor: Colors.white,
                          backgroundColor: AppColors.primary,
                          onPress: () => MeasurementProvider.instance
                              .pickImage(ImageSource.camera),
                        ),
                      ),
                      AppPaddings.gapW(5),
                      Flexible(
                        child: ActionBtn(
                          btnTxt: 'Gallery',
                          fontColor: Colors.white,
                          backgroundColor: AppColors.primary,
                          onPress: () => MeasurementProvider.instance
                              .pickImage(ImageSource.gallery),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: Text(
                'Measurement',
                style: AppTexts.appBarStyle,
              ),
            ),
            body: Consumer<MeasurementProvider>(
              builder: (context, provider, child) => Padding(
                padding: AppPaddings.appPadding,
                child: provider.pickedPhoto != null
                    ? ClipRRect(
                        borderRadius: AppConsts.radius,
                        child: Image.file(
                          File(provider.pickedPhoto!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: AppPaddings.appPadding,
                          child: Text('No Photos added!'),
                        ),
                      ),
              ),
            ),
            // bottomSheet: ,
          ),
        ),
      );

  Widget _buildDivider(
          {double verticalPadding = 0,
          double horizontalPadding = 0,
          Color color = AppColors.primary}) =>
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Divider(color: color),
      );
}
