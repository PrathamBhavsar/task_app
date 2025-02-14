import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/app_consts.dart';
import '../../../../../providers/measurement_provider.dart';
import '../../../../../extensions/app_paddings.dart';
import '../../../../../helpers/indian_number_system_helper.dart';
import '../../../../../helpers/number_helper.dart';
import '../../../../../models/measurement.dart';

import 'selected images/picked_file_widget.dart';

class MeasurementWidget extends StatelessWidget {
  final bool isNewTask;
  const MeasurementWidget({super.key, required this.isNewTask});

  @override
  Widget build(BuildContext context) => Consumer<MeasurementProvider>(
        builder: (BuildContext context, MeasurementProvider provider,
            Widget? child) {
          // Transforming data into the required format
          final List<Map<String, dynamic>> rooms =
              provider.windowMeasurements.entries
                  .map((entry) {
                    final roomName = entry.key;

                    final List<Map<String, dynamic>> windows =
                        entry.value.entries
                            .map((windowEntry) {
                              final windowName = windowEntry.key;
                              final windowData = windowEntry.value;

                              final filteredWindowData = {
                                'height': windowData['height'],
                                'width': windowData['width'],
                                'area': windowData['area'],
                                'type': windowData['type'],
                                'remarks': windowData['remarks'],
                              }..removeWhere((key, value) =>
                                  value == null || value.toString().isEmpty);

                              if (filteredWindowData.isEmpty) {
                                return null;
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
                  onTap: () {
                    context.pushNamed('measurement2');
                  },
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
                10.hGap,
                provider.pickedPhotos.isEmpty
                    ? SizedBox.shrink()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.pickedPhotos.length,
                        itemBuilder: (BuildContext context, int index) =>
                            PickedFileWidget(
                          fileName: provider.pickedPhotos[index].name,
                          onCancel: () => provider.deletePickedImage(index),
                          isNewTask: isNewTask,
                        ),
                      ),
                provider.costs.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        decoration: BoxDecoration(
                          color: AppColors.textFieldBg,
                          borderRadius: AppBorders.radius,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rate',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Area',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Total',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.costs.length,
                                itemBuilder: (context, index) {
                                  final AdditionalCost cost =
                                      provider.costs[index];

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(cost.name),
                                      Text(NumberHelper.format(cost.rate)),
                                      Text(NumberHelper.format(cost.qty)),
                                      Text(IndianNumberHelper.format(
                                          cost.total)),
                                    ],
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    IndianNumberHelper.format(
                                        provider.totalAdditionalCost),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                // provider.rooms.isEmpty
                //     ? const SizedBox.shrink()
                //     : Container(
                //         decoration: BoxDecoration(
                //           color: AppColors.textFieldBg,
                //           borderRadius: AppConsts.radius,
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(18),
                //           child: ListView.builder(
                //             shrinkWrap: true,
                //             physics: const NeverScrollableScrollPhysics(),
                //             itemCount: rooms.length,
                //             itemBuilder: (context, index) {
                //               final Map<String, dynamic> room = rooms[index];
                //
                //               return RoomColumn(
                //                 roomNames: room['roomName']!,
                //                 windowAreas: (room['windows'] as List<dynamic>)
                //                     .map<String>((window) => (window
                //                         as Map<String, String>)['area']!)
                //                     .toList(),
                //                 windowTypes: (room['windows'] as List<dynamic>)
                //                     .map<String>((window) => (window
                //                         as Map<String, String>)['type']!)
                //                     .toList(),
                //                 windowRemarks:
                //                     (room['windows'] as List<dynamic>)
                //                         .map<String>((window) => (window
                //                             as Map<String, String>)['remarks']!)
                //                         .toList(),
                //                 windowNames: (room['windows'] as List<dynamic>?)
                //                         ?.map<String>((window) =>
                //                             (window as Map<String, String>)[
                //                                 'windowName']!)
                //                         .toList() ??
                //                     [],
                //                 sizes: (room['windows'] as List<dynamic>?)
                //                         ?.map<String>((window) => (window
                //                             as Map<String, String>)['size']!)
                //                         .toList() ??
                //                     [],
                //               );
                //             },
                //           ),
                //         ),
                //       ),
              ],
            ),
          );
        },
      );

  void _copyToClipboard(
      BuildContext context, List<Map<String, dynamic>> rooms) {
    final copyText = rooms.map((room) {
      final windowsText = (room['windows'] as List<Map<String, String>>)
          .map((window) => '''  ${window['windowName']}
        Size: ${window['size']}
        Area: ${window['area']}
        Type: ${window['type']}
        Remarks: ${window['remarks']}''')
          .join('\n');
      return '${room['roomName']}\n$windowsText';
    }).join('\n\n');

    Clipboard.setData(ClipboardData(text: copyText)).then((_) {
      Fluttertoast.showToast(msg: 'Copied to your clipboard!');
    });
  }
}
