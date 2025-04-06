import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/employee.dart';
import '../../../data/models/services.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class NewEmployeeScreen extends StatefulWidget {
  const NewEmployeeScreen({super.key, this.employee});
  final Employee? employee;

  @override
  _NewEmployeeScreenState createState() => _NewEmployeeScreenState();
}

class _NewEmployeeScreenState extends State<NewEmployeeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();
  late bool isEditing = widget.employee != null;
  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      nameController.text = widget.employee!.name;
      usernameController.text = widget.employee!.service;
      pinController.text = "widget.employee!.pin";
      confirmPinController.text = 'widget.employee!.pin';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    pinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (isEditing) {
      // Update employee logic
      print("Updating employee: ${nameController.text}");
    } else {
      // Create employee logic
      print("Creating new employee: ${nameController.text}");
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
    ),
    body: SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? 'Edit ${widget.employee!.name}' : 'Add New Employee',
              style: AppTexts.titleTextStyle,
            ),
            5.hGap,
            Text(
              isEditing
                  ? 'Update employee details and salon assignment'
                  : 'Create a new employee account and assign salon',
              style: AppTexts.inputTextStyle,
            ),
            30.hGap,
            // Input Fields
            _buildInputField("First Name", "Enter first name", nameController),
            _buildInputField(
              "Last Name",
              "Enter last name",
              usernameController,
            ),
            Text("Role", style: AppTexts.headingTextStyle),
            10.hGap,
            CustomDropdownMenu(
              items: Service.names,
              initialValue: Service.names.first,
            ),
            10.hGap,
            _buildInputField(
              "Phone Number",
              "Enter phone number",
              pinController,
            ),
            _buildInputField(
              "Email",
              "Enter email address",
              confirmPinController,
            ),
          ],
        ).padAll(AppPaddings.appPaddingInt),
      ),
    ),
    persistentFooterButtons: [
      Row(
        children: [
          Expanded(
            child: ActionButton(
              label: 'Cancel',
              onPress: () => Navigator.of(context).pop(),
              backgroundColor: Colors.white,
              fontColor: Colors.black,
              hasBorder: true,
            ),
          ),
          10.wGap,
          Expanded(
            child: ActionButton(
              label: isEditing ? 'Update' : 'Create',
              onPress: _handleSubmit,
              backgroundColor: Colors.black,
              fontColor: Colors.white,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildInputField(
    String title,
    String hint,
    TextEditingController controller,
  ) => Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.headingTextStyle),
        10.hGap,
        CustomTextField(hintTxt: hint, controller: controller),
      ],
    ),
  );
}
