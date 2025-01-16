import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/task/widgets/measurement/size_tile.dart';
import 'package:task_app/views/task/widgets/measurement/title_tile.dart';

class RoomColumn extends StatelessWidget {
  const RoomColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTile(),
        AppPaddings.gapH(5),
        SizeTile(),
        SizeTile(),
        SizeTile(),
      ],
    );
  }
}
