import '../../utils/constants/enums/dto_action.dart';
import 'dto.dart';

class GetTasksDTO extends ApiDTO {
  final String id;

  GetTasksDTO({
    required this.id,
  }) : super(action: DtoAction.specific);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
      };
}
