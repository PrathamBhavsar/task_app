import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/designer.dart';
import '../repositories/designer_repository.dart';

class GetAllDesignersUseCase {
  final DesignerRepository repository;
  GetAllDesignersUseCase(this.repository);
  Future<Either<Failure, List<Designer>>> call() {
    return repository.getAll();
  }
}