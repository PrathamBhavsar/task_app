import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/measurement_provider.dart';
import 'package:task_app/views/task/widgets/measurement/room_column.dart';

class MeasurementWidget extends StatelessWidget {
  const MeasurementWidget({super.key});

  void _copyToClipboard(
      BuildContext context, List<Map<String, dynamic>> rooms) {
    final copyText = rooms.map((room) {
      final windowsText =
          (room['windows'] as List<Map<String, String>>).map((window) {
        return '''  ${window['windowName']}
        Size: ${window['size']}
        Area: ${window['area']}
        Type: ${window['type']}
        Remarks: ${window['remarks']}''';
      }).join('\n');
      return '${room['roomName']}\n$windowsText';
    }).join('\n\n');

    Clipboard.setData(ClipboardData(text: copyText)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to your clipboard!')),
      );
    });
  }

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

            final area = windowEntry.value['area'] ?? '';
            final type = windowEntry.value['type'] ?? '';
            final remarks = windowEntry.value['remarks'] ?? '';
            return {
              'windowName': windowName,
              'size': size,
              'area': area,
              'type': type,
              'remarks': remarks
            };
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
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: () {
                                  _copyToClipboard(context, rooms);
                                },
                                icon: const Icon(Icons.copy_rounded),
                              ),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ],
                ),
              ),
              AppPaddings.gapH(10),
              provider.rooms.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBg,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> room = rooms[index];

                            return RoomColumn(
                              roomNames: room['roomName']!,
                              windowAreas:
                                  (room['windows'] as List<Map<String, String>>)
                                      .map<String>((window) => window['area']!)
                                      .toList(),
                              windowTypes:
                                  (room['windows'] as List<Map<String, String>>)
                                      .map<String>((window) => window['type']!)
                                      .toList(),
                              windowRemarks: (room['windows']
                                      as List<Map<String, String>>)
                                  .map<String>((window) => window['remarks']!)
                                  .toList(),
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
