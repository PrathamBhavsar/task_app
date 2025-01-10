import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:task_app/models/brick_models/user.model.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'tasks'),
)
class Task extends OfflineFirstWithSupabaseModel {
  final String dealNo;
  final String? name;

  final DateTime? startDate;
  final DateTime? dueDate;

  @Supabase(foreignKey: 'priority')
  final String priority;

  @Supabase(foreignKey: 'created_by')
  final User? createdBy;

  final String? remarks;

  @Supabase(foreignKey: 'status')
  final String status;

  Task({
    String? id,
    required this.dealNo,
    this.name,
    DateTime? startDate,
    DateTime? dueDate,
    required this.priority,
    this.createdBy,
    this.remarks,
    required this.status,
  })  :
       
        this.startDate = startDate ?? DateTime.now(),
        this.dueDate = dueDate ?? DateTime.now();

}
