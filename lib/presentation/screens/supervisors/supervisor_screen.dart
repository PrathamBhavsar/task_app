import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/supervisor.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import 'new_supervisor_screen.dart';

final supervisors = Supervisor.sampleSupervisors;

class SupervisorScreen extends StatelessWidget {
  const SupervisorScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Supervisors',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed:
          () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NewSupervisorScreen()),
          ),
    ),
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Text('Supervisors', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(
      child: _buildUI(context),
    ).padAll(AppPaddings.appPaddingInt),
  );

  Widget _buildUI(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Manage Supervisors", style: AppTexts.titleTextStyle),
      5.hGap,
      Text(
        "Manage supervisors and their salon assignments",
        style: AppTexts.inputHintTextStyle,
      ),
      20.hGap,
      ...List.generate(
        supervisors.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(supervisors[index].name, style: AppTexts.titleTextStyle),
                  5.wGap,
                  Text(
                    supervisors[index].createdAt,
                    style: AppTexts.inputHintTextStyle,
                  ),
                ],
              ),
              Text(
                "@${supervisors[index].username}",
                style: AppTexts.inputLabelTextStyle,
              ),
              10.hGap,
              Text(
                supervisors[index].salons.join(", "),
                style: AppTexts.inputTextStyle,
              ),
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
                                  (context) => NewSupervisorScreen(
                                    isEditing: true,
                                    supervisor: supervisors[index],
                                  ),
                            ),
                          ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              20.hGap,
              index != supervisors.length - 1
                  ? Divider(color: AppColors.accent)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ],
  );
}
