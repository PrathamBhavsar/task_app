import '../../../data/models/api_response.dart';
import '../../data/models/priority.dart';
import '../../data/repositories/priority_repository.dart';

class GetPrioritiesUseCase {
  final PriorityRepository repository;

  GetPrioritiesUseCase(this.repository);

  Future<ApiResponse<List<Priority>>> execute() async {
    final response = await repository.fetchPriorities();

    if (response.success && response.data != null) {
      List<Priority> users = List<Priority>.from(response.data!);

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
