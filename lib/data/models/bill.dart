class Bill {
  final String name;
  final double amount;
  final String agency;
  final String status;
  final String task;
  final String place;
  final String createdAt;
  final String dueDate;

  Bill({
    required this.name,
    required this.amount,
    required this.agency,
    required this.status,
    required this.task,
    required this.place,
    required this.createdAt,
    required this.dueDate,
  });

  // Factory constructor to create a Bill from a Map
  factory Bill.fromMap(Map<String, dynamic> map) => Bill(
    name: map['name'] ?? '',
    amount: (map['amount'] ?? 0).toDouble(),
    agency: map['agency'] ?? '',
    status: map['status'] ?? '',
    task: map['task'] ?? '',
    place: map['place'] ?? '',
    createdAt: map['created_at'] ?? '',
    dueDate: map['due_date'] ?? '',
  );

  // Convert Bill to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'amount': amount,
    'agency': agency,
    'status': status,
    'task': task,
    'place': place,
    'created_at': createdAt,
    'due_date': dueDate,
  };

  // Sample list of bills
  static List<Bill> get sampleBills => [
    Bill(
      name: "Window Curtains - Hall",
      amount: 5400.0,
      agency: "InstallMate Co.",
      status: "Paid",
      task: "Curtain Installation",
      place: "Hall",
      createdAt: "2024-03-10",
      dueDate: "2024-03-15",
    ),
    Bill(
      name: "Blind Fittings - Bedroom",
      amount: 3200.0,
      agency: "BlindExperts",
      status: "Pending",
      task: "Blind Fixing",
      place: "Bedroom",
      createdAt: "2024-02-22",
      dueDate: "2024-02-28",
    ),
    Bill(
      name: "Motorized Track - Living Room",
      amount: 7800.0,
      agency: "MeasurePro Services",
      status: "Pending",
      task: "Motorized Curtain Install",
      place: "Living Room",
      createdAt: "2024-01-15",
      dueDate: "2024-01-20",
    ),
  ];

  static List<Bill> get pendingBills =>
      sampleBills.where((b) => b.status == 'Pending').toList();

  static List<Bill> get approvedBills =>
      sampleBills.where((b) => b.status == 'Approved').toList();
  static List<Bill> get paidBills =>
      sampleBills.where((b) => b.status == 'Paid').toList();
  static List<Bill> get rejectedBills =>
      sampleBills.where((b) => b.status == 'Rejected').toList();
}
