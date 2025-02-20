import '../../utils/constants/enums/dto_action.dart';
import 'dto.dart';

class CreateTaskDTO extends ApiDTO {
  final String dealNo;
  final String name;
  final DateTime startDate;
  final DateTime dueDate;
  final String priority;
  final String createdBy;
  final String remarks;
  final String status;
  final List<String> clients;
  final List<String> designers;
  final List<String> agencies;
  final List<String> salespersons;
  final List<AttachmentDTO> attachments;

  CreateTaskDTO({
    required this.dealNo,
    required this.name,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.createdBy,
    required this.remarks,
    required this.status,
    required this.clients,
    required this.designers,
    required this.agencies,
    required this.salespersons,
    required this.attachments,
  }) : super(action: DtoAction.create);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "deal_no": dealNo,
        "name": name,
        "start_date": startDate.toIso8601String(),
        "due_date": dueDate.toIso8601String(),
        "priority": priority,
        "created_by": createdBy,
        "remarks": remarks,
        "status": status,
        "clients": clients,
        "designers": designers,
        "agencies": agencies,
        "salespersons": salespersons,
        "attachments":
            attachments.map((attachment) => attachment.toJson()).toList(),
      };
}

class AttachmentDTO {
  final String url;
  final String name;

  AttachmentDTO({required this.url, required this.name});

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
      };
}
