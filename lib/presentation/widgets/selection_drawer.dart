import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/di.dart';
import '../../core/helpers/cache_helper.dart';
import '../../domain/entities/menu_page.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/custom_icons.dart';
import '../../utils/extensions/padding.dart';
import 'action_button.dart';

class SelectionDrawer extends StatelessWidget {
  const SelectionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      child: Text('Floww Retail CRM', style: AppTexts.titleTextStyle),
                    ),
                  ),
                  Divider(color: AppColors.accent),
                  20.hGap,
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final MenuPage page = MenuPage.pages[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.pop();
                            context.push(page.name);
                          },
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            child: Text(
                              page.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 10),
                    itemCount: MenuPage.pages.length,
                  ),
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
                  getIt<CacheHelper>().clearUser();
                  context.go(AppRoutes.auth);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
