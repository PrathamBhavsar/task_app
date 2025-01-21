import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final Map<int, Map<String, TextEditingController>> areaControllers = {};
  final Map<int, Map<String, TextEditingController>> typeControllers = {};
  final Map<int, Map<String, TextEditingController>> remarksControllers = {};

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
    areaControllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });
    typeControllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });
    remarksControllers.values.forEach((controllers) {
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
          title: Text(
            'Measurement',
            style: AppTexts.appBarStyle,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  MeasurementProvider.instance.saveAllChanges(
                    roomControllers,
                    windowControllers,
                    heightControllers,
                    widthControllers,
                    areaControllers,
                    typeControllers,
                    remarksControllers,
                  );

                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Measurement saved!'),
                    ),
                  );
                }),
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
              areaControllers.putIfAbsent(roomIndex, () => {});
              typeControllers.putIfAbsent(roomIndex, () => {});
              remarksControllers.putIfAbsent(roomIndex, () => {});

              for (var windowName in windows) {
                windowControllers[roomIndex]!.putIfAbsent(
                    windowName, () => TextEditingController(text: windowName));

                areaControllers[roomIndex]!.putIfAbsent(
                    windowName,
                    () => TextEditingController(
                        text: provider.windowMeasurements[roomName]?[windowName]
                                ?['area'] ??
                            ''));
                typeControllers[roomIndex]!.putIfAbsent(
                    windowName,
                    () => TextEditingController(
                        text: provider.windowMeasurements[roomName]?[windowName]
                                ?['type'] ??
                            ''));
                remarksControllers[roomIndex]!.putIfAbsent(
                    windowName,
                    () => TextEditingController(
                        text: provider.windowMeasurements[roomName]?[windowName]
                                ?['remarks'] ??
                            ''));

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
            if (provider.rooms.isEmpty) {
              return Center(
                child: Text('No Measurements yet!'),
              );
            }
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
                            borderRadius: AppConsts.radius,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 16, 10, 10),
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
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      title: Row(
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
                                                    controller:
                                                        heightControllers[
                                                                roomIndex]![
                                                            windowName]!,
                                                    labelTxt: 'H',
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: CustomTextField(
                                                    controller:
                                                        widthControllers[
                                                                roomIndex]![
                                                            windowName]!,
                                                    labelTxt: 'W',
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
                                      children: [
                                        _buildDivider(
                                          horizontalPadding: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Area',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomTextField(
                                                      controller:
                                                          areaControllers[
                                                                  roomIndex]![
                                                              windowName]!,
                                                      hintTxt: 'Area',
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              AppPaddings.gapH(10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Rail Type',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomTextField(
                                                      controller:
                                                          typeControllers[
                                                                  roomIndex]![
                                                              windowName]!,
                                                      hintTxt: 'Type',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              AppPaddings.gapH(10),
                                              CustomTextField(
                                                controller: remarksControllers[
                                                    roomIndex]![windowName]!,
                                                labelTxt: 'Remarks',
                                              ),
                                            ],
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

  Widget _buildDivider(
      {double verticalPadding = 0,
      double horizontalPadding = 0,
      Color color = AppColors.primary}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Divider(color: color),
    );
  }
}
