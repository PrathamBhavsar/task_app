import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/quotation_provider.dart';
import 'package:task_app/views/task/widgets/measurement/size_tile.dart';
import 'package:task_app/views/task/widgets/measurement/title_tile.dart';

class RoomQuote extends StatelessWidget {
  const RoomQuote({
    super.key,
    required this.roomNames,
    required this.windowNames,
    required this.windowAreas,
    required this.windowRates,
    required this.windowAmounts,
    required this.windowMaterials,
    required this.totalAmount,
  });

  final String roomNames;
  final List<String> windowNames;
  final List<String> windowAreas;
  final List<String> windowRates;
  final List<String> windowAmounts;
  final List<String> windowMaterials;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(
          roomName: roomNames,
          isQuote: true,
        ),
        AppPaddings.gapH(8),
        ...List.generate(
          windowNames.length,
          (index) => QuoteWindowTile(
            windowName: windowNames[index],
            windowMaterial: windowMaterials[index],
            windowRate: windowRates[index],
            windowAmount: windowAmounts[index],
            windowArea: windowAreas[index],
            totalAmount: totalAmount,
          ),
        ),
        AppPaddings.gapH(10),
      ],
    );
  }
}

class QuoteWindowTile extends StatelessWidget {
  QuoteWindowTile(
      {super.key,
      required this.windowName,
      required this.windowArea,
      required this.windowMaterial,
      required this.windowRate,
      required this.windowAmount,
      required this.totalAmount});
  final String windowName;
  final String windowMaterial;
  final String windowRate;
  final String windowAmount;
  final String windowArea;
  final String totalAmount;

  TextStyle textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              windowName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Text(
              "Area: $windowArea",
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Material',
              style: textStyle,
            ),
            Text(
              windowMaterial,
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rate',
              style: textStyle,
            ),
            Text(
              windowRate,
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'amount',
              style: textStyle,
            ),
            Text(
              windowAmount,
              style: textStyle,
            ),
          ],
        ),
        AppPaddings.gapH(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount',
              style: textStyle,
            ),
            Text(
              totalAmount,
              style: textStyle,
            ),
          ],
        ),
        AppPaddings.gapH(5)
      ],
    );
  }
}
