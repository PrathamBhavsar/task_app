import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/salon.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/action_button.dart';

final salons = Salon.sampleSalons;

class SalonScreen extends StatelessWidget {
  const SalonScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'Add Salon',
        style: AppTexts.labelTextStyle.copyWith(color: Colors.white),
      ),
      onPressed: () => context.pushNamed('newSalon'),
    ),
    appBar: AppBar(
      title: Text('Salon Management', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(
      child: _buildUI(context).padAll(AppPaddings.appPaddingInt),
    ),
  );

  Widget _buildUI(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Salon List", style: AppTexts.titleTextStyle),
      5.hGap,
      Text("Manage your salons", style: AppTexts.inputHintTextStyle),
      20.hGap,
      ...List.generate(
        3,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        salons[index].name,
                        style: AppTexts.headingTextStyle,
                      ),
                      Text(
                        salons[index].address,
                        style: AppTexts.inputHintTextStyle,
                      ),
                    ],
                  ),
                  salons[index].supervisor != null
                      ? Text(
                        salons[index].supervisor!,
                        style: AppTexts.inputHintTextStyle,
                      )
                      : SizedBox.shrink(),
                ],
              ),
              10.hGap,
              Row(
                children: [
                  Expanded(
                    child: ActionButton(label: 'QR Code', onPress: () {}),
                  ),
                  10.wGap,
                  Expanded(
                    child: ActionButton(
                      label: 'Edit',
                      onPress:
                          () => context.pushNamed(
                            'newSalon',
                            extra: salons[index],
                          ),
                    ),
                  ),
                  10.wGap,
                  Expanded(
                    child: ActionButton(
                      label: 'Archive',
                      fontColor: AppColors.errorRed,
                      onPress: () {},
                    ),
                  ),
                ],
              ),
              20.hGap,
              index != 2 ? Divider(color: AppColors.accent) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ],
  );
}
