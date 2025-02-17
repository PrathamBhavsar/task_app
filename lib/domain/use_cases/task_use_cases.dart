import '../../../data/models/api_response.dart';
import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<ApiResponse<List<Task>>> execute() async {
    final response = await repository.fetchTasks();

    if (response.success && response.data != null) {
      List<Task> users = List<Task>.from(response.data!);

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
