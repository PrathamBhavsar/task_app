import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../constants/app_colors.dart';
import '../../../../models/measurement.dart';
import '../../../../providers/measurement_provider.dart';
import '../../../../widgets/action_button.dart';
import 'additional_cost_widget.dart';
import 'datagrid/r.dart';

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
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Consumer<MeasurementProvider>(
                builder: (context, provider, child) => Padding(
                  padding: AppPaddings.appPadding,
                  child: provider.pickedPhoto == null
                      ? Center(
                          child: Padding(
                            padding: AppPaddings.appPadding,
                            child: Text('No Photos added!'),
                          ),
                        )
                      : Column(
                          children: [
                            AdditionalCostsWidget(),
                            provider.costs.isEmpty
                                ? ActionBtn(
                                    btnTxt: 'Add Additional Costs',
                                    onPress: () => provider.addCost(),
                                    fontColor: AppColors.primary,
                                    backgroundColor: Colors.white,
                                  )
                                : SizedBox.shrink(),
                            ClipRRect(
                              borderRadius: AppConsts.radius,
                              child: Image.file(
                                File(provider.pickedPhoto!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            AppPaddings.gapH(5),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                provider.trimmedFileName(),
                                overflow: TextOverflow.ellipsis,
                                style: AppTexts.tileTitle2,
                              ),
                            ),
                            AppPaddings.gapH(120),
                          ],
                        ),
                ),
              ),
            ),
            // bottomSheet: ,
          ),
        ),
      );
}
