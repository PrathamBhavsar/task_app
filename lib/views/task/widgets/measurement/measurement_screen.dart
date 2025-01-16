import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/measurement_provider.dart';
import 'package:task_app/widgets/action_button.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final Map<int, TextEditingController> roomControllers = {};
  final Map<int, FocusNode> roomFocusNodes = {};
  final Map<int, Map<String, TextEditingController>> windowControllers = {};
  final Map<int, Map<String, FocusNode>> windowFocusNodes = {};

  @override
  void dispose() {
    roomControllers.values.forEach((controller) => controller.dispose());
    roomFocusNodes.values.forEach((focusNode) => focusNode.dispose());
    windowControllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });
    windowFocusNodes.values.forEach((focusNodes) {
      focusNodes.values.forEach((focusNode) => focusNode.dispose());
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ActionBtn(
            btnTxt: 'Add Room',
            fontColor: Colors.white,
            backgroundColor: AppColors.primary,
            onPress: () => MeasurementProvider.instance.addRoom(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text(
            'Measurement',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MeasurementProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                itemCount: provider.rooms.length,
                itemBuilder: (context, roomIndex) {
                  String roomName = provider.rooms[roomIndex].keys.first;
                  List<String> windows = provider.rooms[roomIndex][roomName]!;

                  // Initialize controllers and focus nodes for the room
                  roomControllers.putIfAbsent(
                      roomIndex, () => TextEditingController(text: roomName));
                  roomFocusNodes.putIfAbsent(roomIndex, () => FocusNode());

                  // Initialize controllers and focus nodes for windows
                  windowControllers.putIfAbsent(roomIndex, () => {});
                  windowFocusNodes.putIfAbsent(roomIndex, () => {});

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBg,
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              controller: roomControllers[roomIndex],
                              focusNode: roomFocusNodes[roomIndex],
                              labelTxt: 'Room Name',
                              onChangedFunc: (value) {
                                provider.updateRoomName(
                                  oldRoomName: roomName,
                                  newRoomName: value,
                                );
                              },
                            ),
                            _buildDivider(),
                            ...windows.map((windowName) {
                              // Initialize controllers and focus nodes for each window
                              windowControllers[roomIndex]!.putIfAbsent(
                                  windowName,
                                  () =>
                                      TextEditingController(text: windowName));
                              windowFocusNodes[roomIndex]!
                                  .putIfAbsent(windowName, () => FocusNode());

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller: windowControllers[
                                            roomIndex]![windowName]!,
                                        focusNode: windowFocusNodes[roomIndex]![
                                            windowName],
                                        onChangedFunc: (value) {
                                          provider.updateWindowName(
                                            roomName: roomName,
                                            oldWindowName: windowName,
                                            newWindowName: value,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextField(
                                        controller: TextEditingController(
                                          text: provider.windowMeasurements[
                                                      roomName]?[windowName]
                                                  ?['height'] ??
                                              '',
                                        ),
                                        labelTxt: 'Height',
                                        onChangedFunc: (value) {
                                          provider.updateWindowMeasurement(
                                            roomName: roomName,
                                            windowName: windowName,
                                            type: 'height',
                                            value: value,
                                          );
                                        },
                                      ),
                                    ),
                                    Icon(Icons.close_rounded, size: 16.sp),
                                    Expanded(
                                      child: CustomTextField(
                                        controller: TextEditingController(
                                          text: provider.windowMeasurements[
                                                      roomName]?[windowName]
                                                  ?['width'] ??
                                              '',
                                        ),
                                        labelTxt: 'Width',
                                        onChangedFunc: (value) {
                                          provider.updateWindowMeasurement(
                                            roomName: roomName,
                                            windowName: windowName,
                                            type: 'width',
                                            value: value,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            ActionBtn(
                              btnTxt: 'Add Window',
                              backgroundColor: Colors.white,
                              fontColor: AppColors.primary,
                              onPress: () => provider.addWindow(roomIndex),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: AppColors.primary),
    );
  }
}
