import 'dart:math';

class Message {
  final String name;
  final String message;
  final String createdAt;

  Message({required this.name, required this.message, required this.createdAt});

  // Factory constructor to create a Message from a Map
  factory Message.fromMap(Map<String, dynamic> map) => Message(
    name: map['name'] ?? '',
    message: map['message'] ?? '',
    createdAt: map['created_at'] ?? '',
  );

  // Convert Message to Map
  Map<String, dynamic> toMap() => {
    'name': name,
    'message': message,
    'created_at': createdAt,
  };

  // Sample list of Messages
  static List<Message> get sampleMessages => [
    Message(
      name: "John Doe",
      message:
          "Hi Sarah, I've sent you some blind samples as requested. Let me know if you have any questions!",
      createdAt: "Nov 12",
    ),
    Message(
      name: "Sarah Johnson",
      message:
          "Thanks for the samples! I really like the beige option for the living room. Can we schedule a time to discuss the bedroom options?",
      createdAt: "Nov 3",
    ),
    Message(
      name: "Guest",
      message: "Thanks! I really like the beige",
      createdAt: "Apr 12",
    ),
    Message(
      name: "Emily Carter",
      message:
          "The curtain measurements look perfect. Please proceed with the installation next week.",
      createdAt: "Dec 15",
    ),
    Message(name: "Guest", message: "Pending", createdAt: "2024-02-05"),
  ];

  static List<Message> get randomMessages {
    sampleMessages.shuffle(Random());
    return sampleMessages.take(3).toList();
  }
}
