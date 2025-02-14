abstract class ApiDTO {
  final String action;

  ApiDTO({required this.action});

  Map<String, dynamic> toJson();
}
