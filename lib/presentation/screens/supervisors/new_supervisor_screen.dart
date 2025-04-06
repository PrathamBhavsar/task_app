import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';

import '../../../data/models/supervisor.dart';

class NewSupervisorScreen extends StatefulWidget {
  const NewSupervisorScreen({
    super.key,
    this.isEditing = false,
    this.supervisor,
  });

  final bool isEditing;
  final Supervisor? supervisor;

  @override
  _NewSupervisorScreenState createState() => _NewSupervisorScreenState();
}

class _NewSupervisorScreenState extends State<NewSupervisorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();
  final List<String> selectedSalons = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.supervisor != null) {
      nameController.text = widget.supervisor!.name;
      usernameController.text = widget.supervisor!.username;
      pinController.text = 'widget.supervisor!.pin';
      confirmPinController.text = 'widget.supervisor!.pin';
      selectedSalons.addAll(widget.supervisor!.salons);
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
      // Update supervisor logic
      print("Updating Supervisor: ${nameController.text}");
    } else {
      // Create new supervisor logic
      print("Creating new Supervisor: ${nameController.text}");
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
                ? 'Edit ${widget.supervisor!.name}'
                : 'Add New Supervisor',
            style: AppTexts.titleTextStyle,
          ),
          5.hGap,
          Text(
            widget.isEditing
                ? 'Update supervisor details and salon assignment'
                : 'Create a new supervisor account and assign salons',
            style: AppTexts.inputTextStyle,
          ),
          30.hGap,
          _buildInputField(
            "Full Name",
            "Enter supervisor name",
            nameController,
          ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Assign Salons", style: AppTexts.labelTextStyle),
              10.hGap,
              BorderedContainer(
                padding: 5,
                child: Column(
                  children: [
                    ...DummyData.branches.map(
                      (salon) => CheckboxListTile(
                        activeColor: Colors.black,
                        title: Text(salon, style: AppTexts.inputTextStyle),
                        value: selectedSalons.contains(salon),
                        onChanged: (isChecked) {
                          setState(() {
                            isChecked!
                                ? selectedSalons.add(salon)
                                : selectedSalons.remove(salon);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
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
