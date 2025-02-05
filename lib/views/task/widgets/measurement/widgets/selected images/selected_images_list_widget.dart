import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../constants/app_consts.dart';
import '../../../../../../providers/measurement_provider.dart';
import 'picked_file_widget.dart';

class SelectedImagesListWidget extends StatelessWidget {
  const SelectedImagesListWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Selected Images", style: AppTexts.tileTitle1),
          Consumer<MeasurementProvider>(
            builder: (context, provider, child) => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.pickedPhotos.length,
              itemBuilder: (context, index) => PickedFileWidget(
                fileName: provider.pickedPhotos[index].name,
                onCancel: () => provider.deletePickedImage(index),
                isNewTask: false,
              ),
            ),
          ),
        ],
      );
}
