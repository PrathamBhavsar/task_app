class Appointment {
  final String name;
  final String time;
  final String services;
  final String status;

  Appointment({
    required this.name,
    required this.time,
    required this.services,
    required this.status,
  });

  // Factory constructor to create an Appointment from a Map
  factory Appointment.fromMap(Map<String, dynamic> map) => Appointment(
    name: map['name'],
    time: map['time'],
    services: map['services'],
    status: map['status'],
  );

  // Convert Appointment to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'time': time,
    'services': services,
    'status': status,
  };

  // Sample list of appointments
  static List<Appointment> get sampleAppointments => [
    Appointment(
      name: "John Doe",
      time: "10:30 AM",
      services: "Haircut, Styling",
      status: "Completed",
    ),
    Appointment(
      name: "Jane Smith",
      time: "11:00 AM",
      services: "Manicure, Pedicure",
      status: "Waiting",
    ),
    Appointment(
      name: "Alex Johnson",
      time: "1:15 PM",
      services: "Beard Trim, Shave",
      status: "Completed",
    ),
    Appointment(
      name: "Emily Davis",
      time: "2:45 PM",
      services: "Facial, Hair Coloring",
      status: "Waiting",
    ),
    Appointment(
      name: "Michael Brown",
      time: "4:00 PM",
      services: "Massage, Haircut",
      status: "Waiting",
    ),
  ];
  static List<String> get names =>
      sampleAppointments.map((a) => a.name).toList();

  static List<Appointment> get waiting =>
      sampleAppointments.where((a) => a.status == "Waiting").toList();

  static List<Appointment> get completed =>
      sampleAppointments.where((a) => a.status == "Completed").toList();
}
