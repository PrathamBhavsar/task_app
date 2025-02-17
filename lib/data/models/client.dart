class Client {
  final String id;
  final String name;
  final String address;
  final String contactNo;
  final DateTime createdAt;

  Client({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNo,
    required this.createdAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        contactNo: json['contact_no'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'contact_no': contactNo,
        'created_at': createdAt.toIso8601String(),
      };
}
