class DesignerModel {
  final String? id;
  final int code;
  final String name;
  final String address;
  final String? taskId;
  final String firmName;
  final String contactNo;
  final DateTime? createdAt;

  DesignerModel({
    this.id,
    required this.code,
    required this.name,
    required this.address,
    this.taskId,
    required this.firmName,
    required this.contactNo,
    this.createdAt,
  });

  factory DesignerModel.fromJson(Map<String, dynamic> json) => DesignerModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      taskId: json['task_id'],
      firmName: json['firm_name'],
      contactNo: json['contact_no'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );

  Map<String, dynamic> toJson() => {
      'code': code,
      'name': name,
      'address': address,
      'firm_name': firmName,
      'contact_no': contactNo,
    };
}
