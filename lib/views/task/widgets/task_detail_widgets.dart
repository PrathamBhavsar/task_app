import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../methods/show_bottom_modal.dart';
import 'client_name_dropdown.dart';

class RowWithIconAndWidget extends StatelessWidget {
  final IconData icon;
  final Widget widget;

  const RowWithIconAndWidget(
      {super.key, required this.icon, required this.widget});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: AppConsts.radius,
            ),
            child: Icon(icon, size: 32),
          ),
          AppPaddings.gapW(10),
          Expanded(child: widget),
        ],
      );
}

class DynamicRow extends StatelessWidget {
  const DynamicRow({
    super.key,
    required this.isSalesperson,
    required this.context,
    required this.label,
    required this.indexKey,
    required this.dataList,
    required this.widget,
    this.isStatus = false,
  });

  final bool isSalesperson;
  final bool isStatus;
  final BuildContext context;
  final String label;
  final String indexKey;
  final List<Map<String, dynamic>>? dataList;
  final Widget widget;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isSalesperson,
        child: Padding(
          padding: AppPaddings.appPadding,
          child: _buildRowWithTextAndWidget(
            label: label,
            widget: widget,
            onTap: () => showClientsBottomSheet(
                context, dataList ?? [], label, indexKey, isStatus),
          ),
        ),
      );
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget(
      {super.key,
      required this.context,
      this.dataList,
      required this.index,
      required this.title,
      required this.name,
      required this.indexKey,
      required this.defaultText,
      required this.isNewTask,
      required this.dealNo});
  final BuildContext context;
  final List<Map<String, dynamic>>? dataList;
  final int index;
  final String title;
  final String name;
  final String indexKey;
  final String defaultText;
  final bool isNewTask;
  final String dealNo;
  @override
  Widget build(BuildContext context) => ClientNameDropdown(
        name:
            dataList?.isNotEmpty == true ? dataList![index][name] : defaultText,
        clientList: dataList ?? [],
        onTap: () => showClientsBottomSheet(
            context, dataList ?? [], title, indexKey, false),
        dealNo: dealNo,
        isNewTask: isNewTask,
      );
}

Widget _buildRowWithTextAndWidget({
  required String label,
  required Widget widget,
  VoidCallback? onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTexts.headingStyle),
            widget,
          ],
        ),
      ),
    );
