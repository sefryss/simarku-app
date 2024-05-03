import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/login/screen/login_page.dart';

import '../../../utils/global/app_config.dart';

class OnboardingLoginButton extends StatelessWidget {
  const OnboardingLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyle.body3Regular,
        children: [
          TextSpan(
            text: 'Sudah Punya Akun? ',
            style: TextStyle(color: AppColors.grey),
          ),
          TextSpan(
              text: 'Masuk',
              style: TextStyle(color: AppColors.primary),
              // navigate to LoginRoute
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(() => LoginPage());
                }),
        ],
      ),
    );
  }
}
