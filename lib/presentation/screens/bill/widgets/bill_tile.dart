import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/bill.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/custom_icons.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';
import '../../../widgets/tile_row.dart';

class BillTile extends StatelessWidget {
  const BillTile({required this.bill, super.key});

  final Bill bill;

  @override
  Widget build(BuildContext context) => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   bill.name,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: AppTexts.headingTextStyle,
                  // ),
                  // Text(bill.agency, style: AppTexts.inputHintTextStyle),
                  // Text(bill.task, style: AppTexts.inputHintTextStyle),
                  // Text(bill.place, style: AppTexts.inputHintTextStyle),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTag(
                  text: bill.status,
                  color: Colors.black,
                  textColor: Colors.white,
                ),
                5.hGap,
                Text('\$${bill.total}', style: AppTexts.inputTextStyle),
              ],
            ),
          ],
        ),
        10.hGap,
        TileRow(
          key1: 'Bill Date',
          value1: bill.createdAt.toString(),
          key2: 'Due Date',
          value2: bill.dueDate.toString(),
        ),
        10.hGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              stepWidth: 20,
              child: ActionButton(
                label: 'View Task',
                onPress: () {},
                prefixIcon: CustomIcon.eye,
              ),
            ),
            10.wGap,
            IntrinsicWidth(
              stepWidth: 20,
              child: ActionButton(
                label: 'Review Bill',
                backgroundColor: Colors.black,
                fontColor: Colors.white,
                onPress: () => context.push(AppRoutes.reviewBill),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
