import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/manager.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import 'new_manager_screen.dart';

final managers = Manager.sampleManagers;

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Manager',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed:
          () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => NewManagerScreen())),
    ),
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Text('Manager', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(
      child: _buildUI(context).padAll(AppPaddings.appPaddingInt),
    ),
  );

  Widget _buildUI(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Manage Managers", style: AppTexts.titleTextStyle),
      5.hGap,
      Text(
        "Manage salon managers and their assignments",
        style: AppTexts.inputHintTextStyle,
      ),
      20.hGap,
      ...List.generate(
        managers.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(managers[index].name, style: AppTexts.titleTextStyle),
                  5.wGap,
                  Text(
                    managers[index].createdAt,
                    style: AppTexts.inputHintTextStyle,
                  ),
                ],
              ),
              Text(
                "@${managers[index].username}",
                style: AppTexts.inputLabelTextStyle,
              ),
              10.hGap,
              Text(managers[index].salon, style: AppTexts.inputTextStyle),
              10.hGap,
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      label: 'Remove',
                      onPress: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                  10.wGap,
                  Expanded(
                    child: ActionButton(
                      label: 'Edit',
                      onPress:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => NewManagerScreen(
                                    isEditing: true,
                                    manager: managers[index],
                                  ),
                            ),
                          ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              20.hGap,
              index != managers.length - 1
                  ? Divider(color: AppColors.accent)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ],
  );
}
