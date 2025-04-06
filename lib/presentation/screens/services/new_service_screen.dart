import 'package:flutter/material.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';

class NewServiceScreen extends StatelessWidget {
  const NewServiceScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      title: Text('Add New Service', style: AppTexts.titleTextStyle),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add a Service', style: AppTexts.titleTextStyle),
        5.hGap,
        Text(
          'Enter the details of the new service.',
          style: AppTexts.inputTextStyle,
        ),
        30.hGap,
        Text('Service Name', style: AppTexts.labelTextStyle),
        10.hGap,
        CustomTextField(hintTxt: 'Enter service name'),
        Spacer(),
        ActionButton(
          label: 'Add Service',
          onPress: () {},
          backgroundColor: Colors.black,
          fontColor: Colors.white,
        ),
      ],
    ).padAll(AppPaddings.appPaddingInt),
  );
}
