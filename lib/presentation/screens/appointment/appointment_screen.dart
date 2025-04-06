import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/Appointment.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/tab_header.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Appointment',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed: () => context.pushNamed('newAppointment'),
    ),
    appBar: AppBar(
      title: Text('Appointment Management', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(child: _buildUI(context)),
  );

  Widget _buildUI(BuildContext context) => Consumer<TransactionProvider>(
    builder:
        (BuildContext context, TransactionProvider provider, Widget? child) =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Appointment List", style: AppTexts.titleTextStyle),
                5.hGap,
                Text(
                  "Manage your Appointments",
                  style: AppTexts.inputHintTextStyle,
                ),
                20.hGap,
                TabHeader(
                  provider: provider,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Waiting'),
                    Tab(text: 'Completed'),
                  ],
                ),
                _buildList(
                  context,
                  provider.tabIndex == 2
                      ? Appointment.completed
                      : provider.tabIndex == 1
                      ? Appointment.waiting
                      : Appointment.sampleAppointments,
                ),
              ],
            ).padAll(AppPaddings.appPaddingInt),
  );
}

Widget _buildList(BuildContext context, List<Appointment> list) => Column(
  children: [
    ...List.generate(
      list.length,
      (index) => Padding(
        padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(list[index].name, style: AppTexts.headingTextStyle),
                      Text(
                        list[index].time,
                        style: AppTexts.inputHintTextStyle,
                      ),
                      Text(
                        list[index].status,
                        style: AppTexts.inputHintTextStyle.copyWith(
                          color:
                              list[index].status == "Completed"
                                  ? AppColors.green
                                  : list[index].status == "Pending"
                                  ? Colors.amber
                                  : AppColors.errorRed,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ActionButton(
                    label: 'View',
                    onPress:
                        () => context.pushNamed(
                          'newAppointment',
                          extra: list[index],
                        ),
                  ),
                ),
              ],
            ),
            5.hGap,
            Divider(color: AppColors.accent),
          ],
        ),
      ),
    ),
  ],
).padAll(AppPaddings.appPaddingInt);
