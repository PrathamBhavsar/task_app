import '../../../data/models/api_response.dart';
import '../../data/models/status.dart';
import '../../data/repositories/status_repository.dart';

class GetStatusesUseCase {
  final StatusRepository repository;

  GetStatusesUseCase(this.repository);

  Future<ApiResponse<List<Status>>> execute() async {
    final response = await repository.fetchStatuses();

    if (response.success && response.data != null) {
      List<Status> users = List<Status>.from(response.data!);

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
