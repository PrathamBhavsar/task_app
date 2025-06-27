import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/bill.dart';
import '../../domain/entities/client.dart';
import '../../domain/entities/designer.dart';
import '../../domain/entities/service_master.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/user.dart';
import '../../presentation/blocs/bill/bill_bloc.dart';
import '../../presentation/blocs/bill/bill_state.dart';
import '../../presentation/blocs/client/client_bloc.dart';
import '../../presentation/blocs/client/client_state.dart';
import '../../presentation/blocs/designer/designer_bloc.dart';
import '../../presentation/blocs/designer/designer_state.dart';
import '../../presentation/blocs/measurement/api/service_api_bloc.dart';
import '../../presentation/blocs/measurement/api/service_api_state.dart';
import '../../presentation/blocs/task/task_bloc.dart';
import '../../presentation/blocs/task/task_state.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../../presentation/blocs/user/user_state.dart';
import '../enums/user_role.dart';

extension BlocStates on BuildContext {
  List<Client> get clients {
    final state = read<ClientBloc>().state;
    return state is ClientLoadSuccess ? state.clients : [];
  }

  List<Designer> get designers {
    final state = read<DesignerBloc>().state;
    return state is DesignerLoadSuccess ? state.designers : [];
  }

  List<User> get agencies {
    final state = read<UserBloc>().state;
    return state is UserLoadSuccess
        ? state.users.where((u) => u.userType == UserRole.agent).toList()
        : [];
  }

  List<Task> get tasks {
    final state = read<TaskBloc>().state;
    return state is TaskLoadSuccess ? state.tasks : [];
  }

  List<Bill> get bills {
    final state = read<BillBloc>().state;
    return state is BillLoadSuccess ? state.bills : [];
  }

  List<ServiceMaster> get serviceMasters {
    final state = read<ServiceApiBloc>().state;
    return state is ServiceMasterLoadSuccess ? state.serviceMasters : [];
  }
}
