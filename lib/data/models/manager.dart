class Manager {
  final String name;
  final String username;
  final String salon;
  final String createdAt;

  Manager({
    required this.name,
    required this.username,
    required this.salon,
    required this.createdAt,
  });

  // Factory constructor to create a Manager from a Map
  factory Manager.fromMap(Map<String, dynamic> map) => Manager(
    name: map['name'],
    username: map['username'],
    salon: map['salon'],
    createdAt: map['created_at'],
  );

  // Convert Manager to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'username': username,
    'salon': salon,
    'created_at': createdAt,
  };

  // Sample list of supervisors
  static List<Manager> get sampleManagers => [
    Manager(
      name: "John Doe",
      username: "john_doe",
      salon: "Elite Cuts",
      createdAt: "25th Mar 2024",
    ),
    Manager(
      name: "Jane Smith",
      username: "jane_smith",
      salon: "Glamour Salon",
      createdAt: "20th Mar 2024",
    ),
    Manager(
      name: "Alex Johnson",
      username: "alex_johnson",
      salon: "Beard Masters",
      createdAt: "15th Mar 2024",
    ),
    Manager(
      name: "Emily Davis",
      username: "emily_davis",
      salon: "Color Magic",
      createdAt: "10th Mar 2024",
    ),
    Manager(
      name: "Michael Brown",
      username: "michael_brown",
      salon: "Prime Cuts",
      createdAt: "5th Mar 2024",
    ),
  ];
}
