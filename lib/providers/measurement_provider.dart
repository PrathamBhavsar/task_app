import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MeasurementProvider with ChangeNotifier {
  static final MeasurementProvider instance =
      MeasurementProvider._privateConstructor();

  MeasurementProvider._privateConstructor();

  /// Rooms structure: List of maps where key is the room name and value is a list of window names
  List<Map<String, List<String>>> rooms = [];

  /// Measurements structure: Map where key is room name and value is a map of window names and their dimensions
  Map<String, Map<String, Map<String, String>>> windowMeasurements = {};

  var log = Logger();

  /// Update window measurement (height or width)
  void updateWindowMeasurements({
    required String roomName,
    required String windowName,
    required Map<String, String> measurements,
  }) {
    windowMeasurements.putIfAbsent(roomName, () => {});
    windowMeasurements[roomName]!.putIfAbsent(windowName, () => {});

    /// Update all provided measurements (e.g., height and width)
    measurements.forEach((key, value) {
      windowMeasurements[roomName]![windowName]![key] = value;
    });

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

    /// Update the room's window list
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

    /// Update the room list
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
    String newWindowName = 'Window ${rooms[roomIndex][roomName]!.length + 1}';
    rooms[roomIndex][roomName]?.add(newWindowName);
    windowMeasurements[roomName]?[newWindowName] = {'height': '', 'width': ''};
    notifyListeners();
  }

  void deleteRoom(int roomIndex) {
    String roomName = rooms[roomIndex].keys.first;
    rooms.removeAt(roomIndex);
    windowMeasurements.remove(roomName);
    notifyListeners();
  }

  void deleteWindow(int roomIndex, String windowName) {
    String roomName = rooms[roomIndex].keys.first;
    rooms[roomIndex][roomName]?.remove(windowName);
    windowMeasurements[roomName]?.remove(windowName);
    notifyListeners();
  }

  void saveAllChanges(
      roomControllers, windowControllers, heightControllers, widthControllers) {
    rooms.asMap().forEach((roomIndex, room) {
      String oldRoomName = room.keys.first;
      String newRoomName = roomControllers[roomIndex]!.text;

      /// Update room name if it has changed
      if (oldRoomName != newRoomName) {
        updateRoomName(oldRoomName: oldRoomName, newRoomName: newRoomName);
      }

      List<String> windows = room[oldRoomName]!;

      /// Iterate through all windows in the room
      for (var windowName in windows) {
        String newWindowName = windowControllers[roomIndex]![windowName]!.text;
        String height = heightControllers[roomIndex]![windowName]!.text;
        String width = widthControllers[roomIndex]![windowName]!.text;

        /// Update window name if it has changed
        if (windowName != newWindowName) {
          updateWindowName(
            roomName: newRoomName,
            oldWindowName: windowName,
            newWindowName: newWindowName,
          );
        }

        /// Batch update window measurements
        updateWindowMeasurements(
          roomName: newRoomName,
          windowName: newWindowName,
          measurements: {
            'height': height,
            'width': width,
          },
        );
      }
    });
    notifyListeners();
  }
}
