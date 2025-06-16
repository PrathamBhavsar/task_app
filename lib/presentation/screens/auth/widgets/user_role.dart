import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/enums/user_role.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/auth/auth_bloc.dart';
import 'user_role_tile.dart';

class UserRoleWidget extends StatelessWidget {
  const UserRoleWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            UserRoleTile(
              text: 'Admin',
              onTap:
                  () => context.read<AuthBloc>().add(
                    SetUserRoleEvent(UserRole.admin),
                  ),
              isSelected: state.userRole == UserRole.admin,
            ),
            10.wGap,
            UserRoleTile(
              text: 'Salesperson',
              onTap:
                  () => context.read<AuthBloc>().add(
                    SetUserRoleEvent(UserRole.salesperson),
                  ),
              isSelected: state.userRole == UserRole.salesperson,
            ),
            10.wGap,
            UserRoleTile(
              text: 'Agency',
              onTap:
                  () => context.read<AuthBloc>().add(
                    SetUserRoleEvent(UserRole.agent),
                  ),
              isSelected: state.userRole == UserRole.agent,
            ),
          ],
        );
      },
    ),
  );
}
