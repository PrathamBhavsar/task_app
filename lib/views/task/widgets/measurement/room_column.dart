import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/task/widgets/measurement/size_tile.dart';
import 'package:task_app/views/task/widgets/measurement/title_tile.dart';

class RoomColumn extends StatelessWidget {
  const RoomColumn({
    super.key,
    required this.roomNames,
    required this.windowNames,
    required this.sizes,
  });

  final String roomNames;
  final List<String> windowNames;
  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(roomName: roomNames),
        AppPaddings.gapH(8),
        ...List.generate(
          windowNames.length,
          (index) => WindowTile(
            windowName: windowNames[index],
            size: sizes[index],
          ),
        ),
        AppPaddings.gapH(10),
      ],
    );
  }
}
