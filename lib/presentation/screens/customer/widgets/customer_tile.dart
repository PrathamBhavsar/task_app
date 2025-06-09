import 'package:flutter/material.dart';

import '../../../../domain/entities/customer.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';
import '../../../widgets/tile_row.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    required this.customer,
    super.key,
    this.isSelected = false,
  });

  final Customer customer;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => BorderedContainer(
    isSelected: isSelected,
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
                Text(customer.name, style: AppTexts.headingTextStyle),
                Text(customer.email, style: AppTexts.inputHintTextStyle),
              ],
            ),
            CustomTag(
              text: customer.status,
              color: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
        10.hGap,
        TileRow(
          key1: 'Phone',
          value1: customer.phone,
          key2: 'Total Spent',
          value2: customer.totalSpent,
        ),
        10.hGap,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Orders', style: AppTexts.inputHintTextStyle),
            Text(customer.orders.toString(), style: AppTexts.inputTextStyle),
          ],
        ),
      ],
    ),
  );
}
