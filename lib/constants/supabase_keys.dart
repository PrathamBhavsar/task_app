class SupabaseKeys {
  // Table Names

  static const String usersTable = 'users';
  static const String taskTable = 'tasks';
  static const String taskAttachmentsTable = 'task_attachments';
  static const String taskClientsTable = 'task_clients';
  static const String taskDesignersTable = 'task_designers';
  static const String taskCommentsTable = 'task_comments';

  // Column Names for 'task' Table
  static const String taskId = 'task_id';
  static const String taskCreatedBy = 'created_by';
  static const String taskPriority = 'priority';
  static const String taskTitle = 'title';
  static const String taskDueDate = 'due_date';
  static const String taskStatus = 'status';
  static const String taskProgress = 'progress';
  static const String taskDealNo = 'deal_no';

  static const String userId = 'user_id';

  static const String attachmentUrl = 'attachment_url';

  static const String clientId = 'client_id';

  static const String designerId = 'designer_id';

  static const String commentText = 'comment';
}
