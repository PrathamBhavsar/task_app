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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Completer<void> _billLoaded = Completer();
  final Completer<void> _clientLoaded = Completer();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientBloc>().add(FetchClientsRequested());
      context.read<BillBloc>().add(FetchBillsRequested());

      Future.wait([_clientLoaded.future, _billLoaded.future]).then((_) {
        context.go(AppRoutes.home);
      });
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
        ],
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
