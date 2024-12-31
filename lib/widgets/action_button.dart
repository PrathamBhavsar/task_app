import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    super.key,
    required this.btnTxt,
    required this.onPress,
    required this.fontColor,
    required this.backgroundColor,
  });

  final String btnTxt;
  final VoidCallback onPress;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
        ),
        child: Text(
          btnTxt,
          style: TextStyle(
            color: fontColor,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
