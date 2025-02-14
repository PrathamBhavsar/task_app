import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class GetLocalUsersUseCase {
  final UserRepository repository;

  GetLocalUsersUseCase(this.repository);

  Future<List<User>> execute() async => await repository.getUsersFromDB();
}
