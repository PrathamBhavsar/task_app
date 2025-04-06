import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/employee.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';

final employees = Employee.sampleEmployees;

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Employee',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed: () => context.pushNamed('newEmployee'),
    ),
    appBar: AppBar(title: Text('Manager', style: AppTexts.titleTextStyle)),
    body: SingleChildScrollView(
      child: _buildUI(context).padAll(AppPaddings.appPaddingInt),
    ),
  );

  Widget _buildUI(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Employee List", style: AppTexts.titleTextStyle),
      5.hGap,
      Text("Manage your salon employees", style: AppTexts.inputHintTextStyle),
      20.hGap,
      ...List.generate(
        3,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(employees[index].name, style: AppTexts.headingTextStyle),
                  Text(
                    employees[index].service,
                    style: AppTexts.inputHintTextStyle,
                  ),
                ],
              ),
              10.hGap,
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      label: 'Archive',
                      fontColor: AppColors.errorRed,
                      onPress: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                  10.wGap,
                  Expanded(
                    child: ActionButton(
                      label: 'Edit',
                      onPress:
                          () => context.pushNamed(
                            'newEmployee',
                            extra: employees[index],
                          ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              20.hGap,
              index != employees.length - 1
                  ? Divider(color: AppColors.accent)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ],
  );
}
