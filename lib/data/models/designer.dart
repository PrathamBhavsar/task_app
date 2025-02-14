class Designer {
  final String id;
  final int code;
  final String name;
  final String firmName;
  final String address;
  final String contactNo;
  final DateTime createdAt;
  final String profileBgColor;

  Designer({
    required this.id,
    required this.code,
    required this.name,
    required this.firmName,
    required this.address,
    required this.contactNo,
    required this.createdAt,
    required this.profileBgColor,
  });

  factory Designer.fromJson(Map<String, dynamic> json) => Designer(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        firmName: json['firm_name'],
        address: json['address'],
        contactNo: json['contact_no'],
        createdAt: DateTime.parse(json['created_at']),
        profileBgColor: json['profile_bg_color'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'firm_name': firmName,
        'address': address,
        'contact_no': contactNo,
        'created_at': createdAt.toIso8601String(),
        'profile_bg_color': profileBgColor,
      };
}
