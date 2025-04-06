import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';

class NewProductScreen extends StatelessWidget {
  const NewProductScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      title: Text('Add New Product', style: AppTexts.titleTextStyle),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add a Product', style: AppTexts.titleTextStyle),
        5.hGap,
        Text(
          'Enter the details of the new product.',
          style: AppTexts.inputTextStyle,
        ),
        30.hGap,
        _buildInputField('Product Name', 'Enter product name'),
        _buildInputField('Brand', 'Enter brand name'),
        _buildInputField('Expiry Date', 'Enter expiry date'),
        Spacer(),
        ActionButton(
          label: 'Add Product',
          onPress: () {},
          backgroundColor: Colors.black,
          fontColor: Colors.white,
        ),
      ],
    ).padAll(AppPaddings.appPaddingInt),
  );

  Widget _buildInputField(String title, String hint) => Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.headingTextStyle),
        10.hGap,
        CustomTextField(hintTxt: hint),
      ],
    ),
  );
}
