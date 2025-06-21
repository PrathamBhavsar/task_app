import '../../../core/error/failure.dart';
import '../../../domain/entities/user.dart';

abstract class UserState {}
class UserInitial extends UserState {}
class UserLoadInProgress extends UserState {}
class UserLoadSuccess extends UserState {
  final List<User> users;
  UserLoadSuccess(this.users);
}
class UserLoadFailure extends UserState {
  final Failure error;
  UserLoadFailure(this.error);
}
