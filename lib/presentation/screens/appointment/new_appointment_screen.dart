import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class NewAppointmentScreen extends StatefulWidget {
  const NewAppointmentScreen({super.key});

  @override
  State<NewAppointmentScreen> createState() => _NewAppointmentScreenState();
}

class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();

  void _onChanged(String key, String value) {
    final provider = Provider.of<AppointmentProvider>(context, listen: false);
    switch (key) {
      case "Phone Number":
        return provider.phoneOnChanged(value);
      case "Full Name":
        return provider.nameOnChanged(value);
      default:
        return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    // phoneController.dispose();
    // nameController.dispose();
    // emailController.dispose();
    Provider.of<AppointmentProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      title: Text('New Appointment', style: AppTexts.titleTextStyle),
    ),
    body: SingleChildScrollView(
      child: Consumer<AppointmentProvider>(
        builder:
            (
              BuildContext context,
              AppointmentProvider provider,
              Widget? child,
            ) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Book an Appointment', style: AppTexts.titleTextStyle),
                5.hGap,
                Text(
                  'Enter customer details to book an appointment',
                  style: AppTexts.inputTextStyle,
                ),
                30.hGap,
                ...List.generate(DummyData.newAppointmentDetails.length, (
                  index,
                ) {
                  final detail = DummyData.newAppointmentDetails[index];
                  final bool isRadio = index == 3;
                  return Padding(
                    padding:
                        index == DummyData.newAppointmentDetails.length - 1
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(detail['title'], style: AppTexts.labelTextStyle),
                        !isRadio ? 10.hGap : SizedBox.shrink(),
                        isRadio
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.black,
                                      value: 'Male',
                                      groupValue: provider.selectedGender,
                                      onChanged: (value) {
                                        provider.setGender(value as String);
                                      },
                                    ),
                                    Text(
                                      'Male',
                                      style: AppTexts.inputTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.black,
                                      value: 'Female',
                                      groupValue: provider.selectedGender,
                                      onChanged: (value) {
                                        provider.setGender(value as String);
                                      },
                                    ),
                                    Text(
                                      'Female',
                                      style: AppTexts.inputTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.black,
                                      value: 'Other',
                                      groupValue: provider.selectedGender,
                                      onChanged: (value) {
                                        provider.setGender(value as String);
                                      },
                                    ),
                                    Text(
                                      'Other',
                                      style: AppTexts.inputTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : index == 4
                            ? CustomDropdownMenu(
                              items: ['1', '2', '3', '4'],
                              onChanged: (value) => provider.setPersons(value),
                            )
                            : CustomTextField(
                              hintTxt: detail['hint'],
                              onChangedFunc:
                                  (value) => _onChanged(detail['title'], value),
                            ),
                      ],
                    ),
                  );
                }),
                20.hGap,
                ActionButton(
                  label: 'Complete Booking',
                  onPress: () {},
                  backgroundColor: Colors.black,
                  fontColor: Colors.white,
                ),
                10.hGap,
                Divider(color: AppColors.accent),
                10.hGap,
                Text('Booking Summary', style: AppTexts.titleTextStyle),
                10.hGap,
                ...List.generate(
                  DummyData.newAppointmentSummaryTitles.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DummyData.newAppointmentSummaryTitles[index],
                        style: AppTexts.subtitleTextStyle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        provider.summaryValues[index],
                        style: AppTexts.subtitleTextStyle.copyWith(
                          fontVariations: [FontVariation.weight(700)],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).padAll(AppPaddings.appPaddingInt),
      ),
    ),
  );
}
