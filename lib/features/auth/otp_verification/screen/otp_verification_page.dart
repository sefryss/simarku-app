import 'package:flutter/material.dart';
import 'package:simarku/features/auth/otp_verification/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class OTPVerificationPage extends StatelessWidget {
  final OTPType pageType;

  const OTPVerificationPage({
    super.key,
    required this.pageType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OTPButton(
        pageType: pageType,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
          leading: SMBackButton(
        buttonColor: AppColors.primary,
      )),
      body: SafeArea(
        child: Stack(
          children: [
            SafeArea(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                children: [
                  Text(
                    pageType == OTPType.registerVertification
                        ? 'Verifikasi Email'
                        : 'OTP Verifikasi',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heading5Bold
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Masukkan kode yang dikirim ke:',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body2Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                  Text(
                    'sefryudin@gmail.com',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body2Medium
                        .copyWith(color: AppColors.neutralBlack),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  OTPVerificationInput(),
                  const SizedBox(
                    height: 32.0,
                  ),
                  ResendingOTP(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
