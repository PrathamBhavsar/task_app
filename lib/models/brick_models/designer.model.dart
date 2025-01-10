import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'designers'),
)
class Designer extends OfflineFirstWithSupabaseModel {

  final int code;
  final String name;
  final String firmName;
  final String contactNo;
  final String address;
  final String profileBgColor;

  Designer({
    required this.code,
    required this.name,
    required this.firmName,
    required this.contactNo,
    required this.address,
    this.profileBgColor = '',
  });

}
