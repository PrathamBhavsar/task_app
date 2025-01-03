import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/views/auth/widgets/user_role_tile.dart';

class UserRoleWidget extends StatelessWidget {
  const UserRoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Consumer<AuthProvider>(
        builder: (BuildContext context, AuthProvider provider, Widget? child) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              UserRoleTile(
                text: 'Sales',
                onTap: () => provider.toggleUserRole(UserRole.salesperson),
                isSelected: provider.currentUserRole == UserRole.salesperson,
              ),
              AppPaddings.gapW(10),
              UserRoleTile(
                text: 'Agency',
                onTap: () => provider.toggleUserRole(UserRole.agency),
                isSelected: provider.currentUserRole == UserRole.agency,
              ),
            ],
          );
        },
      ),
    );
  }
}
