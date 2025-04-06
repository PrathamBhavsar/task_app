import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/appointment.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/data_container.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: DummyData.managerDashboard[0]['title'],
              subtitle: DummyData.managerDashboard[0]['subtitle'],
              data: DummyData.managerDashboard[0]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: DummyData.managerDashboard[1]['title'],
              subtitle: DummyData.managerDashboard[1]['subtitle'],
              data: DummyData.managerDashboard[1]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      10.hGap,
      Row(
        children: [
          Expanded(
            child: DataContainer(
              title: DummyData.managerDashboard[2]['title'],
              subtitle: DummyData.managerDashboard[2]['subtitle'],
              data: DummyData.managerDashboard[2]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
          10.wGap,
          Expanded(
            child: DataContainer(
              title: DummyData.managerDashboard[3]['title'],
              subtitle: DummyData.managerDashboard[3]['subtitle'],
              data: DummyData.managerDashboard[3]['data'],
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),

      10.hGap,
      BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Appointments", style: AppTexts.titleTextStyle),
            5.hGap,
            Text(
              "Manage appointments and assign employees to services",
              style: AppTexts.inputHintTextStyle,
            ),
            20.hGap,
            ...List.generate(
              3,
              (index) => Padding(
                padding:
                    index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
                child: BorderedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "#00${index + 1}",
                            style: AppTexts.titleTextStyle,
                          ),
                          10.wGap,
                          Text(
                            Appointment.sampleAppointments[index].time,
                            style: AppTexts.inputHintTextStyle,
                          ),
                        ],
                      ),
                      10.hGap,
                      Text(
                        Appointment.sampleAppointments[index].name,
                        style: AppTexts.titleTextStyle,
                      ),
                      5.hGap,
                      Text(
                        Appointment.sampleAppointments[index].services,
                        style: AppTexts.inputHintTextStyle,
                      ),
                      10.hGap,
                      Row(
                        children: [
                          Expanded(
                            child: ActionButton(
                              label: 'Complete',
                              onPress: () {},
                              backgroundColor: Colors.white,
                            ),
                          ),
                          10.wGap,
                          Expanded(
                            child: ActionButton(
                              label: 'Assign',
                              onPress: () {},
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
