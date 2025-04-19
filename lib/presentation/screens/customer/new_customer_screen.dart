import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';

class NewCustomerScreen extends StatefulWidget {
  const NewCustomerScreen({super.key});

  @override
  State<NewCustomerScreen> createState() => _NewCustomerScreenState();
}

class _NewCustomerScreenState extends State<NewCustomerScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Text('Add Customer', style: AppTexts.titleTextStyle),
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
                  Text(
                    'Customer Details',
                    style: AppTexts.titleTextStyle.copyWith(
                      fontVariations: [FontVariation.weight(600)],
                    ),
                  ),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextInput(
                          'Name',
                          'Enter customer name',
                          _nameController,
                        ),
                        _buildTextInput(
                          'Phone',
                          'Enter customer phone',
                          _phoneController,
                        ),
                        _buildTextInput(
                          'Email',
                          'Enter customer email',
                          _emailController,
                        ),
                        _buildTextInput(
                          'Address',
                          'Enter customer address',
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
