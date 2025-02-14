import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/app_keys.dart';
import '../../core/constants/enums.dart';
import 'auth_controller.dart';
import '../models/task.dart';
import '../models/user.dart';

class SupabaseController {
  static final SupabaseController instance =
      SupabaseController._privateConstructor();
  SupabaseController._privateConstructor();

  final supabase = Supabase.instance.client;
  final Logger log = Logger();

  Future<void> downloadAttachment(String fileName, dealNo) async {
    final Uint8List file =
        await supabase.storage.from('bucket').download("$dealNo/$fileName");
  }

  /// fetches overall counts
  Future<Map<String, dynamic>> getOverallCounts() async =>
      await _executeQuery(() async {
        final UserModel? user = await AuthController.instance.getLoggedInUser();
        final response = await supabase.rpc(
          'get_status_counts',
          params: {FunctionKeys.userIdParam: user!.id},
        ).single();

        return response;
      }) ??
      {};

  /// creates a task in supabase
  Future<void> createTask({
    required String name,
    required String remarks,
    required String status,
    required DateTime dueDate,
    required String priority,
    required DateTime startDate,
    required Map<String, dynamic> selectedClientId,
    required List<String> selectedSalespersonIds,
    required List<String> selectedAgencyIds,
    required List<String> selectedDesignerIds,
  }) async {
    final String createdBy = supabase.auth.currentUser!.id;
    final String dealNo = await getNextDealNo();

    final task = TaskModel(
      name: name,
      status: status,
      dealNo: dealNo,
      remarks: remarks,
      dueDate: dueDate,
      priority: priority,
      createdBy: createdBy,
      startDate: startDate,
    );
    await _executeQuery(() async {
      final response = await supabase
          .from(SupabaseKeys.taskTable)
          .insert(task.toJson())
          .select(SupabaseKeys.id)
          .single();

      await createUsers(
        taskId: response[SupabaseKeys.id],
        clientIdsList: selectedClientId,
        selectedSalespersonIds: selectedSalespersonIds,
        selectedAgencyIds: selectedAgencyIds,
        selectedDesignerIds: selectedDesignerIds,
      );
      return response;
    });
  }

  /// create user entries
  Future<void> createUsers({
    required String taskId,
    required Map<String, dynamic> clientIdsList,
    required List<String> selectedSalespersonIds,
    required List<String> selectedAgencyIds,
    required List<String> selectedDesignerIds,
  }) async {
    await _executeQuery(() async {
      // Insert client into the taskClientsTable
      await supabase.from(SupabaseKeys.taskClientsTable).insert({
        SupabaseKeys.clientId: clientIdsList[SupabaseKeys.id],
        SupabaseKeys.taskId: taskId,
      });

      // Insert salespersons into the taskSalespersonsTable
      for (String salespersonId in selectedSalespersonIds) {
        await supabase.from(SupabaseKeys.taskSalespersonsTable).insert({
          SupabaseKeys.userId: salespersonId,
          SupabaseKeys.taskId: taskId,
        });
      }

      // Insert agencies into the taskAgenciesTable
      for (String agencyId in selectedAgencyIds) {
        await supabase.from(SupabaseKeys.taskAgenciesTable).insert({
          SupabaseKeys.userId: agencyId,
          SupabaseKeys.taskId: taskId,
        });
      }

      // Insert designers into the taskDesignersTable
      for (String designerId in selectedDesignerIds) {
        await supabase.from(SupabaseKeys.taskDesignersTable).insert({
          SupabaseKeys.designerId: designerId,
          SupabaseKeys.taskId: taskId,
        });
      }
    });
  }

  Future<void> updateTaskAssociations({
    required String taskId,
    required String clientId,
    required List<String> salespersonIds,
    required List<String> agencyIds,
    required List<String> designerIds,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      final salespersonIdsArray = '{${salespersonIds.join(",")}}';
      final agencyIdsArray = '{${agencyIds.join(",")}}';
      final designerIdsArray = '{${designerIds.join(",")}}';

      final response = await supabase.rpc(
        FunctionKeys.updateTaskAssociationsFunc,
        params: {
          FunctionKeys.updateTaskAssociationsFunc: taskId,
          FunctionKeys.clientIdParam: clientId,
          FunctionKeys.salespersonIdsParam: salespersonIdsArray,
          FunctionKeys.agencyIdsParam: agencyIdsArray,
          FunctionKeys.designerIdsParam: designerIdsArray,
        },
      );

      if (response.error != null) {
        log.e('Error in function response');
      }

      print('Task associations updated successfully.');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateTask({
    required String dealNo,
    required String name,
    required String remarks,
    required String status,
    required DateTime dueDate,
    required String priority,
    required DateTime startDate,
    required Map<String, dynamic> selectedClientId,
    required List<String> selectedSalespersonIds,
    required List<String> selectedAgencyIds,
    required List<String> selectedDesignerIds,
    required Map<String, dynamic> fetchedTaskData,
  }) async {
    await _executeQuery(() async {
      // Prepare the data to update the task
      final Map<String, dynamic> updatedData = {
        'name': name,
        'status': status,
        'remarks': remarks,
        'due_date': dueDate.toIso8601String(),
        'priority': priority,
        'start_date': startDate.toIso8601String(),
      };

      final TaskModel updatedDAta = TaskModel(
        name: name,
        status: status,
        remarks: remarks,
        dueDate: dueDate,
        priority: priority,
        startDate: startDate,
      );

      // Perform the update query on the task table
      final response = await supabase
          .from(SupabaseKeys.taskTable)
          .update(updatedDAta.toJson())
          .eq(SupabaseKeys.taskDealNo, dealNo)
          .select()
          .single();

      if (response.isEmpty) {
        throw Exception('Failed to update task');
      }

      // Extract the task ID from the response
      final String taskId = response[SupabaseKeys.id];

      await updateTaskAssociations(
        taskId: taskId,
        clientId: selectedClientId[SupabaseKeys.id],
        salespersonIds: selectedSalespersonIds,
        agencyIds: selectedAgencyIds,
        designerIds: selectedDesignerIds,
      );

      return response;
    });
  }

  /// gets the next deal no
  Future<String> getNextDealNo() async {
    final int currentYear = DateTime.now().year;
    final String currentYearShort = currentYear.toString().substring(2);

    final response = await supabase
        .from(SupabaseKeys.configTable)
        .select(
            '${SupabaseKeys.taskCounterKey}, ${SupabaseKeys.lastUpdatedYearKey}')
        .eq(SupabaseKeys.id, 1)
        .single();

    int currentCounter = 0;
    int lastUpdatedYear = currentYear;

    if (response.isNotEmpty) {
      currentCounter = response[SupabaseKeys.taskCounterKey] ?? 0;
      lastUpdatedYear =
          response[SupabaseKeys.lastUpdatedYearKey] ?? currentYear;
    }

    if (lastUpdatedYear != currentYear) {
      currentCounter = 0;
    }

    final int nextCounter = currentCounter + 1;

    final String nextTaskId =
        '$currentYearShort-${nextCounter.toString().padLeft(4, '0')}';

    await supabase.from(SupabaseKeys.configTable).update({
      SupabaseKeys.taskCounterKey: nextCounter,
      SupabaseKeys.lastUpdatedYearKey: currentYear,
    }).eq(SupabaseKeys.id, 1);

    return nextTaskId;
  }

  /// Query Executing function
  Future<T?> _executeQuery<T>(Future<T> Function() queryFunction) async {
    try {
      final result = await queryFunction();
      return result;
    } on PostgrestException catch (error) {
      log.e('Supabase Error: ${error.message}');
    } catch (error) {
      log.e('Unexpected Error: $error');
    }
    return null;
  }

  Future<Map<String, dynamic>> getTaskById(String dealNo) async =>
      await _executeQuery(() async {
        final response = await supabase.rpc(
          FunctionKeys.getTaskByDealNoFunc,
          params: {FunctionKeys.dealNoParam: dealNo},
        ).single();
        return response;
      }) ??
      {};

  /// Get all tasks
  Future<Map<String, dynamic>> getAllTasks() async =>
      await _executeQuery(() async {
        final UserModel? user = await AuthController.instance.getLoggedInUser();

        // final response = await getSalesTasks(user!.id!);

        //   return response;
        // }) ??
        // {};
        final response = await supabase.rpc(
          user!.role == UserRole.salesperson
              ? FunctionKeys.getSalesTasksFunc
              : FunctionKeys.getAgencyTasksFunc,
          params: {FunctionKeys.userIdParam: user.id},
        ).single();

        return response;
      }) ??
      {};

  Future<Map<String, dynamic>> getSalesTasks(String userId) async {
    try {
      // Step 1: Fetch tasks from `task_salespersons`
      final response1 = await supabase
          .from('tasks')
          .select('*, task_salespersons!inner(user_id)')
          .eq('task_salespersons.user_id', userId);

      // Step 2: Fetch tasks from `task_agencies`
      final response2 = await supabase
          .from('tasks')
          .select('*, task_agencies!inner(user_id)')
          .eq('task_agencies.user_id', userId);

      // Step 3: Merge both task lists and remove duplicates
      final tasks = [
        ...response1 as List<dynamic>,
        ...response2 as List<dynamic>
      ];

      // Remove duplicate tasks based on task ID
      final uniqueTasks =
          {for (var task in tasks) task['id']: task}.values.toList();

      // Step 4: Categorize tasks
      final Map<String, List<Map<String, dynamic>>> categorizedTasks = {
        'pending_tasks': [],
        'completed_tasks': [],
        'payment_tasks': [],
        'shared_tasks': [],
        'quotation_tasks': [],
      };

      for (final task in uniqueTasks) {
        final String status = task['status'];
        final String taskCategory;

        if (status == 'Task: In Progress') {
          taskCategory = 'pending_tasks';
        } else if ([
          'Measurement: Shared',
          'Measurement: Accepted',
          'Measurement: Rejected',
          'Measurement: In Progress'
        ].contains(status)) {
          taskCategory = 'shared_tasks';
        } else if (['Measurement: Completed', 'Quotation: Created']
            .contains(status)) {
          taskCategory = 'quotation_tasks';
        } else if (['Payment: Paid', 'Payment: Unpaid'].contains(status)) {
          taskCategory = 'payment_tasks';
        } else if (status == 'Task: Completed') {
          taskCategory = 'completed_tasks';
        } else {
          continue; // Skip tasks that don't match any category
        }

        // Aggregate user IDs associated with the task
        final userIds = <String>{};
        if (task['task_salespersons'] != null) {
          for (var ts in task['task_salespersons']) {
            userIds.add(ts['user_id']);
          }
        }
        if (task['task_agencies'] != null) {
          for (var ta in task['task_agencies']) {
            userIds.add(ta['user_id']);
          }
        }

        // Add the task to the appropriate category
        categorizedTasks[taskCategory]!.add({
          ...task,
          'user_ids': userIds.toList(),
          'task_category': taskCategory,
        });
      }

      // Step 5: Return the result in the desired format
      return {
        'pending_tasks': categorizedTasks['pending_tasks'],
        'completed_tasks': categorizedTasks['completed_tasks'],
        'payment_tasks': categorizedTasks['payment_tasks'],
        'shared_tasks': categorizedTasks['shared_tasks'],
        'quotation_tasks': categorizedTasks['quotation_tasks'],
      };
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  /// Get all rows
  Future<List<Map<String, dynamic>>> getRows({
    required String table,
    Map<String, dynamic>? filters,
    String? select,
    String? orderBy,
    bool ascending = true,
  }) async =>
      await _executeQuery(() async {
        var query = supabase.from(table).select(select ?? "");

        filters?.forEach((key, value) {
          query = query.eq(key, value);
        });

        // if (orderBy != null) {
        //   query = supabase.from(table).select().order('orderBy', ascending: true)
        // }

        final response = await query;
        return (response as List<dynamic>).cast<Map<String, dynamic>>();
      }) ??
      [];
}
