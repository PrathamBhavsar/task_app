import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/measurement_provider.dart';
import 'package:task_app/views/task/widgets/measurement/room_column.dart';

class MeasurementWidget extends StatelessWidget {
  const MeasurementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MeasurementProvider>(
      builder:
          (BuildContext context, MeasurementProvider provider, Widget? child) {
        // Transforming data into the required format
        final rooms = provider.windowMeasurements.entries.map((entry) {
          final roomName = entry.key;
          final windows = entry.value.entries.map((windowEntry) {
            final windowName = windowEntry.key;
            final size =
                "H: ${windowEntry.value['height'] ?? ''}, W: ${windowEntry.value['width'] ?? ''}";
            return {'windowName': windowName, 'size': size};
          }).toList();
          return {'roomName': roomName, 'windows': windows};
        }).toList();

        return Padding(
          padding: AppPaddings.appPadding,
          child: Column(
            children: [
              InkWell(
                onTap: () => context.pushNamed('measurement'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Measurement', style: AppTexts.headingStyle),
                    Row(
                      children: [
                        provider.rooms.isEmpty
                            ? SizedBox.shrink()
                            : IconButton(
                                onPressed: () {
                                  String copyText = '';
                                  for (var room in rooms) {
                                    if (room['windows'] != null) {
                                      copyText += '${room['roomName']}\n';
                                      for (var window in (room['windows']
                                          as List<Map<String, String>>)) {
                                        copyText +=
                                            '  ${window['windowName']}: ${window['size']}\n';
                                      }
                                    }
                                  }

                                  Clipboard.setData(
                                          ClipboardData(text: copyText))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Copied to your clipboard!'),
                                      ),
                                    );
                                  });
                                },
                                icon: Icon(Icons.copy_rounded),
                              ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ],
                ),
              ),
              AppPaddings.gapH(10),
              provider.rooms.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBg,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> room = rooms[index];

                            if (room.isEmpty) {
                              return Center(
                                child: Text('empty'),
                              );
                            }
                            return RoomColumn(
                              roomNames: room['roomName']!,
                              windowNames: (room['windows']
                                          as List<Map<String, String>>?)
                                      ?.map<String>(
                                          (window) => window['windowName']!)
                                      .toList() ??
                                  [],
                              sizes: (room['windows']
                                          as List<Map<String, String>>?)
                                      ?.map<String>((window) => window['size']!)
                                      .toList() ??
                                  [],
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
