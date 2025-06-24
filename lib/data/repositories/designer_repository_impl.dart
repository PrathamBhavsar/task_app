import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/designer.dart';
import '../../domain/repositories/designer_repository.dart';
import '../api/api_helper.dart';

class DesignerRepositoryImpl implements DesignerRepository {
  final ApiHelper api;
  DesignerRepositoryImpl(this.api);
  @override
  Future<Either<Failure, List<Designer>>> getAll() {
    return api.getAllDesigners();
  }
}
