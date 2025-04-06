class Transaction {
  final String name;
  final String time;
  final int amount;
  final String status;

  Transaction({
    required this.name,
    required this.time,
    required this.amount,
    required this.status,
  });

  // Factory constructor to create an Transaction from a Map
  factory Transaction.fromMap(Map<String, dynamic> map) => Transaction(
    name: map['name'],
    time: map['time'],
    amount: map['services'],
    status: map['status'],
  );

  // Convert Transaction to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'time': time,
    'services': amount,
    'status': status,
  };

  // Sample list of appointments
  static List<Transaction> get sampleTransactions => [
    Transaction(
      name: "John Doe",
      time: "10:30 AM - Today",
      amount: 45,
      status: "Completed",
    ),
    Transaction(
      name: "Jane Smith",
      time: "11:00 AM - Today",
      amount: 64,
      status: "Completed",
    ),
    Transaction(
      name: "Alex Johnson",
      time: "1:15 PM - Yesterday",
      amount: 55,
      status: "Completed",
    ),
    Transaction(
      name: "Emily Davis",
      time: "2:45 PM - Yesterday",
      amount: 90,
      status: "Canceled",
    ),
    Transaction(
      name: "Michael Brown",
      time: "4:00 PM - Yesterday",
      amount: 30,
      status: "Completed",
    ),
  ];
}
