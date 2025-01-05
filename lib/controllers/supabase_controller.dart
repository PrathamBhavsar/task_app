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
    log.i(task.dealNo);
    await _executeQuery(() async {
      final response =
          await supabase.from(SupabaseKeys.taskTable).insert(task.toJson());

      return response;
    });
  }

  Future<void> updateTask({
    required String dealNo,
    required String name,
    required String remarks,
    required String status,
    required DateTime dueDate,
    required String priority,
    required DateTime startDate,
  }) async {
    await _executeQuery(() async {
      // Prepare the data to update
      final Map<String, dynamic> updatedData = {
        'name': name,
        'status': status,
        'remarks': remarks,
        'due_date': dueDate.toIso8601String(),
        'priority': priority,
        'start_date': startDate.toIso8601String(),
      };

      // Perform the update query
      final response = await supabase
          .from(SupabaseKeys.taskTable)
          .update(updatedData)
          .eq('deal_no', dealNo);

      return response;
    });
  }

  /// gets the next deal no
  Future<String> getNextDealNo() async {
    final int currentYear = DateTime.now().year;
    final String currentYearShort =
        currentYear.toString().substring(2); // "2024" -> "24"

    // Fetch the current counter and last updated year from the database
    final response = await supabase
        .from(SupabaseKeys.configTable)
        .select('task_counter, last_updated_year')
        .eq('id', 1) // Ensure we are fetching the correct row
        .single();

    int currentCounter = 0;
    int lastUpdatedYear = currentYear;

    if (response.isNotEmpty) {
      currentCounter = response['task_counter'] ?? 0;
      lastUpdatedYear = response['last_updated_year'] ?? currentYear;
    }

    // Reset the counter if the year has changed
    if (lastUpdatedYear != currentYear) {
      currentCounter = 0;
    }

    // Increment the counter
    final int nextCounter = currentCounter + 1;

    // Generate the next task ID
    final String nextTaskId =
        '$currentYearShort-${nextCounter.toString().padLeft(4, '0')}';

    // Update the database with the new counter and current year
    await supabase.from(SupabaseKeys.configTable).update({
      'task_counter': nextCounter,
      'last_updated_year': currentYear,
    }).eq('id', 1); // Use the primary key or a fixed identifier for the row

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
