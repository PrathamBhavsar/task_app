import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/extensions/padding.dart';
import '../providers/home_provider.dart';
import 'action_button.dart';

class SelectionDrawer extends StatelessWidget {
  const SelectionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Drawer(
      elevation: 5,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
                child: Center(
                  child: Text('LuxPass', style: AppTexts.titleTextStyle),
                ),
              ),
              Divider(color: AppColors.accent).padSymmetric(horizontal: 10.h),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeProvider.menuPageNames.length,
                itemBuilder:
                    (context, index) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                          context.pushNamed(homeProvider.menuPageNames[index]);
                        },
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          child: Text(
                            homeProvider.titles[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ActionButton(
                  label: 'Logout',
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
