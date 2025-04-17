import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/agency.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Edit Task', style: AppTexts.titleTextStyle)],
      ),
    ),
    body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Consumer<TaskProvider>(
        builder:
            (context, provider, child) => SingleChildScrollView(
              child: Column(
                children: [
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Details',
                          style: AppTexts.titleTextStyle.copyWith(
                            fontVariations: [FontVariation.weight(600)],
                          ),
                        ),
                        20.hGap,
                        _buildTextInput('Task Title', 'Enter task title'),
                        Text('Stage', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(
                          items: [
                            'Product Selection',
                            'Measurement',
                            'Quote',
                            'Sales Order',
                            'Delivery & Payment',
                          ],
                        ),
                        10.hGap,
                        Text('Priority', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(items: ['Low', 'Medium', 'High']),
                        10.hGap,
                        _buildTextInput('Product', 'Enter task priority'),
                        _buildTextInput('Due Date', 'Enter due date'),
                        _buildTextInput('Notes', 'Add note', isMultiline: true),
                      ],
                    ),
                  ),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer Information',
                          style: AppTexts.titleTextStyle.copyWith(
                            fontVariations: [FontVariation.weight(600)],
                          ),
                        ),
                        20.hGap,
                        _buildTextInput('Customer Name', 'Enter customer name'),
                        _buildTextInput('Email', 'Enter customer email'),
                        _buildTextInput('Phone', 'Enter customer phone'),
                      ],
                    ),
                  ),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agency Information',
                          style: AppTexts.titleTextStyle.copyWith(
                            fontVariations: [FontVariation.weight(600)],
                          ),
                        ),
                        20.hGap,
                        Text('Agency', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(items: Agency.names),
                        10.hGap,
                        _buildTextInput('Agency Phone', 'Enter agency phone'),
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
    String hint, {
    bool isMultiline = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomTextField(hintTxt: hint, isMultiline: isMultiline),
      10.hGap,
    ],
  );
}
