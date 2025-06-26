import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/user.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';

class NewAgencyScreen extends StatefulWidget {
  const NewAgencyScreen({super.key, this.agent});

  final User? agent;

  @override
  State<NewAgencyScreen> createState() => _NewAgencyScreenState();
}

class _NewAgencyScreenState extends State<NewAgencyScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  late final bool isNew = widget.agent == null;

  @override
  void initState() {
    super.initState();
    if (!isNew) {
      _nameController.text = widget.agent!.name;
      _phoneController.text = widget.agent!.contactNo;
      _emailController.text = widget.agent!.email;
      _addressController.text = widget.agent!.address;
    }
  }

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
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap:
                                () =>
                                    context.read<AuthBloc>()
                                      ..add(ToggleVisibilityEvent()),
                            child: CustomTag(
                              text: state.isVisible ? 'Active' : 'Inactive',
                              color: Colors.black,
                            ),
                          );
                        },
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
                          'Enter agent name',
                          _nameController,
                        ),
                        _buildTextInput(
                          'Phone',
                          'Enter agent phone',
                          _phoneController,
                        ),
                        _buildTextInput(
                          'Email',
                          'Enter agent email',
                          _emailController,
                        ),
                        _buildTextInput(
                          'Address',
                          'Enter agent address',
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
