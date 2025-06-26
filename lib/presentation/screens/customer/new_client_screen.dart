import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/validator.dart';
import '../../../data/models/payloads/client_payload.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_event.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final ClientPayload payload = ClientPayload(
      name: _nameController.text,
      contactNo: _phoneController.text,
      email: _emailController.text,
      address: _addressController.text,
    );

    context.read<ClientBloc>().add(PutClientRequested(payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Add Customer', style: AppTexts.titleTextStyle),
        actions: [
          TextButton(
            onPressed: () => _handleSubmit,
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
        child: SingleChildScrollView(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextInput(
                        'Name',
                        'Enter customer name',
                        _nameController,
                        Validator.validateName,
                      ),
                      _buildTextInput(
                        'Phone',
                        'Enter customer phone',
                        _phoneController,
                        Validator.validatePhone,
                      ),
                      _buildTextInput(
                        'Email',
                        'Enter customer email',
                        _emailController,
                        Validator.validateEmail,
                      ),
                      _buildTextInput(
                        'Address',
                        'Enter customer address',
                        _addressController,
                        Validator.validateRequiredField,
                        isMultiline: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).padAll(AppPaddings.appPaddingInt),
        ),
      ),
    );
  }

  Widget _buildTextInput(
    String title,
    String hint,
    TextEditingController controller,
    FormFieldValidator<String>? validator, {
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        CustomTextField(
          hintTxt: hint,
          isMultiline: isMultiline,
          controller: controller,
          validator: validator,
        ),
        10.hGap,
      ],
    );
  }
}
