class Supervisor {
  final String name;
  final String username;
  final List<String> salons;
  final String createdAt;

  Supervisor({
    required this.name,
    required this.username,
    required this.salons,
    required this.createdAt,
  });

  // Factory constructor to create a Supervisor from a Map
  factory Supervisor.fromMap(Map<String, dynamic> map) => Supervisor(
    name: map['name'],
    username: map['username'],
    salons: List<String>.from(map['services'] ?? []),
    createdAt: map['created_at'],
  );

  // Convert Supervisor to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'username': username,
    'services': salons,
    'created_at': createdAt,
  };

  // Sample list of supervisors
  static List<Supervisor> get sampleSupervisors => [
    Supervisor(
      name: "John Doe",
      username: "john_doe",
      salons: ["Elite Cuts", "Classic Styles"],
      createdAt: "12th Jul 2025",
    ),
    Supervisor(
      name: "Jane Smith",
      username: "jane_smith",
      salons: ["Glamour Salon", "Luxury Nails"],
      createdAt: "19th Jan 2025",
    ),
    Supervisor(
      name: "Alex Johnson",
      username: "alex_johnson",
      salons: ["Beard Masters", "Shave & Trim"],
      createdAt: "15th Mar 2024",
    ),
    Supervisor(
      name: "Emily Davis",
      username: "emily_davis",
      salons: ["Glow Spa", "Color Magic"],
      createdAt: "10th Mar 2024",
    ),
    Supervisor(
      name: "Michael Brown",
      username: "michael_brown",
      salons: ["Relax & Refresh", "Prime Cuts"],
      createdAt: "5th Mar 2024",
    ),
  ];
  static List<String> get names =>
      sampleSupervisors.map((s) => s.name).toList();
}
