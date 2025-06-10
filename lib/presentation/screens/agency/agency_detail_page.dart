import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/tab_header.dart';
import '../home/widgets/dashboard_containers.dart';
import '../task/widgets/detailed_task_tile.dart';

class AgencyDetailPage extends StatelessWidget {
  const AgencyDetailPage({required this.agency, super.key});

  final User agency;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(agency.name, style: AppTexts.titleTextStyle),
          Text(agency.address, style: AppTexts.inputHintTextStyle),
        ],
      ),
    ),
    body: SafeArea(
      child: Consumer<TaskProvider>(
        builder:
            (context, provider, child) => SingleChildScrollView(
              child: Column(
                children: [
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Agency Overview',
                              style: AppTexts.titleTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(500)],
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => context.replace(
                                    AppRoutes.editAgency,
                                    extra: agency,
                                  ),
                              icon: Icon(
                                CustomIcon.squarePen,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Performance metrics and details',
                          style: AppTexts.inputHintTextStyle,
                        ),
                        20.hGap,
                        DashboardContainers(
                          list: DummyData.agencyDetailDashboard,
                        ),
                        10.hGap,
                        _buildInfoColumn(
                          'Contact Information',
                          agency.contactNo,
                        ),
                        _buildInfoColumn('Address', agency.address),
                        // Text(
                        //   'Service Areas',
                        //   style: AppTexts.inputHintTextStyle.copyWith(
                        //     fontVariations: [FontVariation.weight(600)],
                        //   ),
                        // ),
                        // 5.hGap,
                        // Wrap(
                        //   runSpacing: 10.h,
                        //   spacing: 5.w,
                        //   runAlignment: WrapAlignment.start,
                        //   alignment: WrapAlignment.start,
                        //   crossAxisAlignment: WrapCrossAlignment.start,
                        //   direction: Axis.horizontal,
                        //   children: [
                        //     ...List.generate(
                        //       agency.serviceAreas.length,
                        //       (index) => CustomTag(
                        //         text: agency.serviceAreas[index],
                        //         color: Colors.black,
                        //         textColor: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // 5.hGap,
                        // Text(
                        //   'Specialities',
                        //   style: AppTexts.inputHintTextStyle.copyWith(
                        //     fontVariations: [FontVariation.weight(600)],
                        //   ),
                        // ),
                        // 5.hGap,
                        // Wrap(
                        //   runSpacing: 10.h,
                        //   spacing: 5.w,
                        //   runAlignment: WrapAlignment.start,
                        //   alignment: WrapAlignment.start,
                        //   crossAxisAlignment: WrapCrossAlignment.start,
                        //   direction: Axis.horizontal,
                        //   children: [
                        //     ...List.generate(
                        //       agency.specialities.length,
                        //       (index) => CustomTag(
                        //         text: agency.specialities[index],
                        //         color: Colors.black,
                        //         textColor: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  TabHeader(
                    tabs: [
                      Tab(text: 'Pending'),
                      Tab(text: 'Completed'),
                      Tab(text: 'All'),
                    ],
                  ),
                  // Builder(
                  //   builder: (context) {
                  //     switch (provider.tabIndex) {
                  //       case 0:
                  //         return _buildList(context, Task.pendingTasks);
                  //       case 1:
                  //         return _buildList(context, Task.completedTasks);
                  //       default:
                  //         return _buildList(context, Task.sampleTasks);
                  //     }
                  //   },
                  // ),
                  10.hGap,
                  _buildQuickActions(context),
                  10.hGap,
                  _buildPerformanceMetrics(),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );

  Widget _buildQuickActions(BuildContext context) => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTexts.titleTextStyle.copyWith(
            fontVariations: [FontVariation.weight(500)],
          ),
        ),
        20.hGap,
        ActionButton(
          label: 'Assign New Task',
          prefixIcon: CustomIcon.clipboardList,
          onPress: () => context.push(AppRoutes.taskDetails),
          backgroundColor: Colors.black,
          fontColor: Colors.white,
        ),
        10.hGap,
        ActionButton(
          label: 'Call Agency',
          prefixIcon: CustomIcon.phone,
          onPress: () {},
        ),
      ],
    ),
  );

  Widget _buildPerformanceMetrics() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Metrics',
          style: AppTexts.titleTextStyle.copyWith(
            fontVariations: [FontVariation.weight(500)],
          ),
        ),
        ...List.generate(
          4,
          (index) => Column(
            children: [
              20.hGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DummyData.agencyDetailPerformanceMetrics[index]['title'],
                    style: AppTexts.labelTextStyle,
                  ),
                  Text(
                    '${DummyData.agencyDetailPerformanceMetrics[index]['data']}%'
                        .toString(),
                    style: AppTexts.labelTextStyle,
                  ),
                ],
              ),
              5.hGap,
              LinearProgressIndicator(
                value:
                    (DummyData.agencyDetailPerformanceMetrics[index]['data'])
                        .toDouble() /
                    100,
                minHeight: 5.h,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppColors.accent,
                color: AppColors.green,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildList(BuildContext context, List<Task> list) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        list.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: DetailedTaskTile(
            task: list[index],
            isCompleted: list[index].status == 'Completed',
          ),
        ),
      ),
    ],
  );

  Widget _buildInfoColumn(String title, String subtitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTexts.inputHintTextStyle.copyWith(
          fontVariations: [FontVariation.weight(600)],
        ),
      ),
      Text(subtitle, style: AppTexts.labelTextStyle),
      10.hGap,
    ],
  );
}
