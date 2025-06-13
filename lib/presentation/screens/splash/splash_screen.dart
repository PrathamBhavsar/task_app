import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/app_constants.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_event.dart';
import '../../blocs/client/client_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientBloc>().add(FetchClientsRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ClientBloc, ClientState>(
        listener: (context, state) {
          if (state is ClientLoadSuccess) {
            context.go(AppRoutes.home);
          } else if (state is ClientLoadFailure) {
            Center(child: Text('There was an issue loading!'));
          }
        },
        child: Center(
          child: BlocBuilder<ClientBloc, ClientState>(
            builder: (context, state) {
              if (state is ClientLoadInProgress) {
                return CircularProgressIndicator();
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
