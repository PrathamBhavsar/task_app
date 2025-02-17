import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/enums/user_role.dart';
import '../../../extensions/app_paddings.dart';
import '../../../providers/auth_provider.dart';
import 'user_role_tile.dart';

class UserRoleWidget extends StatelessWidget {
  const UserRoleWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        child: Consumer<AuthProvider>(
          builder:
              (BuildContext context, AuthProvider provider, Widget? child) =>
                  Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              UserRoleTile(
                text: 'Sales',
                onTap: () => provider.toggleUserRole(UserRole.salesperson),
                isSelected: provider.currentUserRole == UserRole.salesperson,
              ),
              10.wGap,
              UserRoleTile(
                text: UserRole.agency.role,
                onTap: () => provider.toggleUserRole(UserRole.agency),
                isSelected: provider.currentUserRole == UserRole.agency,
              ),
            ],
          ),
        ),
      );
}
