import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController {
  static final SupabaseController instance =
      SupabaseController._privateConstructor();
  SupabaseController._privateConstructor();

  final supabase = Supabase.instance.client;
  final Logger log = Logger();

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

  /// Get all rows
  Future<List<Map<String, dynamic>>> getRows({
    required String table,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
  }) async {
    return await _executeQuery(() async {
          var query = supabase.from(table).select();

          filters?.forEach((key, value) {
            query = query.eq(key, value);
          });

          // if (orderBy != null) {
          //   query = supabase.from(table).select().order('orderBy', ascending: true)
          // }

          final response = await query;
          log.i('Fetched from $table: $response');
          return (response as List<dynamic>).cast<Map<String, dynamic>>();
        }) ??
        [];
  }
}
