import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/app_consts.dart';
import '../../../../../providers/measurement_provider.dart';
import '../../../../../widgets/action_button.dart';

class ImageButtonsRow extends StatelessWidget {
  const ImageButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeasurementProvider>(context, listen: false);
    return Row(
      children: [
        Flexible(
          child: ActionBtn(
            btnTxt: 'Camera',
            fontColor: Colors.white,
            backgroundColor: AppColors.primary,
            onPress: () => provider.pickImages(ImageSource.camera),
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: ActionBtn(
            btnTxt: 'Gallery',
            fontColor: Colors.white,
            backgroundColor: AppColors.primary,
            onPress: () => provider.pickImages(ImageSource.gallery),
          ),
        ),
      ],
    );
  }
}
