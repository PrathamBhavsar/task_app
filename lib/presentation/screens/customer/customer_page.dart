import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/customer.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/tab_header.dart';

List<Customer> customers = Customer.sampleCustomers;

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customers', style: AppTexts.titleTextStyle),
            10.hGap,
            CustomTextField(hintTxt: 'Search customers...'),
            10.hGap,
            _buildCustomers(),
          ],
        ),
  );
  Widget _buildCustomers() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        customers.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: BorderedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(customers[index].name, style: AppTexts.titleTextStyle),
                        Text(
                          customers[index].email,
                          style: AppTexts.inputHintTextStyle,
                        ),
                      ],
                    ),
                    CustomTag(
                      text: customers[index].status,
                      color: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                20.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone', style: AppTexts.inputHintTextStyle),
                        Text('Orders', style: AppTexts.inputHintTextStyle),
                        Text('Total Spent', style: AppTexts.inputHintTextStyle),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          customers[index].phone,
                          style: AppTexts.inputTextStyle,
                        ),
                        Text(
                          customers[index].orders.toString(),
                          style: AppTexts.inputTextStyle,
                        ),
                        Text(
                          customers[index].totalSpent,
                          style: AppTexts.inputTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
