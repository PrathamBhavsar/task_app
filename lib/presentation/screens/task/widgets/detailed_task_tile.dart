import 'package:flutter/material.dart';
import '../../../../domain/entities/task.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/date_formatter.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';

class DetailedTaskTile extends StatelessWidget {
  const DetailedTaskTile({
    required this.task,
    super.key,
    this.isCompleted = false,
  });

  final Task task;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: AppTexts.headingTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.hGap,
                  Text(
                    task.client.name,
                    style: AppTexts.inputTextStyle.copyWith(
                      fontVariations: [FontVariation.weight(700)],
                    ),
                  ),
                  task.agency != null
                      ? Text(
                        "Agency: ${task.agency}",
                        style: AppTexts.inputHintTextStyle,
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            CustomTag(
              text: task.status.name,
              color: AppColors.accent,
              textColor: Colors.black,
            ),
          ],
        ),
        10.hGap,
        // TileRow(
        //   key1: 'Product Type',
        //   value1: task.product.name,
        //   key2: 'Scheduled Date',
        //   value2: task.createdAt.toString(),
        // ),
        5.hGap,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due Date', style: AppTexts.inputHintTextStyle),
            Text(task.dueDate.toPrettyDate(), style: AppTexts.inputTextStyle),
          ],
        ),
        10.hGap,
        isCompleted
            ? Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: 'Measurements',
                    onPress: () {},
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
                10.wGap,
                Expanded(
                  child: ActionButton(label: 'Edit Bill', onPress: () {}),
                ),
              ],
            )
            : Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: 'Add Measurement',
                    onPress: () {},
                    backgroundColor: Colors.black,
                    fontColor: Colors.white,
                  ),
                ),
                10.wGap,
                Expanded(
                  child: ActionButton(label: 'View Details', onPress: () {}),
                ),
              ],
            ),
      ],
    ),
  );
}
