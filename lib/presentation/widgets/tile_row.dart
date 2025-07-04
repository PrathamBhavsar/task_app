import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';

class TileRow extends StatelessWidget {
  const TileRow({
    required this.key1, required this.value1, required this.key2, required this.value2, super.key,
  });

  final String key1, value1, key2, value2;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(key1, style: AppTexts.inputHintTextStyle),
          Text(value1, style: AppTexts.inputTextStyle),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(key2, style: AppTexts.inputHintTextStyle),
          Text(value2, style: AppTexts.inputTextStyle),
        ],
      ),
    ],
  );
}
