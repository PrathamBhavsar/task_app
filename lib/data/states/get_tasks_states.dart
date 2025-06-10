import 'package:flutter/material.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/task.dart';

/// --- FETCH STATES ---
@immutable
sealed class GetTasksState {}

class None extends GetTasksState {}

class Fetching extends GetTasksState {}

class Fetched extends GetTasksState {
  final List<Task> tasks;

  Fetched(this.tasks);
}

class Failed extends GetTasksState {
  final Failure failure;

  Failed(this.failure);
}
