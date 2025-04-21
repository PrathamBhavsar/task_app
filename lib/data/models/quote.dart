import 'customer.dart';
import 'salesperson.dart';
import 'task.dart';

class Quote {
  final String name;
  final double amount;
  final String createdBy;
  final Customer customer;
  final Salesperson salesperson;
  final String status;
  final Task task;
  final String place;
  final String createdAt;
  final String dueDate;

  Quote({
    required this.name,
    required this.amount,
    required this.createdBy,
    required this.customer,
    required this.salesperson,
    required this.status,
    required this.task,
    required this.place,
    required this.createdAt,
    required this.dueDate,
  });

  // Factory constructor to create a Quote from a Map
  factory Quote.fromMap(Map<String, dynamic> map) => Quote(
    name: map['name'] ?? '',
    amount: (map['amount'] ?? 0).toDouble(),
    createdBy: map['created_by'] ?? '',
    customer: map['customer'] ?? '',
    salesperson: map['salesperson'] ?? '',
    status: map['status'] ?? '',
    task: map['task'] ?? '',
    place: map['place'] ?? '',
    createdAt: map['created_at'] ?? '',
    dueDate: map['due_date'] ?? '',
  );

  // Convert Quote to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'amount': amount,
    'customer': customer,
    'salesperson': salesperson,
    'status': status,
    'task': task,
    'place': place,
    'created_at': createdAt,
    'due_date': dueDate,
  };

  // Sample list of quotes
  static List<Quote> get sampleQuotes => [
    Quote(
      name: "Window Curtains - Hall",
      amount: 5400.00,
      createdBy: "John Doe",
      status: "Approved",
      customer: Customer.sampleCustomers[0],
      salesperson: Salesperson.sampleSalespersons[0],
      task: Task.sampleTasks[0],
      place: "Hall",
      createdAt: "2024-03-10",
      dueDate: "2024-03-15",
    ),
    Quote(
      name: "Blind Fittings - Bedroom",
      amount: 3200.00,
      createdBy: "John Doe",
      customer: Customer.sampleCustomers[1],
      salesperson: Salesperson.sampleSalespersons[1],
      status: "Pending",
      task: Task.sampleTasks[1],
      place: "Bedroom",
      createdAt: "2024-02-22",
      dueDate: "2024-02-28",
    ),
    Quote(
      name: "Motorized Track - Living Room",
      amount: 7800.00,
      createdBy: "Jane Doe",
      customer: Customer.sampleCustomers[2],
      salesperson: Salesperson.sampleSalespersons[2],
      status: "Paid",
      task: Task.sampleTasks[2],
      place: "Living Room",
      createdAt: "2024-01-15",
      dueDate: "2024-01-20",
    ),
  ];

  static List<Quote> get pendingQuotes =>
      sampleQuotes.where((b) => b.status == 'Pending').toList();

  static List<Quote> get approvedQuotes =>
      sampleQuotes.where((b) => b.status == 'Approved').toList();

  static List<Quote> get paidQuotes =>
      sampleQuotes.where((b) => b.status == 'Paid').toList();

  static List<Quote> get rejectedQuotes =>
      sampleQuotes.where((b) => b.status == 'Rejected').toList();
}
