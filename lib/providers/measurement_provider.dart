import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MeasurementProvider with ChangeNotifier {
  static final MeasurementProvider instance =
      MeasurementProvider._privateConstructor();

  MeasurementProvider._privateConstructor();

  // Rooms structure: List of maps where key is the room name and value is a list of window names
  List<Map<String, List<String>>> rooms = [];

  // Measurements structure: Map where key is room name and value is a map of window names and their dimensions
  Map<String, Map<String, Map<String, String>>> windowMeasurements = {};

  var log = Logger();

  /// Update window measurement (height or width)
  void updateWindowMeasurement({
    required String roomName,
    required String windowName,
    required String type,
    required String value,
  }) {
    windowMeasurements.putIfAbsent(roomName, () => {});
    windowMeasurements[roomName]!.putIfAbsent(windowName, () => {});
    windowMeasurements[roomName]![windowName]![type] = value;

    log.i(windowMeasurements);
    notifyListeners();
  }

  /// Update window name
  void updateWindowName({
    required String roomName,
    required String oldWindowName,
    required String newWindowName,
  }) {
    if (windowMeasurements[roomName] != null &&
        windowMeasurements[roomName]!.containsKey(oldWindowName)) {
      var windowData = windowMeasurements[roomName]!.remove(oldWindowName);
      windowMeasurements[roomName]![newWindowName] = windowData!;
    }

    // Update the room's window list
    var room = rooms.firstWhere((element) => element.containsKey(roomName));
    var windows = room[roomName]!;
    int windowIndex = windows.indexOf(oldWindowName);
    if (windowIndex != -1) {
      windows[windowIndex] = newWindowName;
    }

    log.i(windowMeasurements);
    notifyListeners();
  }

  /// Update room name
  void updateRoomName({
    required String oldRoomName,
    required String newRoomName,
  }) {
    if (windowMeasurements.containsKey(oldRoomName)) {
      var roomData = windowMeasurements.remove(oldRoomName);
      windowMeasurements[newRoomName] = roomData!;
    }

    // Update the room list
    var roomIndex =
        rooms.indexWhere((element) => element.containsKey(oldRoomName));
    if (roomIndex != -1) {
      var windows = rooms[roomIndex][oldRoomName]!;
      rooms[roomIndex] = {newRoomName: windows};
    }

    log.i(windowMeasurements);
    notifyListeners();
  }

  /// Add a new room
  void addRoom() {
    int roomCount = rooms.length + 1;
    String roomName = 'Room $roomCount';
    rooms.add({
      roomName: ['Window 1']
    });
    windowMeasurements[roomName] = {};
    notifyListeners();
  }

  /// Add a new window to a specific room
  void addWindow(int roomIndex) {
    String roomName = rooms[roomIndex].keys.first;
    String newWindowName =
        'New Window ${rooms[roomIndex][roomName]!.length + 1}';
    rooms[roomIndex][roomName]?.add(newWindowName);
    windowMeasurements[roomName]?[newWindowName] = {'height': '', 'width': ''};
    notifyListeners();
  }
}
