import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import 'size_tile.dart';
import 'title_tile.dart';

class RoomColumn extends StatelessWidget {
  const RoomColumn({
    super.key,
    required this.roomNames,
    required this.windowNames,
    required this.sizes,
    required this.windowAreas,
    required this.windowTypes,
    required this.windowRemarks,
  });

  final String roomNames;
  final List<String> windowNames;
  final List<String> windowAreas;
  final List<String> windowTypes;
  final List<String> windowRemarks;
  final List<String> sizes;

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(roomName: roomNames),
        AppPaddings.gapH(8),
        ...List.generate(
          windowNames.length,
          (index) => WindowTile(
            windowName: windowNames[index],
            windowArea: windowAreas[index],
            windowType: windowTypes[index],
            windowRemark: windowRemarks[index],
            size: sizes[index],
          ),
        ),
        AppPaddings.gapH(10),
      ],
    );
}
