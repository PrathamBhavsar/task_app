import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/client.dart';

class ClientRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<Client>>> fetchClients() async {
    try {
      // Try fetching clients from the local database
      List<Map<String, dynamic>> localData =
          await _dbHelper.getAll(LocalDbKeys.clientsTable);
      List<Client> localClients = localData.map(Client.fromJson).toList();

      if (localClients.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localClients,
        );
      }

      // Fetch from API if no local data exists
      final response = await _apiManager.get<List<Client>>(
        ApiEndpoints.client,
        fromJsonT: (data) =>
            (data as List).map((e) => Client.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.clientsTable,
            response.data!.map((c) => c.toJson()).toList());
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Client>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch clients: $e",
        data: [],
      );
    }
  }

  /// Insert or update a client in the local database
  Future<void> insertOrUpdateClient(Client client) async {
    await _dbHelper.insertOrUpdate(LocalDbKeys.clientsTable, client.toJson());
  }

  /// Delete all clients from the local database
  Future<void> deleteAllClients() async {
    await _dbHelper.deleteAll(LocalDbKeys.clientsTable);
  }
}
