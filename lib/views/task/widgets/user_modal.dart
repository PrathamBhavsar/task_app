import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/app_keys.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/widgets/custom_tag.dart';

class ClientsBottomSheetWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final String name;
  final String indexKey;

  const ClientsBottomSheetWidget({
    Key? key,
    required this.list,
    required this.name,
    required this.indexKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: AppConsts.radius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: list.asMap().entries.map((entry) {
                  final index = entry.key;
                  final user = entry.value;
                  final userName = user[AppKeys.name];
                  final Color color = TaskProvider.instance.stringToColor(
                      user[AppKeys.color] ?? user[UserDetails.profileBgColor]);

                  bool isSelected = false;
                  if (indexKey == IndexKeys.agencyIndex ||
                      indexKey == IndexKeys.designerIndex ||
                      indexKey == IndexKeys.salespersonIndex) {
                    // Multi-selection
                    isSelected =
                        provider.selectedIndices[indexKey]?.contains(index) ??
                            false;
                  } else {
                    // Single-selection
                    isSelected = provider.selectedIndices[indexKey] == index;
                  }

                  return GestureDetector(
                    onTap: () {
                      if (indexKey == IndexKeys.agencyIndex ||
                          indexKey == IndexKeys.designerIndex ||
                          indexKey == IndexKeys.salespersonIndex) {
                        // Multi-selection
                        List selectedList =
                            provider.selectedIndices[indexKey] ?? [];
                        if (selectedList.contains(index)) {
                          selectedList.remove(index);
                        } else {
                          selectedList.add(index);
                        }
                        provider.updateSelectedIndex(indexKey, selectedList);
                      } else {
                        // Single-selection
                        provider.updateSelectedIndex(indexKey, index);
                        Navigator.pop(context);
                      }
                    },
                    child: CustomTag(
                      color: color,
                      text: userName,
                      isSelected: isSelected,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
