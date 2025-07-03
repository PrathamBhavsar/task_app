import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/di.dart';
import '../../core/helpers/cache_helper.dart';
import '../../data/models/payloads/update_status_payload.dart';
import '../../domain/entities/task.dart';
import '../../presentation/blocs/task/task_bloc.dart';
import '../../presentation/blocs/task/task_event.dart';
import '../../presentation/blocs/task_form/task_form_bloc.dart';
import 'get_next_status.dart';

extension TaskContextActions on BuildContext {
  void updateTaskStatusToQuotationSent({
    required Task task,
    required BuildContext context,
    String? status
  }) {
    final selectedAgencyId =
        context.read<TaskFormBloc>().state.selectedAgency?.userId ?? 0;

    final taskBloc = read<TaskBloc>();
    final int? userId = getIt<CacheHelper>().getUserId();

    taskBloc.add(
      UpdateTaskStatusRequested(
        UpdateStatusPayload(
          status: status ?? task.status.next!.name,
          taskId: task.taskId!,
          agencyId: selectedAgencyId,
          userId: userId ?? 0,
        ),
      ),
    );
  }
}
