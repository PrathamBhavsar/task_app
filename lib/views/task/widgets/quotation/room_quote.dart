import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../measurement/title_tile.dart';

class RoomQuote extends StatelessWidget {
  const RoomQuote({
    super.key,
    required this.roomNames,
    required this.windowNames,
    required this.windowAreas,
    required this.windowRates,
    required this.windowAmounts,
    required this.windowMaterials,
    required this.windowTypes,
    required this.windowRemarks,
  });

  final String roomNames;
  final List<String> windowNames;
  final List<String> windowTypes;
  final List<String> windowRemarks;
  final List<String> windowAreas;
  final List<String> windowRates;
  final List<String> windowAmounts;
  final List<String> windowMaterials;

  @override
  Widget build(BuildContext context) => Column(
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
            windowType: windowTypes[index],
            windowRate: windowRates[index],
            windowAmount: windowAmounts[index],
            windowArea: windowAreas[index],
            windowRemark: windowRemarks[index],
          ),
        ),
        AppPaddings.gapH(10),
      ],
    );
}

class QuoteWindowTile extends StatelessWidget {
  QuoteWindowTile({
    super.key,
    required this.windowName,
    required this.windowArea,
    required this.windowMaterial,
    required this.windowRate,
    required this.windowAmount,
    required this.windowType,
    required this.windowRemark,
  });
  final String windowName;
  final String windowType;
  final String windowMaterial;
  final String windowRate;
  final String windowAmount;
  final String windowArea;
  final String windowRemark;

  TextStyle textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) => Column(
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
              'Type',
              style: textStyle,
            ),
            Text(
              windowType,
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
              'Amount',
              style: textStyle,
            ),
            Text(
              windowAmount,
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remarks',
              style: textStyle,
            ),
            Text(
              windowRemark,
              style: textStyle,
            ),
          ],
        ),
        AppPaddings.gapH(5)
      ],
    );
}
