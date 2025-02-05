import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../helpers/number_helper.dart';
import '../models/measurement.dart';

class MeasurementProvider with ChangeNotifier {
  static final MeasurementProvider _instance =
      MeasurementProvider._privateConstructor();

  MeasurementProvider._privateConstructor();

  static MeasurementProvider get instance => _instance;

  /// Rooms structure: List of maps where key is the room name and value is a list of window names
  List<Map<String, List<String>>> rooms = [];

  /// Measurements structure: Map where key is room name and value is a map of window names and their dimensions
  Map<String, Map<String, Map<String, String>>> windowMeasurements = {};

  var log = Logger();

  List<XFile> pickedPhotos = [];

  List<String> dropdownItems = [
    'Stitching - Full',
    'Stitching - Half',
    'Steaming - Full',
    'Steaming - Half',
    'Fitting'
  ];

  void deletePickedImage(int index) {
    pickedPhotos.removeAt(index);
    notifyListeners();
  }

  Future<void> pickImages(ImageSource source) async {
    ImagePicker picker = ImagePicker();

    if (source == ImageSource.camera) {
      final pickedPhoto = await picker.pickImage(
          source: source, imageQuality: 25, requestFullMetadata: true);
      pickedPhotos.add(pickedPhoto!);
    } else {
      pickedPhotos = await picker.pickMultiImage(
          limit: 5, imageQuality: 25, requestFullMetadata: true);
    }

    log.d(pickedPhotos.length);
    notifyListeners();
  }

  List<AdditionalCost> _costs = [];

  Map<int, TextEditingController> nameControllers = {};
  Map<int, TextEditingController> rateControllers = {};
  Map<int, TextEditingController> qtyControllers = {};

  List<AdditionalCost> get costs => _costs;

  double get totalAdditionalCost =>
      _costs.fold(0, (sum, item) => sum + item.total);

  void addCost() {
    int index = _costs.length;
    _costs.add(AdditionalCost(name: '', rate: 0, qty: 0));

    // Initialize controllers
    nameControllers[index] = TextEditingController();
    rateControllers[index] = TextEditingController();
    qtyControllers[index] = TextEditingController();

    notifyListeners();
  }

  void removeCost() {
    if (_costs.isNotEmpty) {
      int lastIndex = _costs.length - 1;
      _costs.removeAt(lastIndex);
      nameControllers.remove(lastIndex);
      rateControllers.remove(lastIndex);
      qtyControllers.remove(lastIndex);
      notifyListeners();
    }
  }

  void updateCost(int index, {String? name, double? rate, double? qty}) {
    final cost = _costs[index];
    if (name != null) {
      cost.name = name;
      nameControllers[index]?.text = name;
    }
    if (rate != null) {
      cost.rate = rate;
      rateControllers[index]?.text = NumberHelper.format(rate);
    }
    if (qty != null) {
      cost.qty = qty;
      qtyControllers[index]?.text = NumberHelper.format(qty);
    }
    cost.total = cost.rate * cost.qty;
    notifyListeners();
  }

  /// Update window measurement (height or width)
  void updateWindowMeasurements({
    required String roomName,
    required String windowName,
    required Map<String, String> measurements,
  }) {
    windowMeasurements.putIfAbsent(roomName, () => {});
    windowMeasurements[roomName]!.putIfAbsent(windowName, () => {});

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

    notifyListeners();
  }

  /// Add a new room
  void addRoom() {
    int roomCount = rooms.length + 1;
    String roomName = 'Room $roomCount';
    rooms.add({
      roomName: ['Window 1']
    });
    windowMeasurements[roomName] = {
      'Window 1': {
        'height': '',
        'width': '',
        'area': '',
        'type': '',
        'remarks': '',
      },
    };
    notifyListeners();
  }

  void addWindow(int roomIndex) {
    String roomName = rooms[roomIndex].keys.first;
    String newWindowName = 'Window ${rooms[roomIndex][roomName]!.length + 1}';
    rooms[roomIndex][roomName]?.add(newWindowName);
    windowMeasurements[roomName]?[newWindowName] = {
      'height': '',
      'width': '',
      'area': '',
      'type': '',
      'remarks': '',
    };
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
    roomControllers,
    windowControllers,
    heightControllers,
    widthControllers,
    areaControllers,
    typeControllers,
    remarksControllers,
  ) {
    rooms.asMap().forEach((roomIndex, room) {
      String oldRoomName = room.keys.first;
      String newRoomName = roomControllers[roomIndex]!.text;

      // Update room name if changed
      if (oldRoomName != newRoomName) {
        updateRoomName(oldRoomName: oldRoomName, newRoomName: newRoomName);
      }

      List<String> windows = room[oldRoomName]!;
      for (var windowName in windows) {
        // Retrieve all window-related data in a single step
        var controllers = {
          'windowName': windowControllers[roomIndex]![windowName]!,
          'height': heightControllers[roomIndex]![windowName]!,
          'width': widthControllers[roomIndex]![windowName]!,
          'area': areaControllers[roomIndex]![windowName]!,
          'type': typeControllers[roomIndex]![windowName]!,
          'remarks': remarksControllers[roomIndex]![windowName]!,
        };

        String newWindowName = controllers['windowName']!.text;
        String height = controllers['height']!.text;
        String width = controllers['width']!.text;
        String area = controllers['area']!.text;
        String type = controllers['type']!.text;
        String remarks = controllers['remarks']!.text;

        // Update window name if changed
        if (windowName != newWindowName) {
          updateWindowName(
            roomName: newRoomName,
            oldWindowName: windowName,
            newWindowName: newWindowName,
          );
        }

        // Update window measurements
        updateWindowMeasurements(
          roomName: newRoomName,
          windowName: newWindowName,
          measurements: {
            'height': height,
            'width': width,
            'area': area,
            'type': type,
            'remarks': remarks,
          },
        );
      }
    });

    // Notify listeners after saving all changes
    notifyListeners();
  }
}
