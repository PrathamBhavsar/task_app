class SupabaseKeys {
  // Table Names

  static const String usersTable = 'users';
  static const String taskTable = 'tasks';
  static const String configTable = 'config';
  static const String taskAttachmentsTable = 'task_attachments';
  static const String taskClientsTable = 'task_clients';
  static const String taskAgenciesTable = 'task_agencies';
  static const String taskSalespersonsTable = 'task_salespersons';
  static const String clientsTable = 'clients';
  static const String taskDesignersTable = 'task_designers';
  static const String designersTable = 'designers';
  static const String taskCommentsTable = 'task_comments';
  static const String taskStatusTable = 'task_status';
  static const String taskPriorityTable = 'task_priority';

  // Column Names for 'task' Table
  static const String taskId = 'task_id';
  static const String taskCreatedBy = 'created_by';
  static const String taskPriority = 'priority';
  static const String taskTitle = 'title';
  static const String taskDueDate = 'due_date';
  static const String taskStatus = 'status';
  static const String taskProgress = 'progress';
  static const String taskDealNo = 'deal_no';

  static const String id = 'id';

  static const String userId = 'user_id';

  static const String attachmentUrl = 'attachment_url';

  static const String clientId = 'client_id';

  static const String designerId = 'designer_id';

  static const String taskCounterKey = 'task_counter';
  static const String lastUpdatedYearKey = 'last_updated_year';
}

class AppKeys {
  static const String fetchedUnopenedTasks = 'unopened_tasks';
  static const String fetchedPendingTasks = 'pending_tasks';
  static const String fetchedSharedTasks = 'shared_tasks';
  static const String fetchedPaymentTasks = 'payment_tasks';
  static const String fetchedQuotationTasks = 'quotation_tasks';
  static const String fetchedCompleteTasks = 'complete_tasks';

  static const String fetchedSalespersons = 'salespersons';
  static const String fetchedClients = 'clients';
  static const String fetchedAgencies = 'agencies';
  static const String fetchedDesigners = 'designers';

  static const String fetchedPriority = 'task_priority';
  static const String fetchedStatus = 'task_status';

  static const String status = 'status';
  static const String priority = 'priority';

  static const String statusSlug = 'slug';

  static const String color = 'color';
  static const String name = 'name';
}

class UserDetails {
  static const String profileBgColor = 'profile_bg_color';
  static const String name = 'name';
}

class IndexKeys {
  static const String salespersonIndex = 'salespersons';
  static const String agencyIndex = 'agency';
  static const String designerIndex = 'designers';
  static const String clientIndex = 'client';
  static const String statusIndex = 'status';
  static const String priorityIndex = 'priority';
}

class FunctionKeys {
  /// supabase functions
  static const String updateTaskAssociationsFunc = 'update_task_associations';
  static const String taskIdParam = 'p_task_id';
  static const String clientIdParam = 'p_client_id';
  static const String salespersonIdsParam = 'salesperson_ids';
  static const String agencyIdsParam = 'agency_ids';
  static const String designerIdsParam = 'designer_ids';

  static const String getTaskByDealNoFunc = 'get_task_by_deal_no';
  static const String dealNoParam = 'deal_no_input';

  static const String getSalesTasksFunc = 'get_sales_tasks';
  static const String getAgencyTasksFunc = 'get_agency_tasks';
  static const String userIdParam = '_user_id';
}

class TaskKeys {
  static const String taskSalespersons = 'task_salespersons';
  static const String taskClients = 'task_clients';
  static const String taskAgencies = 'task_agencies';
  static const String taskDesigners = 'task_designers';
  static const String taskUserIds = 'user_ids';

  static const String taskPriority = 'priority';
  static const String taskStatus = 'status';
}
