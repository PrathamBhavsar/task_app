class AttachmentModel {
  final String? id;
  final String? taskId;
  final DateTime? createdAt;
  final String attachmentUrl;
  final String attachmentName;

  AttachmentModel({
    this.id,
    this.taskId,
    this.createdAt,
    required this.attachmentUrl,
    required this.attachmentName,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => AttachmentModel(
      id: json['id'],
      taskId: json['task_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      attachmentUrl: json['attachment_url'],
      attachmentName: json['attachment_name'],
    );

  Map<String, dynamic> toJson() => {
      'attachment_url': attachmentUrl,
      'attachment_name': attachmentName,
    };
}
