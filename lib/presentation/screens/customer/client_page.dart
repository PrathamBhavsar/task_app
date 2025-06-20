import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/snack_bar_helper.dart';
import '../../../domain/entities/client.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_state.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import 'widgets/customer_tile.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (BuildContext context, ClientState state) {
        if (state is ClientLoadFailure) {
          getIt<SnackBarHelper>().showError(
            'There was an issue loading clients!',
          );
        }
      },
      child: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          if (state is ClientLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ClientLoadFailure) {
            Center(child: Text('There was an issue loading clients!'));
          } else if (state is ClientLoadSuccess) {
            if (state.clients.isEmpty) {
              return Center(child: Text('There are no clients!'));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Clients', style: AppTexts.titleTextStyle),
                      IntrinsicWidth(
                        child: ActionButton(
                          label: 'New Client',
                          onPress: () => context.push(AppRoutes.newCustomer),
                          prefixIcon: CustomIcon.badgePlus,
                          fontColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  10.hGap,
                  CustomTextField(
                    hintTxt: 'Search clients',
                    isSearch: true,
                  ),
                  10.hGap,
                  _buildCustomers(state.clients),
                ],
              );
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCustomers(List<Client> clients) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        clients.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: CustomerTile(customer: clients[index]),
        ),
      ),
    ],
  );
}
