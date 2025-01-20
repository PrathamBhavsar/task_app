import 'package:flutter/material.dart';
import 'package:task_app/providers/quotation_provider.dart';

class TitleTile extends StatelessWidget {
  const TitleTile({super.key, required this.roomName, this.isQuote = false});
  final String roomName;
  final bool isQuote;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          roomName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        if (isQuote)
          Text(
            QuotationProvider.instance.calculateRoomTotal(roomName).toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
      ],
    );
  }
}
