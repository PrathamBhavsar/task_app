import '../constants/enums/dto_action.dart';

abstract class ApiDTO {
  final DtoAction action;

  ApiDTO({required this.action});

  Map<String, dynamic> toJson();
}
