import 'package:flutter/material.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/user.dart';

/// --- FETCH STATES ---
@immutable
sealed class GetUsersState {}

class None extends GetUsersState {}

class Fetching extends GetUsersState {}

class Fetched extends GetUsersState {
  final List<User> users;

  Fetched(this.users);
}

class Failed extends GetUsersState {
  final Failure failure;

  Failed(this.failure);
}
