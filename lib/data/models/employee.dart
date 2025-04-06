class Employee {
  final String name;
  final String service;
  final String createdAt;

  Employee({
    required this.name,
    required this.service,
    required this.createdAt,
  });

  // Factory constructor to create a Employee from a Map
  factory Employee.fromMap(Map<String, dynamic> map) => Employee(
    name: map['name'],
    service: map['salon'],
    createdAt: map['created_at'],
  );

  // Convert Employee to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'salon': service,
    'created_at': createdAt,
  };

  // Sample list of supervisors
  static List<Employee> get sampleEmployees => [
    Employee(name: "John Doe", service: "Stylist", createdAt: "25th Mar 2024"),
    Employee(
      name: "Jane Smith",
      service: "Colorist",
      createdAt: "20th Mar 2024",
    ),
    Employee(
      name: "Alex Johnson",
      service: "Barber",
      createdAt: "15th Mar 2024",
    ),
    Employee(
      name: "Emily Davis",
      service: "Nail Technician",
      createdAt: "10th Mar 2024",
    ),
    Employee(
      name: "Michael Brown",
      service: "Massage Therapist",
      createdAt: "5th Mar 2024",
    ),
  ];
  static List<String> get names => sampleEmployees.map((e) => e.name).toList();
}
