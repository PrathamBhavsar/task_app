import '../../utils/extensions/date_formatter.dart';
import 'message.dart';

class Task {
  final String name;
  final String phone;
  final String product;
  final String status;
  final String priority;
  final String? note;
  final String? agency;
  final String customer;
  final String dueDate;
  final String createdAt;
  final List<Message> messages;

  Task({
    required this.name,
    required this.phone,
    required this.product,
    required this.status,
    required this.priority,
    this.note,
    this.agency,
    required this.customer,
    required this.dueDate,
    required this.createdAt,
    required this.messages,
  });

  // Factory constructor to create a Task from a Map
  factory Task.fromMap(Map<String, dynamic> map) => Task(
    name: map['name'],
    phone: map['phone'],
    product: map['product'],
    status: map['status'],
    priority: map['priority'],
    note: map['note'],
    agency: map['agency'],
    customer: map['customer'],
    dueDate: map['due_date'],
    createdAt: map['created_at'],
    messages: map['messages'],
  );

  // Convert Task to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'product': product,
    'status': status,
    'priority': priority,
    'note': note,
    'agency': agency,
    'customer': customer,
    'due_date': dueDate,
    'created_at': createdAt,
  };

  // Sample list of supervisors
  static List<Task> get sampleTasks => [
    Task(
      name: "Custom Blind Selection",
      phone: "+91 789564231",
      product: "Custom Blinds",
      status: "Pending",
      priority: "High",
      agency: "InstallMate Co.",
      customer: "Sarah Johnson",
      note:
          "Customer is interested in custom blinds for their living room and bedroom. They prefer neutral colors and are concerned about light filtering capabilities.",
      dueDate: "20th Apr 2025",
      createdAt: "25th Mar 2025",
      messages: Message.randomMessages,
    ),
    Task(
      name: "Window Measurement",
      customer: "Liam Smith",
      phone: "+91 789564231",
      product: "Custom Blinds",
      status: "Completed",
      priority: "High",
      agency: "MeasurePro Services",
      note:
          "Customer is interested in custom blinds for their living room and bedroom. They prefer neutral colors and are concerned about light filtering capabilities.",
      dueDate: "20th Apr 2025",
      createdAt: "25th Mar 2025",
      messages: Message.randomMessages,
    ),
    Task(
      name: "Roller Shades Quote",
      customer: "Emily Davis",
      phone: "+91 789564231",
      product: "Custom Blinds",
      status: "Product Selection",
      priority: "High",
      agency: "BlindExperts",
      note:
          "Customer is interested in custom blinds for their living room and bedroom. They prefer neutral colors and are concerned about light filtering capabilities.",
      dueDate: "20th Apr 2025",
      createdAt: "25th Mar 2025",
      messages: Message.randomMessages,
    ),
  ];

  factory Task.empty() => Task(
    name: 'Task Name',
    customer: 'Customer Name',
    product: 'Product Name',
    status: 'Pending',
    priority: 'Low',
    dueDate: "Task's Due Date",
    createdAt: DateTime.now().toFormattedWithSuffix(),
    note: 'Add a note',
    agency: 'Agency',
    phone: 'Phone No.',
    messages: Message.randomMessages,
  );

  static List<Task> get completedTasks =>
      sampleTasks.where((t) => t.status == 'Completed').toList();

  static List<Task> get pendingTasks =>
      sampleTasks.where((t) => t.status != 'Completed').toList();

  static List<String> get statuses => sampleTasks.map((a) => a.status).toList();
}
