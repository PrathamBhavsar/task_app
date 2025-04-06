import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../utils/enums/user_role.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../providers/home_provider.dart';
import 'user_role_tile.dart';

class UserRoleWidget extends StatelessWidget {
  const UserRoleWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    child: Consumer<HomeProvider>(
      builder:
          (BuildContext context, HomeProvider provider, Widget? child) => Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              UserRoleTile(
                text: 'Owner',
                onTap: () => provider.setUserRole(UserRole.admin),
                isSelected: provider.currentUserRole == UserRole.admin,
              ),
              10.wGap,
              UserRoleTile(
                text: 'Supervisor',
                onTap: () => provider.setUserRole(UserRole.salesperson),
                isSelected: provider.currentUserRole == UserRole.salesperson,
              ),
              10.wGap,
              UserRoleTile(
                text: 'Manager',
                onTap: () => provider.setUserRole(UserRole.agency),
                isSelected: provider.currentUserRole == UserRole.agency,
              ),
            ],
          ),
    ),
  );
}
