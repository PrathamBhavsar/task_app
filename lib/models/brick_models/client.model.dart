import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'clients'),
)
class Client extends OfflineFirstWithSupabaseModel {
  final String name;
  final String address;
  final String contactNo;

  Client({
    required this.name,
    required this.address,
    required this.contactNo,
  });
}
