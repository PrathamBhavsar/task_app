import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_keys.dart';
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
                AppPaddings.gapH(10),
                isStatus
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final user = list[index];
                            final userName = user[AppKeys.name];
                            final Color color = TaskProvider.instance
                                .stringToColor(user[AppKeys.color] ??
                                    user[UserDetails.profileBgColor]);

                            bool isSelected =
                                provider.selectedIndices[indexKey] == index;

                            return GestureDetector(
                              onTap: () {
                                provider.updateSelectedIndex(indexKey, index);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: CustomTag(
                                  color: color,
                                  text: userName,
                                  isSelected: isSelected,
                                ),
                              ),
                            );
                          },
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
                              Navigator.pop(context);
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
