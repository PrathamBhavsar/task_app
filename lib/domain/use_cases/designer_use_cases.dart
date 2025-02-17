import '../../../data/models/api_response.dart';
import '../../data/models/designer.dart';
import '../../data/repositories/designer_repository.dart';

class GetDesignersUseCase {
  final DesignerRepository repository;

  GetDesignersUseCase(this.repository);

  Future<ApiResponse<List<Designer>>> execute() async {
    final response = await repository.fetchDesigners();

    if (response.success && response.data != null) {
      List<Designer> users = List<Designer>.from(response.data!);

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
