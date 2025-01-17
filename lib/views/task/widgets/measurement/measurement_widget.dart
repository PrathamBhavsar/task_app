import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        final List<Map<String, dynamic>> rooms =
            provider.windowMeasurements.entries
                .map((entry) {
                  final roomName = entry.key;

                  // Filter out empty windows
                  final List<Map<String, dynamic>> windows = entry.value.entries
                      .map((windowEntry) {
                        final windowName = windowEntry.key;
                        final windowData = windowEntry.value;

                        // Skip the window if all fields are empty
                        if (windowData.values
                            .every((value) => value == null || value.isEmpty)) {
                          return null; // Indicate this window should not be included
                        }

                        final size =
                            "H: ${windowData['height'] ?? ''}, W: ${windowData['width'] ?? ''}";
                        return {
                          'windowName': windowName,
                          'size': size,
                          'area': windowData['area'] ?? '',
                          'type': windowData['type'] ?? '',
                          'remarks': windowData['remarks'] ?? '',
                        };
                      })
                      .where((window) => window != null)
                      .cast<Map<String, dynamic>>()
                      .toList();

                  // Skip the room if there are no valid windows
                  if (windows.isEmpty) {
                    return null;
                  }

                  return {'roomName': roomName, 'windows': windows};
                })
                .where((room) => room != null)
                .cast<Map<String, dynamic>>()
                .toList();

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
                        borderRadius: AppConsts.radius,
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
                              windowAreas: (room['windows'] as List<dynamic>)
                                  .map<String>((window) =>
                                      (window as Map<String, String>)['area']!)
                                  .toList(),
                              windowTypes: (room['windows'] as List<dynamic>)
                                  .map<String>((window) =>
                                      (window as Map<String, String>)['type']!)
                                  .toList(),
                              windowRemarks: (room['windows'] as List<dynamic>)
                                  .map<String>((window) => (window
                                      as Map<String, String>)['remarks']!)
                                  .toList(),
                              windowNames: (room['windows'] as List<dynamic>?)
                                      ?.map<String>((window) => (window as Map<
                                          String, String>)['windowName']!)
                                      .toList() ??
                                  [],
                              sizes: (room['windows'] as List<dynamic>?)
                                      ?.map<String>((window) => (window
                                          as Map<String, String>)['size']!)
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
      Fluttertoast.showToast(msg: 'Copied to your clipboard!');
    });
  }
}
