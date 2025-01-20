import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/dummy_data.dart';
import 'package:task_app/providers/measurement_provider.dart';
import 'package:task_app/providers/quotation_provider.dart';
import 'package:task_app/views/task/widgets/measurement/room_column.dart';

class QuotationWidget extends StatelessWidget {
  const QuotationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuotationProvider>(
      builder:
          (BuildContext context, QuotationProvider provider, Widget? child) {
        // Transforming data into the required format
        final List<Map<String, dynamic>> rooms = DummyData.roomDetails.entries
            .map((entry) {
              final roomName = entry.key;

              // Filter out empty windows
              final List<Map<String, dynamic>> windows = entry.value.entries
                  .map((windowEntry) {
                    final windowName = windowEntry.key;
                    final windowData = windowEntry.value;

                    // Skip the window if all fields are empty or null
                    final filteredWindowData = {
                      'height': windowData['height'],
                      'width': windowData['width'],
                      'area': windowData['area'],
                      'type': windowData['type'],
                      'remarks': windowData['remarks'],
                    }..removeWhere((key, value) =>
                        value == null || value.toString().isEmpty);

                    // Skip the window if no valid data exists after filtering
                    if (filteredWindowData.isEmpty) {
                      return null; // Indicate this window should not be included
                    }

                    final size =
                        "H: ${filteredWindowData['height'] ?? ''}, W: ${filteredWindowData['width'] ?? ''}";
                    return {
                      'windowName': windowName,
                      'size': size,
                      'area': filteredWindowData['area'] ?? '',
                      'type': filteredWindowData['type'] ?? '',
                      'remarks': filteredWindowData['remarks'] ?? '',
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
                onTap: () => context.pushNamed('quotation'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quotation', style: AppTexts.headingStyle),
                    Row(
                      children: [
                        false
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
              true
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
