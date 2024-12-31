import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/widgets/circle_icons.dart';

class CompleteTasksList extends StatelessWidget {
  const CompleteTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2)),
            child: Container(
              color: Colors.red,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dashboard Design for Admin',
                        style:
                            TextStyle(fontSize: 22, fontWeight: AppTexts.fW900),
                      ),
                      CircleIcons(
                        icon: Icons.more_horiz_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      ChoiceChip(label: Text('Low'), selected: true),
                      ChoiceChip(label: Text('Meeting'), selected: false),
                    ],
                  ),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded),
                          Text('14 Oct, 2024')
                        ],
                      ),
                    ],
                    OverlappingCircles(numberOfCircles: 5),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
