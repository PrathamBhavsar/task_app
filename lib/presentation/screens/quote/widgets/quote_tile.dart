import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/quote.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';
import '../../../widgets/tile_row.dart';

class QuoteTile extends StatelessWidget {
  const QuoteTile({required this.quote, super.key});

  final Quote quote;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => context.push(AppRoutes.quoteDetails, extra: quote),
    child: BorderedContainer(
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
                    Text(
                      quote.name,
                      overflow: TextOverflow.ellipsis,
                      style: AppTexts.headingTextStyle,
                    ),
                    Text(
                      quote.customer.name,
                      style: AppTexts.inputHintTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTag(
                    text: quote.status,
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                  5.hGap,
                  Text('\$${quote.amount}', style: AppTexts.inputTextStyle),
                ],
              ),
            ],
          ),
          10.hGap,
          TileRow(
            key1: 'Quote Date',
            value1: quote.createdAt,
            key2: 'Expires',
            value2: quote.dueDate,
          ),
        ],
      ),
    ),
  );
}
