import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/constants/app_consts.dart';
import '../../../../../../providers/measurement_provider.dart';
import 'picked_file_widget.dart';

class SelectedImagesList extends StatelessWidget {
  final List<XFile> images;
  const SelectedImagesList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeasurementProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConsts.buildDivider(verticalPadding: 20),
        Text("Selected Images", style: AppTexts.tileTitle1),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          itemBuilder: (context, index) => PickedFileWidget(
            fileName: images[index].name,
            onCancel: () => provider.deletePickedImage(index),
            isNewTask: false,
          ),
        ),
      ],
    );
  }
}
