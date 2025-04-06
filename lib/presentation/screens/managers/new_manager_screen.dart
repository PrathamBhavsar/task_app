import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/manager.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class NewManagerScreen extends StatefulWidget {
  const NewManagerScreen({super.key, this.isEditing = false, this.manager});

  final bool isEditing;
  final Manager? manager;

  @override
  _NewManagerScreenState createState() => _NewManagerScreenState();
}

class _NewManagerScreenState extends State<NewManagerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();
  String? selectedSalon;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.manager != null) {
      nameController.text = widget.manager!.name;
      usernameController.text = widget.manager!.username;
      pinController.text = "widget.manager!.pin";
      confirmPinController.text = 'widget.manager!.pin';
      selectedSalon = widget.manager!.salon;
    } else {
      selectedSalon = DummyData.branches.first;
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
    if (widget.isEditing) {
      // Update manager logic
      print("Updating manager: ${nameController.text}");
    } else {
      // Create manager logic
      print("Creating new manager: ${nameController.text}");
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isEditing
                ? 'Edit ${widget.manager!.name}'
                : 'Add New Manager',
            style: AppTexts.titleTextStyle,
          ),
          5.hGap,
          Text(
            widget.isEditing
                ? 'Update manager details and salon assignment'
                : 'Create a new manager account and assign salon',
            style: AppTexts.inputTextStyle,
          ),
          30.hGap,
          // Input Fields
          _buildInputField("Full Name", "Enter manager name", nameController),
          _buildInputField("Username", "Enter username", usernameController),
          _buildInputField(
            "PIN",
            "Enter 4 digit PIN",
            pinController,
            isObscure: true,
          ),
          _buildInputField(
            "Confirm PIN",
            "Confirm PIN",
            confirmPinController,
            isObscure: true,
          ),
          // Dropdown for Assign Salon
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Assign Salon", style: AppTexts.labelTextStyle),
              10.hGap,
              CustomDropdownMenu(
                items: DummyData.branches,
                initialValue: selectedSalon!,
              ),
            ],
          ),
        ],
      ).padAll(AppPaddings.appPaddingInt),
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
              label: widget.isEditing ? 'Update' : 'Create',
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
    TextEditingController controller, {
    bool isObscure = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        CustomTextField(
          hintTxt: hint,
          controller: controller,
          isPassword: isObscure,
        ),
      ],
    ),
  );
}
