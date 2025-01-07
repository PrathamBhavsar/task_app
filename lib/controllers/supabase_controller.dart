import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/constants/supabase_keys.dart';
import 'package:task_app/controllers/auth_controller.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/models/user.dart';

class SupabaseController {
  static final SupabaseController instance =
      SupabaseController._privateConstructor();
  SupabaseController._privateConstructor();

  final supabase = Supabase.instance.client;
  final Logger log = Logger();

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
        SupabaseKeys.clientId: clientIdsList['id'],
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
        'update_task_associations',
        params: {
          'p_task_id': taskId,
          'p_client_id': clientId,
          'salesperson_ids': salespersonIdsArray,
          'agency_ids': agencyIdsArray,
          'designer_ids': designerIdsArray,
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

      // Perform the update query on the task table
      final response = await supabase
          .from(SupabaseKeys.taskTable)
          .update(updatedData)
          .eq('deal_no', dealNo)
          .select();

      if (response == null || response.isEmpty) {
        throw Exception('Failed to update task');
      }

      // Extract the task ID from the response
      final String taskId = response[0]['id'];

      await updateTaskAssociations(
        taskId: taskId,
        clientId: selectedClientId['id'],
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
        .select('task_counter, last_updated_year')
        .eq('id', 1)
        .single();

    int currentCounter = 0;
    int lastUpdatedYear = currentYear;

    if (response.isNotEmpty) {
      currentCounter = response['task_counter'] ?? 0;
      lastUpdatedYear = response['last_updated_year'] ?? currentYear;
    }

    if (lastUpdatedYear != currentYear) {
      currentCounter = 0;
    }

    final int nextCounter = currentCounter + 1;

    final String nextTaskId =
        '$currentYearShort-${nextCounter.toString().padLeft(4, '0')}';

    await supabase.from(SupabaseKeys.configTable).update({
      'task_counter': nextCounter,
      'last_updated_year': currentYear,
    }).eq('id', 1);

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

  Future<Map<String, dynamic>> getTaskById(String dealNo) async {
    return await _executeQuery(() async {
          final response = await supabase.rpc(
            'get_task_by_deal_no',
            params: {'deal_no_input': dealNo},
          ).single();
          return response;
        }) ??
        {};
  }

  /// Get all tasks
  Future<Map<String, dynamic>> getAllTasks() async {
    return await _executeQuery(() async {
          final UserModel? user =
              await AuthController.instance.getLoggedInUser();
          final response = await supabase.rpc(
            user!.role == UserRole.salesperson
                ? 'get_sales_tasks'
                : 'get_agency_tasks',
            params: {'_user_id': user.id},
          ).single();

          return response;
        }) ??
        {};
  }

  /// Get all rows
  Future<List<Map<String, dynamic>>> getRows({
    required String table,
    Map<String, dynamic>? filters,
    String? select,
    String? orderBy,
    bool ascending = true,
  }) async {
    return await _executeQuery(() async {
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
}
