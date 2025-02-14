import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_keys.dart';
import '../../../extensions/app_paddings.dart';
import '../../../providers/task_provider.dart';
import '../../../widgets/custom_tag.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final String name;
  final String indexKey;
  final bool isStatus;

  const CustomBottomSheetWidget({
    super.key,
    required this.list,
    required this.name,
    required this.indexKey,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (isStatus) {
            list.sort((a, b) => a['task_order'].compareTo(b['task_order']));
          }

          Map<String, List<Map<String, dynamic>>> groupedList = {};
          for (var item in list) {
            final category = item[AppKeys.name].split(':').first;
            groupedList.putIfAbsent(category, () => []).add(item);
          }

          return Container(
            padding: EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: AppBorders.radius,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                10.hGap,
                isStatus
                    ? Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: groupedList.entries
                              .map((entry) => ExpansionTile(
                                    title: Text(
                                      entry.key,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          spacing: 8.0,
                                          runSpacing: 8.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          runAlignment: WrapAlignment.start,
                                          children: entry.value.map((status) {
                                            final userName =
                                                status[AppKeys.name];
                                            final Color color = TaskProvider
                                                .instance
                                                .stringToColor(
                                                    status[AppKeys.color] ??
                                                        status[UserDetails
                                                            .profileBgColor]);

                                            bool isSelected =
                                                provider.selectedIndices[
                                                        indexKey] ==
                                                    list.indexOf(status);

                                            return GestureDetector(
                                              onTap: () {
                                                provider.updateSelectedIndex(
                                                    indexKey,
                                                    list.indexOf(status));
                                                context.pop();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: CustomTag(
                                                  color: color,
                                                  text: userName
                                                      .split(':')
                                                      .last
                                                      .trim(),
                                                  isSelected: isSelected,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      )
                    : Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: list.asMap().entries.map((entry) {
                          final index = entry.key;
                          final user = entry.value;
                          final userName = user[AppKeys.name];
                          final Color color = TaskProvider.instance
                              .stringToColor(user[AppKeys.color] ??
                                  user[UserDetails.profileBgColor]);

                          bool isSelected =
                              provider.selectedIndices[indexKey] == index;

                          return GestureDetector(
                            onTap: () {
                              provider.updateSelectedIndex(indexKey, index);
                              context.pop();
                            },
                            child: CustomTag(
                              color: color,
                              text: userName,
                              isSelected: isSelected,
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          );
        },
      );
}
