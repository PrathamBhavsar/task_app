import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const CustomDropdownMenu({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
  });

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue =
        widget.initialValue ??
        (widget.items.isNotEmpty ? widget.items.first : '');
  }

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          labelStyle: AppTexts.inputTextStyle,
        ),
        textStyle: AppTexts.inputTextStyle,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
    ),
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: DropdownMenu<String>(
        width: double.infinity,
        initialSelection: selectedValue,
        textStyle: AppTexts.inputTextStyle,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: AppBorders.radius),
          ),
        ),
        menuHeight: 400.h,
        inputDecorationTheme: InputDecorationTheme(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          hintStyle: AppTexts.inputHintTextStyle,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.accent),
            borderRadius: AppBorders.radius,
          ),
        ),
        dropdownMenuEntries:
            widget.items
                .map(
                  (item) => DropdownMenuEntry(
                    labelWidget: Text(item, style: AppTexts.inputTextStyle),
                    value: item,
                    label: item,
                  ),
                )
                .toList(),
        onSelected: (value) {
          if (value != null) {
            setState(() => selectedValue = value);
            widget.onChanged?.call(value);
          }
        },
      ),
    ),
  );
}
