import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants/app_consts.dart';
import '../../../../../utils/extensions/app_paddings.dart';
import '../../../../providers/task_provider.dart';
import '../../../home/pages/widgets/custom_tag.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final List<dynamic> list;
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
            list.sort((a, b) => a.taskOrder.compareTo(b.taskOrder));
          }

          Map<String, List<dynamic>> groupedList = {};
          for (var item in list) {
            final category = item.name.split(':').first;
            groupedList.putIfAbsent(category, () => []).add(item);
          }

          return Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: AppBorders.radius,
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          spacing: 8.0,
                                          runSpacing: 8.0,
                                          children: entry.value.map((status) {
                                            final String userName = status.name;
                                            final int statusIndex =
                                                list.indexOf(status);
                                            bool isSelected =
                                                provider.selectedIndices[
                                                        indexKey] ==
                                                    statusIndex;

                                            return GestureDetector(
                                              onTap: () {
                                                provider.updateSelectedIndex(
                                                    indexKey, statusIndex);
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: CustomTag(
                                                  color: Colors.blueAccent,
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
                        children: list.asMap().entries.map((entry) {
                          final index = entry.key;
                          final user = entry.value;
                          final String userName = user.name;
                          bool isSelected =
                              provider.selectedIndices[indexKey] == index;

                          return GestureDetector(
                            onTap: () {
                              provider.updateSelectedIndex(indexKey, index);
                              Navigator.pop(context);
                            },
                            child: CustomTag(
                              color: Colors.greenAccent,
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
