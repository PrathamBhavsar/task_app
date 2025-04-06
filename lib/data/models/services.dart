class Service {
  final String name;
  final String time;
  final int amount;

  Service({required this.name, required this.time, required this.amount});

  // Factory constructor to create an Service from a Map
  factory Service.fromMap(Map<String, dynamic> map) =>
      Service(name: map['name'], time: map['time'], amount: map['services']);

  // Convert Service to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'time': time,
    'services': amount,
  };

  // Sample list of appointments
  static List<Service> get sampleServices => [
    Service(name: "Haircut", time: "30 min", amount: 20),
    Service(name: "Styling", time: "20 min", amount: 25),
    Service(name: "Coloring", time: "60 min", amount: 15),
    Service(name: "Facial", time: "45 min", amount: 10),
    Service(name: "Manicure", time: "15 min", amount: 18),
  ];

  static List<String> get names => sampleServices.map((s) => s.name).toList();
}
