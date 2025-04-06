import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/services.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';

final services = Service.sampleServices;

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Service',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed: () => context.pushNamed('newService'),
    ),
    appBar: AppBar(
      title: Text('Service Management', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(child: _buildUI(context)),
  );

  Widget _buildUI(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Service List", style: AppTexts.titleTextStyle),
      5.hGap,
      Text("Manage your Services", style: AppTexts.inputHintTextStyle),
      20.hGap,
      _buildList(context, services),
    ],
  ).padAll(AppPaddings.appPaddingInt);
}

Widget _buildList(BuildContext context, List<Service> list) => Column(
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
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(list[index].name, style: AppTexts.headingTextStyle),
                      Text(
                        list[index].time,
                        style: AppTexts.inputHintTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    label: 'Edit',
                    onPress:
                        () =>
                            context.pushNamed('newService', extra: list[index]),
                  ),
                ),
                10.wGap,
                Expanded(
                  child: ActionButton(
                    label: 'Archive',
                    fontColor: AppColors.errorRed,
                    onPress:
                        () =>
                            context.pushNamed('newService', extra: list[index]),
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
