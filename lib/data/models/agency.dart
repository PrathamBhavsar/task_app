class Agency {
  final String name;
  final String contactPerson;
  final String phone;
  final String address;
  final String contractDate;
  final List<String> serviceAreas;
  final List<String> specialities;
  final double rating; // out of 5
  final String status;
  final int pendingTasks;
  final String totalSpent;
  final String email;
  final String createdAt;

  Agency({
    required this.name,
    required this.contactPerson,
    required this.phone,
    required this.address,
    required this.contractDate,
    required this.serviceAreas,
    required this.specialities,
    required this.rating,
    required this.status,
    required this.pendingTasks,
    required this.totalSpent,
    required this.email,
    required this.createdAt,
  });

  // Factory constructor to create an Agency from a Map
  factory Agency.fromMap(Map<String, dynamic> map) => Agency(
    name: map['name'] ?? '',
    contactPerson: map['contact_person'] ?? '',
    phone: map['phone'] ?? '',
    address: map['address'] ?? '',
    contractDate: map['contract_date'] ?? '',
    serviceAreas: List<String>.from(map['service_areas'] ?? []),
    specialities: List<String>.from(map['specialities'] ?? []),
    rating: (map['rating'] ?? 0).toDouble(),
    status: map['status'] ?? '',
    pendingTasks: map['pending_tasks'] ?? 0,
    totalSpent: map['total_spent'] ?? '',
    email: map['email'] ?? '',
    createdAt: map['created_at'] ?? '',
  );

  // Convert Agency to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'contact_person': contactPerson,
    'phone': phone,
    'address': address,
    'contract_date': contractDate,
    'service_areas': serviceAreas,
    'specialities': specialities,
    'rating': rating,
    'status': status,
    'pending_tasks': pendingTasks,
    'total_spent': totalSpent,
    'email': email,
    'created_at': createdAt,
  };

  // Sample list of Agencies
  static List<Agency> get sampleAgencys => [
    Agency(
      name: "MeasurePro Services",
      contactPerson: "Raj Mehta",
      phone: "+91 9876543210",
      address: "123 MG Road, Mumbai",
      contractDate: "2024-01-10",
      serviceAreas: ["Mumbai", "Thane"],
      specialities: ["Window Measurements", "Custom Installations"],
      rating: 4.5,
      status: "Active",
      pendingTasks: 3,
      totalSpent: "₹32,000",
      email: "contact@measurepro.com",
      createdAt: "2024-01-15",
    ),
    Agency(
      name: "InstallMate Co.",
      contactPerson: "Neha Kapoor",
      phone: "+91 9123456789",
      address: "56 Residency Rd, Bengaluru",
      contractDate: "2023-11-01",
      serviceAreas: ["Bangalore", "Mysore"],
      specialities: ["Blind Installation", "Curtain Fixing"],
      rating: 4.2,
      status: "Active",
      pendingTasks: 1,
      totalSpent: "₹18,500",
      email: "support@installmate.in",
      createdAt: "2023-11-05",
    ),
    Agency(
      name: "BlindExperts",
      contactPerson: "Amit Sinha",
      phone: "+91 9988776655",
      address: "78 Park Street, Kolkata",
      contractDate: "2024-03-01",
      serviceAreas: ["Kolkata", "Howrah"],
      specialities: ["Motorized Blinds", "Smart Shade Solutions"],
      rating: 4.8,
      status: "Inactive",
      pendingTasks: 0,
      totalSpent: "₹50,000",
      email: "info@blindexperts.in",
      createdAt: "2024-03-03",
    ),
  ];
}
