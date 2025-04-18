class Measurement {
  final String location;
  final double width;
  final double height;
  final String note;

  Measurement({
    required this.location,
    required this.width,
    required this.height,
    required this.note,
  });

  // Factory constructor to create a Measurement from a Map
  factory Measurement.fromMap(Map<String, dynamic> map) => Measurement(
    location: map['location'] ?? '',
    width: (map['width'] ?? 0.00),
    height: map['height'] ?? '',
    note: map['note'] ?? '',
  );

  // Convert Measurement to Map
  Map<String, dynamic> toMap() => {
    'location': location,
    'width': width,
    'height': height,
    'note': note,
  };

  static Measurement get empty =>
      Measurement(location: '', width: 0.00, height: 0.00, note: '');
}
