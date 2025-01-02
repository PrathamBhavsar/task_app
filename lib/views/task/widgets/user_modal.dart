import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/widgets/custom_tag.dart';

class ClientsBottomSheetWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final String name;
  final String field;

  const ClientsBottomSheetWidget({
    Key? key,
    required this.list,
    required this.name,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
                  final userName = user['name'];
                  final Color color =
                      TaskProvider.instance.stringToColor(user['color']);

                  bool isSelected = false;
                  if (field == 'agency' ||
                      field == 'designers' ||
                      field == 'salespersons') {
                    // Multi-selection
                    isSelected =
                        provider.selectedIndices[field]?.contains(index) ??
                            false;
                  } else {
                    // Single-selection
                    isSelected = provider.selectedIndices[field] == index;
                  }

                  return GestureDetector(
                    onTap: () {
                      if (field == 'agency' ||
                          field == 'designers' ||
                          field == 'salespersons') {
                        // Multi-selection
                        List selectedList =
                            provider.selectedIndices[field] ?? [];
                        if (selectedList.contains(index)) {
                          selectedList.remove(index);
                        } else {
                          selectedList.add(index);
                        }
                        provider.updateSelectedIndex(field, selectedList);
                      } else {
                        // Single-selection
                        provider.updateSelectedIndex(field, index);
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
