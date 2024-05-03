import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/forgot_password/fp_input_email/screen/fp_input_email_page.dart';
import 'package:simarku/utils/global/app_config.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Get.to(
          () => FPInputEmailPage(),
        ),
        child: Text(
          "Lupa Kata Sandi?",
          textAlign: TextAlign.end,
          style: AppTextStyle.body3Medium.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
