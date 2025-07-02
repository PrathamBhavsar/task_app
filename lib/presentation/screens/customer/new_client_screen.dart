import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/validator.dart';
import '../../../data/models/payloads/client_payload.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_event.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/labeled_text_field.dart';

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
                      LabeledTextInput(
                        title: 'Name',
                        hint: 'Enter customer name',
                        controller: _nameController,
                        validator: Validator.validateName,
                      ),
                      LabeledTextInput(
                        title: 'Phone',
                        hint: 'Enter customer phone',
                        controller: _phoneController,
                        validator: Validator.validatePhone,
                      ),
                      LabeledTextInput(
                        title: 'Email',
                        hint: 'Enter customer email',
                        controller: _emailController,
                        validator: Validator.validateEmail,
                      ),
                      LabeledTextInput(
                        title: 'Address',
                        hint: 'Enter customer address',
                        controller: _addressController,
                        validator: Validator.validateRequiredField,
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
}
