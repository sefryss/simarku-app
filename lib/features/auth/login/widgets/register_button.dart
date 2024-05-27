import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/register/screen/register_page.dart';
import 'package:simarku/utils/global/app_config.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

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
            text: 'Daftar',
            style: TextStyle(color: AppColors.primary),
            // navigate to LoginRoute
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => RegisterPage());
                // Get.toNamed(Routes.register);
              },
          ),
        ],
      ),
    );
  }
}
