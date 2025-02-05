import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../helpers/number_helper.dart';
import '../../../../providers/measurement_provider.dart';
import '../../../../widgets/action_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'picked_file_widget.dart';
import 'widgets/additional costs/additional_costs_list.dart';
import 'widgets/image_buttons.dart';
import 'widgets/selected_images_list.dart';

class MeasurementScreen2 extends StatelessWidget {
  const MeasurementScreen2({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
