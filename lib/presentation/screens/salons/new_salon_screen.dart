import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/salon.dart';
import '../../../data/models/supervisor.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class NewSalonScreen extends StatefulWidget {
  const NewSalonScreen({super.key, this.salon});

  final Salon? salon;

  @override
  _NewSalonScreenState createState() => _NewSalonScreenState();
}

class _NewSalonScreenState extends State<NewSalonScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  late bool isEditing = widget.salon != null;
  String? supervisor;
  @override
  void initState() {
    super.initState();
    if (widget.salon != null) {
      nameController.text = widget.salon!.name;
      addressController.text = widget.salon!.address;
    } else {
      supervisor = widget.salon!.supervisor;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
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
              isEditing ? 'Edit ${widget.salon!.name}' : 'Add New Employee',
              style: AppTexts.titleTextStyle,
            ),
            5.hGap,
            Text(
              isEditing
                  ? 'Update details of ${widget.salon!.name}.'
                  : 'Enter the details of the new salon.',
              style: AppTexts.inputTextStyle,
            ),
            30.hGap,
            // Input Fields
            _buildInputField("Salon Name", "Enter salon name", nameController),
            _buildInputField(
              "Address",
              "Enter salon address",
              addressController,
            ),
            Text("Supervisor (Optional)", style: AppTexts.headingTextStyle),
            10.hGap,
            CustomDropdownMenu(
              items: Supervisor.names,
              initialValue: supervisor ?? Supervisor.names.first,
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
