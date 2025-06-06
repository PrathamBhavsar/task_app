import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/customer.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import 'widgets/customer_tile.dart';

List<Customer> customers = Customer.sampleCustomers;

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Customers', style: AppTexts.titleTextStyle),
                IntrinsicWidth(
                  child: ActionButton(
                    label: 'New Customer',
                    onPress: () => context.push(AppRoutes.newCustomer),
                    prefixIcon: CustomIcon.badgePlus,
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            10.hGap,
            CustomTextField(hintTxt: 'Search customers...', isSearch: true),
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
          child: CustomerTile(customer: customers[index]),
        ),
      ),
    ],
  );
}
