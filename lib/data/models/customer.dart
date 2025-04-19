class Customer {
  final String name;
  final String phone;
  final int orders;
  final String status;
  final String totalSpent;
  final String email;
  final String createdAt;

  Customer({
    required this.name,
    required this.phone,
    required this.orders,
    required this.status,
    required this.totalSpent,
    required this.email,
    required this.createdAt,
  });

  // Factory constructor to create a Customer from a Map
  factory Customer.fromMap(Map<String, dynamic> map) => Customer(
    name: map['name'] ?? '',
    phone: map['phone'] ?? '',
    orders: map['orders'] ?? 0,
    status: map['status'] ?? '',
    totalSpent: map['totalSpent'] ?? '',
    email: map['email'] ?? '',
    createdAt: map['created_at'] ?? '',
  );

  // Convert Customer to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'orders': orders,
    'status': status,
    'totalSpent': totalSpent,
    'email': email,
    'created_at': createdAt,
  };

  // Sample list of customers
  static List<Customer> get sampleCustomers => [
    Customer(
      name: "Sarah Johnson",
      phone: "+91 9876543210",
      orders: 5,
      status: "Active",
      totalSpent: "₹12,500",
      email: "sarah.johnson@example.com",
      createdAt: "2024-03-10",
    ),
    Customer(
      name: "Liam Smith",
      phone: "+91 9123456789",
      orders: 2,
      status: "Inactive",
      totalSpent: "₹4,200",
      email: "liam.smith@example.com",
      createdAt: "2024-02-22",
    ),
    Customer(
      name: "Emily Davis",
      phone: "+91 9988776655",
      orders: 7,
      status: "Active",
      totalSpent: "₹18,700",
      email: "emily.davis@example.com",
      createdAt: "2024-01-15",
    ),
  ];
  static List<String> get names => sampleCustomers.map((a) => a.name).toList();

}
