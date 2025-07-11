import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/di/di.dart' show getIt;
import '../../../core/helpers/snack_bar_helper.dart';
import '../../../domain/entities/user.dart' show User;
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart' show FetchUsersRequested;
import '../../blocs/user/user_state.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/refresh_wrapper.dart' show RefreshableStateWrapper;
import 'widgets/agency_tile.dart';

// List<Agency> agencies = Agency.sampleAgencies;

class AgencyPage extends StatelessWidget {
  const AgencyPage({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<UserBloc, UserState>(
    listener: (BuildContext context, UserState state) {
      if (state is UserLoadFailure) {
        getIt<SnackBarHelper>().showError(
          'There was an issue loading agencies!',
        );
      }
    },
    child: BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        // if (state is PutUserSuccess) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     context.read<UserBloc>().add(FetchUsersRequested());
        //   });
        // }
      },
      builder: (context, state) {
        if (state is UserLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoadFailure) {
          Center(child: Text('There was an issue loading clients!'));
        } else if (state is UserLoadSuccess) {
          if (state.users.where((u) => u.isAgency).toList().isEmpty) {
            return Center(child: Text('There are no clients!'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Users', style: AppTexts.titleTextStyle),
                    IntrinsicWidth(
                      child: ActionButton(
                        label: 'New User',
                        onPress: () => context.push(AppRoutes.newCustomer),
                        prefixIcon: CustomIcon.badgePlus,
                        fontColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                10.hGap,
                CustomTextField(hintTxt: 'Search clients', isSearch: true),
                10.hGap,
                Expanded(
                  child: RefreshableStateWrapper<User>(
                    state: state,
                    fetchFunction:
                        () async => context.read<UserBloc>().add(
                          FetchUsersRequested(),
                        ),
                    isLoading: (s) => s is UserLoadInProgress,
                    isFailure: (s) => s is UserLoadFailure,
                    getFailureMessage:
                        (s) => (s as UserLoadFailure).error.message,
                    extractItems:
                        (s) => s is UserLoadSuccess ? state.users.where((u) => u.isAgency).toList() : [],
                    itemBuilder:
                        (context, agency) => AgencyTile(agency: agency),
                  ),
                ),
              ],
            );
          }
        }
        return SizedBox.shrink();
      },
    ),
  );

  Widget _buildAgencies(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ...List.generate(
      //   agencies.length,
      //   (index) => Padding(
      //     padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
      //     child: AgencyTile(agency: agencies[index]),
      //   ),
      // ),
    ],
  );
}
