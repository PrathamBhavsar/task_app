import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/appointment.dart';
import '../../../data/models/employee.dart';
import '../../../data/models/product.dart';
import '../../../data/models/services.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/tab_header.dart';

class NewTransactionScreen extends StatelessWidget {
  const NewTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
    ),
    body: SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Appointment', style: AppTexts.titleTextStyle),
            5.hGap,
            Text('Choose an open appointment', style: AppTexts.inputTextStyle),
            10.hGap,
            CustomDropdownMenu(
              items: Appointment.names,
              initialValue: "Select Appointment",
            ),
            _buildDivider(),
            Consumer<TransactionProvider>(
              builder:
                  (
                    BuildContext context,
                    TransactionProvider provider,
                    Widget? child,
                  ) => Column(
                    children: [
                      TabHeader(
                        provider: provider,
                        tabs: [Tab(text: 'Services'), Tab(text: 'Products')],
                      ),
                      _buildTabWidget(provider),
                      _buildDivider(),
                      _buildPaymentDetailsWidget(provider),
                      ActionButton(
                        label: 'Complete Transaction',
                        fontColor: Colors.white,
                        backgroundColor: Colors.black,
                        onPress: () {},
                      ),
                    ],
                  ),
            ),
          ],
        ).padAll(AppPaddings.appPaddingInt),
      ),
    ),
  );

  Widget _buildPaymentDetailsWidget(TransactionProvider provider) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Payment Details', style: AppTexts.titleTextStyle),
      10.hGap,
      Text('Payment mode', style: AppTexts.headingTextStyle),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio(
                activeColor: Colors.black,
                value: 'Cash',
                groupValue: provider.selectedPaymentMode,
                onChanged: (value) {
                  provider.setPaymentMode(value as String);
                },
              ),
              Text('Cash', style: AppTexts.inputTextStyle),
            ],
          ),
          Row(
            children: [
              Radio(
                activeColor: Colors.black,
                value: 'Card',
                groupValue: provider.selectedPaymentMode,
                onChanged: (value) {
                  provider.setPaymentMode(value as String);
                },
              ),
              Text('Card', style: AppTexts.inputTextStyle),
            ],
          ),
        ],
      ),
      _buildDivider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount:', style: AppTexts.headingTextStyle),
          Text('\$0.00', style: AppTexts.titleTextStyle),
        ],
      ),
      20.hGap,
    ],
  );

  Widget _buildTabWidget(
    TransactionProvider provider,
  ) => Consumer<TransactionProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.isFirst ? 'Services' : 'Products',
              style: AppTexts.titleTextStyle,
            ),
            5.hGap,
            Text(
              'Add ${provider.isFirst ? 'services' : 'products'} to this transaction',
              style: AppTexts.inputTextStyle,
            ),
            ...List.generate(
              (provider.isFirst ? provider.services : provider.products).clamp(
                1,
                100,
              ),
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.hGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isFirst ? 'Service' : 'Product',
                        style: AppTexts.headingTextStyle,
                      ),
                      GestureDetector(
                        onTap:
                            () =>
                                provider.isFirst
                                    ? provider.removeService()
                                    : provider.removeProduct(),
                        child: Text(
                          'Remove',
                          style: AppTexts.headingTextStyle.copyWith(
                            color: AppColors.errorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.hGap,
                  provider.isFirst
                      ? CustomDropdownMenu(
                        items: Service.names,
                        initialValue: Service.names.first,
                      )
                      : CustomDropdownMenu(
                        items: Product.names,
                        initialValue: Product.names.first,
                      ),
                  10.hGap,
                  Text('Employee', style: AppTexts.headingTextStyle),
                  10.hGap,
                  CustomDropdownMenu(
                    items: Employee.names,
                    initialValue: Employee.names.first,
                  ),
                  10.hGap,
                  _buildInputField('Amount', 'Enter amount'),
                  (provider.isFirst
                          ? provider.services > 1
                          : provider.products > 1)
                      ? _buildDivider()
                      : SizedBox.shrink(),
                ],
              ),
            ),
            20.hGap,
            ActionButton(
              label: 'Add Another ${provider.isFirst ? 'Service' : 'Product'}',
              onPress:
                  () =>
                      provider.isFirst
                          ? provider.addService()
                          : provider.addProduct(),
            ),
          ],
        ),
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

  Widget _buildDivider() =>
      Divider(color: AppColors.accent).padSymmetric(vertical: 10.h);
}
