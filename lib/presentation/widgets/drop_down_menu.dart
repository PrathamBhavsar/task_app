import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';

class ModelDropdownMenu<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final ValueChanged<T>? onChanged;
  final bool isEnabled;
  final String Function(T) labelBuilder;
  final String Function(T) idBuilder;

  const ModelDropdownMenu({
    required this.items,
    required this.labelBuilder,
    required this.idBuilder,
    super.key,
    this.initialValue,
    this.onChanged,
    this.isEnabled = true,
  });

  @override
  _ModelDropdownMenuState<T> createState() => _ModelDropdownMenuState<T>();
}

class _ModelDropdownMenuState<T> extends State<ModelDropdownMenu<T>> {
  late T selectedValue;

  @override
  void didUpdateWidget(covariant ModelDropdownMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != null) {
      selectedValue = widget.initialValue as T;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedValue =
        widget.initialValue ??
        (widget.items.isNotEmpty
            ? widget.items.first
            : throw Exception('No initial value and items empty'));
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder:
        (context, constraints) => Theme(
          data: Theme.of(context).copyWith(
            dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    kIsWeb
                        ? EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w)
                        : EdgeInsets.symmetric(
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
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: DropdownMenu<T>(
              enabled: widget.isEnabled,
              width: double.infinity,
              initialSelection: selectedValue,
              textStyle:
                  kIsWeb
                      ? constraints.maxWidth < 600
                          ? AppTexts.inputTextStyle.copyWith(fontSize: 15.sp)
                          : AppTexts.inputTextStyle.copyWith(fontSize: 4.sp)
                      : AppTexts.inputTextStyle,
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
                contentPadding:
                    kIsWeb
                        ? EdgeInsets.symmetric(vertical: 9.h, horizontal: 8.w)
                        : EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.w,
                        ),
                hintStyle: AppTexts.inputHintTextStyle,
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.accent,
                  ),
                  borderRadius: AppBorders.radius,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.accent,
                  ),
                  borderRadius: AppBorders.radius,
                ),
              ),
              dropdownMenuEntries:
                  widget.items.map((item) {
                    final label = widget.labelBuilder(item);
                    return DropdownMenuEntry<T>(
                      value: item,
                      label: label,
                      labelWidget: Tooltip(
                        message: label,
                        child: Text(
                          label,
                          style:
                              kIsWeb
                                  ? constraints.maxWidth < 600
                                      ? AppTexts.inputTextStyle.copyWith(
                                        fontSize: 15.sp,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                      : AppTexts.inputTextStyle.copyWith(
                                        fontSize: 5.sp,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  : AppTexts.inputTextStyle.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ),
                    );
                  }).toList(),
              onSelected: (value) {
                if (value != null) {
                  setState(() => selectedValue = value);
                  widget.onChanged?.call(value);
                }
              },
            ),
          ),
        ),
  );
}
