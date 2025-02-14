import '../../data/repositories/user_repository.dart';

class GetLocalUsersUseCase {
  final UserRepository repository;

  GetLocalUsersUseCase(this.repository);

  Future<List<String>> execute() async => await repository.getUsersFromDB();
}
