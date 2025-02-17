import '../../../data/models/api_response.dart';
import '../../core/dto/client_dto.dart';
import '../../data/models/client.dart';
import '../../data/repositories/client_repository.dart';

class GetClientsUseCase {
  final ClientRepository repository;

  GetClientsUseCase(this.repository);

  Future<ApiResponse<List<Client>>> execute(ClientDTO clientDTO) async {
    final response = await repository.fetchClients(clientDTO);

    if (response.success && response.data != null) {
      List<Client> users = List<Client>.from(response.data!);

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: users);
    }

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      message: response.message,
      data: [],
    );
  }
}
