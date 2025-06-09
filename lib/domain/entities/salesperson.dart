class Salesperson {
  final String name;
  final String phone;
  final String status;
  final String email;
  final String createdAt;

  Salesperson({
    required this.name,
    required this.phone,
    required this.status,
    required this.email,
    required this.createdAt,
  });

  // Factory constructor to create a Salesperson from a Map
  factory Salesperson.fromMap(Map<String, dynamic> map) => Salesperson(
    name: map['name'] ?? '',
    phone: map['phone'] ?? '',
    status: map['status'] ?? '',
    email: map['email'] ?? '',
    createdAt: map['created_at'] ?? '',
  );

  // Convert Salesperson to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'status': status,
    'email': email,
    'created_at': createdAt,
  };

  // Sample list of salespersons
  static List<Salesperson> get sampleSalespersons => [
    Salesperson(
      name: "Sarah Johnson",
      phone: "+91 9876543210",
      status: "Active",
      email: "sarah.johnson@example.com",
      createdAt: "2024-03-10",
    ),
    Salesperson(
      name: "Liam Smith",
      phone: "+91 9123456789",
      status: "Inactive",
      email: "liam.smith@example.com",
      createdAt: "2024-02-22",
    ),
    Salesperson(
      name: "Emily Davis",
      phone: "+91 9988776655",
      status: "Active",
      email: "emily.davis@example.com",
      createdAt: "2024-01-15",
    ),
  ];
  static List<String> get names =>
      sampleSalespersons.map((a) => a.name).toList();
}
