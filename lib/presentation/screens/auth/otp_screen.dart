import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: IntrinsicHeight(
          child: Center(
            child: Consumer<AuthProvider>(
              builder:
                  (context, provider, child) =>
                      provider.otpIndex == 0
                          ? _buildColumn(
                            subtitle: 'Enter your phone number to login',
                            label: 'Phone Number',
                            hintText: 'Enter your phone number',
                            controller: phoneController,
                            btnLabel: 'Send OTP',
                            onTap: () => provider.setOtpIndex(1),
                          )
                          : _buildColumn(
                            isOtp: true,
                            subtitle: 'Enter the OTP sent to your number',
                            label: 'One Time Password',
                            hintText: 'Enter the OTP',
                            controller: otpController,
                            btnLabel: 'Verify & Login',
                            onBack: () => provider.setOtpIndex(0),
                            onTap: () => context.pushReplacementNamed('home'),
                          ),
            ),
          ),
        ),
      ),
    ),
  );
  Widget _buildColumn({
    required String subtitle,
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isOtp = false,
    required String btnLabel,
    required VoidCallback onTap,
    VoidCallback? onBack,
  }) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Salon Management',
        style: AppTexts.titleTextStyle.copyWith(
          fontSize: 30.sp,
          fontVariations: [FontVariation.weight(900)],
        ),
      ),
      10.hGap,
      Text(subtitle, style: AppTexts.subtitleTextStyle),
      30.hGap,
      Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: AppTexts.labelTextStyle),
      ),
      10.hGap,
      CustomTextField(
        controller: controller,
        hintTxt: hintText,
        keyboardType: TextInputType.number,
      ),
      10.hGap,
      isOtp
          ? Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'OTP sent to ${phoneController.text}',
              style: AppTexts.subtitleTextStyle,
            ),
          )
          : SizedBox.shrink(),
      ActionButton(
        backgroundColor: Colors.black,
        label: btnLabel,
        fontColor: Colors.white,
        onPress: onTap,
      ),

      isOtp
          ? Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ActionButton(
              backgroundColor: Colors.white,
              label: 'Change Phone Number',
              fontColor: Colors.black,
              onPress: onBack ?? () {},
            ),
          )
          : SizedBox.shrink(),
    ],
  ).padAll(AppPaddings.appPaddingInt);
}
