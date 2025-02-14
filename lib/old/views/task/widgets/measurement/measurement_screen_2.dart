import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_consts.dart';
import '../../../../providers/measurement_provider.dart';
import 'widgets/additional costs/additional_costs_list.dart';
import 'widgets/image_buttons.dart';
import 'widgets/selected images/selected_images_list.dart';

class MeasurementScreen2 extends StatelessWidget {
  const MeasurementScreen2({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          extendBody: true,
          persistentFooterButtons: const [ImageButtonsRow()],
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text('Measurement', style: AppTexts.appBarStyle),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: AppPaddings.appPadding,
              child: Consumer<MeasurementProvider>(
                builder: (context, provider, _) => Column(
                  children: [
                    AdditionalCostsList(provider: provider),
                    provider.pickedPhotos.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              'No Photos added!',
                              style: AppTexts.tileTitle2,
                            ),
                          )
                        : SelectedImagesList(images: provider.pickedPhotos),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
