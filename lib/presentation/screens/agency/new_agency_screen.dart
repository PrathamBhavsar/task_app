import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/agency.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';

class NewAgencyScreen extends StatefulWidget {
  const NewAgencyScreen({super.key, this.agency});

  final Agency? agency;

  @override
  State<NewAgencyScreen> createState() => _NewAgencyScreenState();
}

class _NewAgencyScreenState extends State<NewAgencyScreen> {
  final _nameController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  late final bool isNew = widget.agency == null;

  @override
  void initState() {
    super.initState();
    if (!isNew) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeProvider>().setActive(
          widget.agency!.status == 'Active',
        );
      });
      _nameController.text = widget.agency!.name;
      _contactPersonController.text = widget.agency!.contactPerson;
      _phoneController.text = widget.agency!.phone;
      _emailController.text = widget.agency!.email;
      _addressController.text = widget.agency!.address;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Text(
        isNew ? 'Add Agency' : 'Edit Agency',
        style: AppTexts.titleTextStyle,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'Done',
            style: AppTexts.labelTextStyle.copyWith(color: Colors.black),
          ),
        ),
      ],
    ),
    body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Consumer<TaskProvider>(
        builder:
            (context, provider, child) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Agency Details',
                        style: AppTexts.titleTextStyle.copyWith(
                          fontVariations: [FontVariation.weight(600)],
                        ),
                      ),
                      Consumer<HomeProvider>(
                        builder:
                            (
                              BuildContext context,
                              HomeProvider provider,
                              Widget? child,
                            ) => GestureDetector(
                              onTap: () => provider.toggleActive(),
                              child: CustomTag(
                                text: provider.isActive ? 'Active' : 'Inactive',
                                color: Colors.black,
                                textColor: Colors.white,
                              ),
                            ),
                      ),
                    ],
                  ),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextInput(
                          'Name',
                          'Enter agency name',
                          _nameController,
                        ),
                        _buildTextInput(
                          'Contact Person',
                          'Enter contact person name',
                          _contactPersonController,
                        ),
                        _buildTextInput(
                          'Phone',
                          'Enter agency phone',
                          _phoneController,
                        ),
                        _buildTextInput(
                          'Email',
                          'Enter agency email',
                          _emailController,
                        ),
                        _buildTextInput(
                          'Address',
                          'Enter agency address',
                          _addressController,
                          isMultiline: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );

  Widget _buildTextInput(
    String title,
    String hint,
    TextEditingController controller, {
    bool isMultiline = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomTextField(
        hintTxt: hint,
        isMultiline: isMultiline,
        controller: controller,
      ),
      10.hGap,
    ],
  );
}
