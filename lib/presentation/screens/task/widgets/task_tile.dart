import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/entities/task.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/color_translator.dart';
import '../../../../utils/extensions/date_formatter.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: InkWell(
        onTap: () => context.push(AppRoutes.taskDetails, extra: task),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        task.name,
                        style: AppTexts.headingTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      CustomTag(
                        text: task.status.name,
                        color: task.status.color.toColor(),
                      ),
                    ],
                  ),
                  5.hGap,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.client.name,
                            style: AppTexts.inputHintTextStyle,
                          ),
                          task.agency != null
                              ? Text(
                                "Agency: ${task.agency!.name}",
                                style: AppTexts.inputHintTextStyle,
                              )
                              : SizedBox.shrink(),
                        ],
                      ),
                      Text(
                        task.dueDate.toPrettyDate(),
                        style: AppTexts.inputTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
