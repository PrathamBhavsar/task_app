class ClientModel {
  final String? id;
  final String name;
  final String address;
  final String? taskId;
  final String contactNo;
  final DateTime? createdAt;

  ClientModel({
    this.id,
    required this.name,
    required this.address,
    this.taskId,
    required this.contactNo,
    this.createdAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contactNo: json['contact_no'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'contact_no': contactNo,
    };
  }
}
