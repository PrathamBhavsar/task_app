import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/designer.dart';

abstract class DesignerRepository {
  Future<Either<Failure, List<Designer>>> getAll();
}
