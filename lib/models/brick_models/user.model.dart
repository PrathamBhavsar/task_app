import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'users'),
)
class User extends OfflineFirstWithSupabaseModel {
 
  final String name;
  final String email;
  final String role;
  final String profileBgColor;

  User({
    required this.name,
    required this.email,
    required this.role,
    this.profileBgColor = '',
  });

}
