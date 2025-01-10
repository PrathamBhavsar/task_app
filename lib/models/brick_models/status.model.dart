import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'task_status'),
)
class TaskStatus extends OfflineFirstWithSupabaseModel {
  final int taskOrder;

  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String slug;

  final String color;

  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String name;

  final String category;

  TaskStatus({
    required this.taskOrder,
    required this.slug,
    required this.color,
    required this.name,
    required this.category,
  });
}
