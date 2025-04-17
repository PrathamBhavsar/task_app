import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/constants/custom_icons.dart';
import '../../utils/extensions/padding.dart';
import '../providers/home_provider.dart';
import 'action_button.dart';

class SelectionDrawer extends StatelessWidget {
  const SelectionDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    elevation: 5,
    backgroundColor: Colors.white,
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                  child: Center(
                    child: Text('Retail CRM', style: AppTexts.titleTextStyle),
                  ),
                ),
                Divider(color: AppColors.accent),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ActionButton(
              prefixIcon: CustomIcon.cloudUpload,
              label: 'Logout',
              fontColor: AppColors.errorRed,
              onPress: () {
                Navigator.pop(context);
                context.goNamed('auth');
              },
            ),
          ),
        ],
      ),
    ),
  );
}
