import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Completer<void> _clientLoaded = Completer();
  final Completer<void> _billLoaded = Completer();
  final Completer<void> _taskLoaded = Completer();

  @override
  void initState() {
    super.initState();

    // Dispatch events AFTER first frame to avoid calling too early.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Dispatch events
      context.read<ClientBloc>().add(FetchClientsRequested());
      context.read<BillBloc>().add(FetchBillsRequested());
      context.read<TaskBloc>().add(FetchTasksRequested());

      try {
        // Wait serially (optional: change to parallel if needed)
        await _clientLoaded.future;
        await _billLoaded.future;
        await _taskLoaded.future;

        // When all complete, go to home
        if (mounted) context.go(AppRoutes.home);
      } catch (e) {
        // Handle error (log, show error screen, etc.)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load data: $e')),
          );
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
                if (!_clientLoaded.isCompleted) _clientLoaded.complete();
              } else if (state is ClientLoadFailure) {
                _clientLoaded.completeError('Client failed');
              }
            },
          ),
          BlocListener<BillBloc, BillState>(
            listener: (context, state) {
              if (state is BillLoadSuccess) {
                if (!_billLoaded.isCompleted) _billLoaded.complete();
              } else if (state is BillLoadFailure) {
                _billLoaded.completeError('Bill failed');
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskLoadSuccess) {
                if (!_taskLoaded.isCompleted) _taskLoaded.complete();
              } else if (state is TaskLoadFailure) {
                _taskLoaded.completeError('Task failed');
              }
            },
          ),
        ],
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
