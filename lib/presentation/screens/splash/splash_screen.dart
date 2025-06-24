import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/snack_bar_helper.dart';
import '../../../utils/constants/app_constants.dart';
import '../../blocs/bill/bill_bloc.dart';
import '../../blocs/bill/bill_event.dart';
import '../../blocs/bill/bill_state.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_event.dart';
import '../../blocs/client/client_state.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';
import '../../blocs/user/user_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Completer<void> _clientLoaded = Completer();
  final Completer<void> _billLoaded = Completer();
  final Completer<void> _taskLoaded = Completer();
  final Completer<void> _usersLoaded = Completer();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ClientBloc>().add(FetchClientsRequested());
      context.read<BillBloc>().add(FetchBillsRequested());
      context.read<TaskBloc>().add(FetchTasksRequested());
      context.read<UserBloc>().add(FetchUsersRequested());

      try {
        await _clientLoaded.future;
        await _billLoaded.future;
        await _taskLoaded.future;
        await _usersLoaded.future;

        if (mounted) {
          context.go(AppRoutes.home);
        }
      } catch (e) {
        if (mounted) {
          getIt<SnackBarHelper>().showError("Failed to load data: $e");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ClientBloc, ClientState>(
            listener: (context, state) {
              if (state is ClientLoadSuccess) {
                if (!_clientLoaded.isCompleted) {
                  _clientLoaded.complete();
                }
              } else if (state is ClientLoadFailure) {
                _clientLoaded.completeError('Client failed');
              }
            },
          ),
          BlocListener<BillBloc, BillState>(
            listener: (context, state) {
              if (state is BillLoadSuccess) {
                if (!_billLoaded.isCompleted) {
                  _billLoaded.complete();
                }
              } else if (state is BillLoadFailure) {
                _billLoaded.completeError('Bill failed');
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskLoadSuccess) {
                if (!_taskLoaded.isCompleted) {
                  _taskLoaded.complete();
                }
              } else if (state is TaskLoadFailure) {
                _taskLoaded.completeError('Task failed');
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoadSuccess) {
                if (!_usersLoaded.isCompleted) {
                  _usersLoaded.complete();
                }
              } else if (state is UserLoadFailure) {
                _usersLoaded.completeError('Users failed');
              }
            },
          ),
        ],
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
