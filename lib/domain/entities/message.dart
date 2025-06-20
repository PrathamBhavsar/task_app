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

}
