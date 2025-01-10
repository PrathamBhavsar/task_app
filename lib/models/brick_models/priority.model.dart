import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'task_priority'),
)
class TaskPriority extends OfflineFirstWithSupabaseModel {

  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String name;

  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String color;

  TaskPriority({
    required this.name,
    required this.color,
  });

}
