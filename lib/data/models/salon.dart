class Salon {
  final String name;
  final String address;
  final String manager;
  final String? supervisor;
  final String createdAt;

  Salon({
    required this.name,
    required this.address,
    required this.manager,
    required this.createdAt,
    this.supervisor,
  });

  // Factory constructor to create a Salon from a Map
  factory Salon.fromMap(Map<String, dynamic> map) => Salon(
    name: map['name'],
    address: map['salon'],
    manager: map['manager'],
    supervisor: map['supervisor'],
    createdAt: map['created_at'],
  );

  // Convert Salon to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'address': address,
    'manager': manager,
    'supervisor': supervisor,
    'created_at': createdAt,
  };

  // Sample list of supervisors
  static List<Salon> get sampleSalons => [
    Salon(
      name: "Downtown Salon",
      address: "123 Main St, Downtown",
      manager: "John Doe",
      supervisor: "Jhon Doe",
      createdAt: "25th Mar 2024",
    ),
    Salon(
      name: "Westside Styling",
      address: "456 Park Ave, Uptown",
      manager: "Alex Johnson",
      supervisor: "David Kim",
      createdAt: "20th Mar 2024",
    ),
    Salon(
      name: "Uptown Beauty",
      address: "789 West Blvd, Westside",
      manager: "Emily Davis",
      createdAt: "15th Mar 2024",
    ),
  ];
}
