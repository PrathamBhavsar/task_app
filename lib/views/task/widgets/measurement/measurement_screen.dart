import 'package:flutter/material.dart';
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
  final Map<int, Map<String, TextEditingController>> windowControllers = {};
  final Map<int, Map<String, TextEditingController>> heightControllers = {};
  final Map<int, Map<String, TextEditingController>> widthControllers = {};

  @override
  void dispose() {
    roomControllers.values.forEach((controller) => controller.dispose());
    windowControllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });
    heightControllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });
    widthControllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBody: true,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: ActionBtn(
              btnTxt: 'Add Room',
              fontColor: Colors.white,
              backgroundColor: AppColors.primary,
              onPress: () => MeasurementProvider.instance.addRoom(),
            ),
          )
        ],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text(
            'Measurement',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () => MeasurementProvider.instance.saveAllChanges(
                roomControllers,
                windowControllers,
                heightControllers,
                widthControllers,
              ),
            ),
          ],
        ),
        body: Consumer<MeasurementProvider>(
          builder: (context, provider, child) {
            provider.rooms.asMap().forEach((roomIndex, room) {
              String roomName = room.keys.first;
              List<String> windows = room[roomName]!;

              roomControllers.putIfAbsent(
                  roomIndex, () => TextEditingController(text: roomName));
              windowControllers.putIfAbsent(roomIndex, () => {});
              heightControllers.putIfAbsent(roomIndex, () => {});
              widthControllers.putIfAbsent(roomIndex, () => {});

              for (var windowName in windows) {
                windowControllers[roomIndex]!.putIfAbsent(
                    windowName, () => TextEditingController(text: windowName));
                heightControllers[roomIndex]!.putIfAbsent(
                    windowName,
                    () => TextEditingController(
                        text: provider.windowMeasurements[roomName]?[windowName]
                                ?['height'] ??
                            ''));
                widthControllers[roomIndex]!.putIfAbsent(
                    windowName,
                    () => TextEditingController(
                        text: provider.windowMeasurements[roomName]?[windowName]
                                ?['width'] ??
                            ''));
              }
            });
            return Padding(
              padding: AppPaddings.appPadding,
              child: ListView.builder(
                itemCount: provider.rooms.length,
                itemBuilder: (context, roomIndex) {
                  String roomName = provider.rooms[roomIndex].keys.first;
                  List<String> windows = provider.rooms[roomIndex][roomName]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Stack(
                      children: [
                        Container(
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller: roomControllers[roomIndex],
                                        labelTxt: 'Room Name',
                                      ),
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.close, color: Colors.red),
                                      onPressed: () {
                                        provider.deleteRoom(roomIndex);
                                      },
                                    ),
                                  ],
                                ),
                                _buildDivider(),
                                ...windows.map((windowName) {
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
                                            labelTxt: 'Window Name',
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  controller: heightControllers[
                                                      roomIndex]![windowName]!,
                                                  labelTxt: 'Height',
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: CustomTextField(
                                                  controller: widthControllers[
                                                      roomIndex]![windowName]!,
                                                  labelTxt: 'Width',
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () {
                                            provider.deleteWindow(
                                                roomIndex, windowName);
                                          },
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
                                AppPaddings.gapH(20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        // bottomSheet: ,
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
